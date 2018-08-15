import 'package:flutter/material.dart';

class RowAndColumnPage extends StatefulWidget {
  @override
  _RowAndColumnPageState createState() => new _RowAndColumnPageState();
}

class _RowAndColumnPageState extends State<RowAndColumnPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Row and Column"),
      ),
      body: 
      Row(children: <Widget>[
        Card(
          elevation: 4.0,
          color: Colors.blue,
          margin: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.star, size: 50.0,),
              Icon(Icons.star),
              SizedBox(height: 16.0),
              Icon(Icons.star)
            ],
          ),
        ),
        Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(16.0),
          child: IntrinsicWidth(child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              RaisedButton(
                onPressed: () {},
                child: Text('Short'),
              ),
              SizedBox(height: 16.0,),
              RaisedButton(
                onPressed: () {},
                child: Text('A bit Longer'),
              ),
              SizedBox(height: 16.0,),
              RaisedButton(
                onPressed: () {},
                child: Text('The Longest text button'),
              ),
            ],
          ),
        )
        )
      ]),
    );
  }
}
