import 'package:flutter/material.dart';

class CardLayoutPage extends StatefulWidget {
  @override
  _CardLayoutPageState createState() => new _CardLayoutPageState();
}

class _CardLayoutPageState extends State<CardLayoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card Layout"),
      ),
      body: Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/neko1_600x400.jpg'),
          ],
        ),
      )
    );
  }
}