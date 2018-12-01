import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_exams/model/GithubRepository.dart';

class CallAPIBLoCPage extends StatefulWidget {
  final SearchGithubRepositoryBloc bloc;
  CallAPIBLoCPage({@required this.bloc});

  @override
  _CallAPIPageBLoCState createState() => new _CallAPIPageBLoCState();
}

class _CallAPIPageBLoCState extends State<CallAPIBLoCPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Call API Page"),
      ),
      body: _buildBody()
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _buildInput(),
        Expanded(child: _buildRepositoryList())
      ],
    );
  }

  Widget _buildInput() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Please enter a search repository name.',
          labelText: "search"
        ),
        onChanged: (inputString) {
          if (inputString.length >= 5) {
            widget.bloc.inSearchWord.add(inputString);
          }
        },
      )
    );
  }

  Widget _buildRepositoryList() {
    return StreamBuilder<List<GithubRepository>>(
      stream: widget.bloc.outSearchResultRepositories,
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<GithubRepository>> snapshot) {
        if (snapshot.hasError) {
          return Text('occur error...');
        }
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            final repository = snapshot.data[index];
            return _buildCard(repository);
          },
          itemCount: snapshot.data.length,
        );
      },
    );
  }

  Widget _buildCard(GithubRepository repository) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(12.0), 
            child: Text(
              repository.fullName,
              style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16.0
              ),
            ),
          ),
          repository.language != null ? Padding(
            padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            child: Text(
              repository.language,
              style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 12.0
              ),
            ),
          ) : Container(),
          repository.description != null ? Padding(
            padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            child: Text(
              repository.description,
              style: TextStyle(
                fontWeight: FontWeight.w200,
                color: Colors.grey
              )
            ),
          ) : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(Icons.star),
              SizedBox(
                width: 50.0,
                child: Text(repository.stargazersCount.toString()),
              ),
              Icon(Icons.remove_red_eye),
              SizedBox(
                width: 50.0,
                child: Text(repository.watchersCount.toString()),
              ),
              Text("Fork:"),
              SizedBox(
                width: 50.0,
                child: Text(repository.forksCount.toString()),
              ),
            ],
          ),
          SizedBox(height: 16.0,)
        ],
      )
    ,);
  }
}

class SearchGithubRepositoryBloc {
  List<GithubRepository> _searchResultRepositories = [];

  //
  // Stream to handle search words
  //
  StreamController<String> _searchWordController = StreamController<String>();
  StreamSink<String> get inSearchWord => _searchWordController.sink;

  //
  // Stream to handle repositories
  //
  StreamController<List<GithubRepository>> _searchRipositoryController = StreamController<List<GithubRepository>>();
  Stream<List<GithubRepository>> get outSearchResultRepositories => _searchRipositoryController.stream;

  SearchGithubRepositoryBloc() {
    _searchWordController.stream.listen(_searchRipository);
  }

  void _searchRipository(word) {
    _callAPISearchRepositories(word).then( (repositories) {
      _searchResultRepositories = repositories;
      _searchRipositoryController.sink.add(_searchResultRepositories);
    }).catchError( (error) {
      _searchRipositoryController.sink.addError(error);
    });
  }

  Future<List<GithubRepository>> _callAPISearchRepositories(String searchWord) async {
    final response = await http.get('https://api.github.com/search/repositories?q=' + searchWord + '&sort=stars&order=desc');
    try {
      if (searchWord == "tetris") { 
        return Future.error('search error words!!');
      }
      if (response.statusCode == 200) {
        List<GithubRepository> list = [];
        Map<String, dynamic> decoded = json.decode(response.body);
        for (var item in decoded['items']) {
          list.add(GithubRepository.fromJson(item));
        }
        return list;
      } else {
        return Future.error('Fail to search repository');
      }
    } catch (error) {
      print(error);
      return Future.error(error);
    }
  }

  void dispose() {
    _searchWordController.close();
    _searchRipositoryController.close();
  }
}