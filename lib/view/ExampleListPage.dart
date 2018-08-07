import 'package:flutter/material.dart';
import 'package:flutter_exams/presenter/ExampleListPagePresenter.dart';

class ExampleListPage extends StatefulWidget {
  final String title;
  final ExampleListPagePresenter presenter;
  ExampleListPage({Key key, this.title, this.presenter}) : super(key: key);

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
      body: _buildListView(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext context, int index) {
        return _buildRow(index);
      },
      itemCount: widget.presenter.examples.length,
    );
  }

  Widget _buildRow(int index) {
    return Card(
      child: ListTile(
        title: Text(widget.presenter.examples[index].title),
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => SecondScreen()
            )
          );
        },
      )
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}