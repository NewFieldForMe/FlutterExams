import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_exams/model/GithubRepository.dart';

class CallAPIPage extends StatefulWidget {
  @override
  _CallAPIPageState createState() => new _CallAPIPageState();
}

class _CallAPIPageState extends State<CallAPIPage> {
  List<GithubRepository> _repositories = [];

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
            _searchRepositories(inputString).then((repositories) {
              setState(() {
                _repositories = repositories;
              });
            });
          }
        },
      )
    );
  }

  Widget _buildRepositoryList() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final repository = _repositories[index];
        return _buildCard(repository);
      },
      itemCount: _repositories.length,
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

  Future<List<GithubRepository>> _searchRepositories(String searchWord) async {
    final response = await http.get('https://api.github.com/search/repositories?q=' + searchWord + '&sort=stars&order=desc');
    if (response.statusCode == 200) {
      List<GithubRepository> list = [];
      Map<String, dynamic> decoded = json.decode(response.body);
      for (var item in decoded['items']) {
        list.add(GithubRepository.fromJson(item));
      }
      return list;
    } else {
      throw Exception('Fail to search repository');
    }
  }
}
