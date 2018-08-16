import 'package:flutter/material.dart';

class StackLayoutPage extends StatefulWidget {
  @override
  _StackLayoutPageState createState() => new _StackLayoutPageState();
}

class _StackLayoutPageState extends State<StackLayoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Stack Layout"),
        ),
        body: _stack());
  }

  Widget _stack() {
    return Stack(
      children: <Widget>[
        new Container(
          decoration: BoxDecoration(
              image: new DecorationImage(
                  fit: BoxFit.fitWidth,
                  alignment: FractionalOffset.center,
                  image: new ExactAssetImage(
                    'assets/neko1_600x400.jpg',
                  ))),
        ),
        Positioned.fill(
          top: 50.0,
          child: Container(color: Color.fromRGBO(100, 100, 0, 0.7)),
        ),
        Positioned(
          top: 10.0,
          left: 10.0,
          right: 10.0,
          bottom: 10.0,
          child: Container(color: Color.fromRGBO(0, 100, 100, 0.6)),
        ),
        Align(
          alignment: new Alignment(0.25, 0.75),
          child: Text("align"),
        ),
        Center(
          child: Text("hoge"),
        ),
      ],
    );
  }
}
