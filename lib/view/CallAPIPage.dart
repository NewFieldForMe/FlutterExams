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
      itemExtent: 160.0,
      itemBuilder: (BuildContext context, int index) {
        final repository = _repositories[index];
        return Card(
          margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          child: Text(repository.fullName.toString())
        ,);
      },
      itemCount: _repositories.length,
    );
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
