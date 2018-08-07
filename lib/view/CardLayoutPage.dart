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
              _titleArea(),
              _buttonArea(),
              _buildTextArea()
            ],
          ),
        ));
  }

  Widget _titleArea() {
    return Container(
        margin: EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(4.0),
                    child: Text(
                      "Mi-San is So cute.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(4.0),
                    child: Text(
                      "Osaka, Japan",
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.star,
              color: Colors.red[500],
            ),
            Text('41'),
          ],
        ));
  }

  Widget _buttonArea() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildButtonColumn(Icons.call, "CALL"),
          _buildButtonColumn(Icons.near_me, "ROUTE"),
          _buildButtonColumn(Icons.share, "SHARE")
        ],
      )
    );
  }

  Widget _buildButtonColumn(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: Theme.of(context).primaryColor),
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).primaryColor
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTextArea() {
    return Expanded(
      child: Container( 
        margin: const EdgeInsets.all(16.0),
        child: Text(
          "Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run."
        ),
      ),
    );
  }
}
