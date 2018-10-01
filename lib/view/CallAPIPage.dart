import 'package:flutter/material.dart';

class CallAPIPage extends StatefulWidget {
  @override
  _CallAPIPageState createState() => new _CallAPIPageState();
}

class _CallAPIPageState extends State<CallAPIPage> {
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
        },
      )
    );
  }

  Widget _buildRepositoryList() {
    return ListView.builder(
      itemExtent: 160.0,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          child: Text(index.toString())
        ,);
      }
    );
  }
}
