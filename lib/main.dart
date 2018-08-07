import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Examples',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new ExampleListPage(title: 'Flutter Examples Home'),
    );
  }
}

class ExampleListPage extends StatefulWidget {
  ExampleListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ExampleListPageState createState() => new _ExampleListPageState();
}

class _ExampleListPageState extends State<ExampleListPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int index) { 
          return ListTile(
            title: Text('hoge')
          );
        },
        itemCount: 5,
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () { },
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
