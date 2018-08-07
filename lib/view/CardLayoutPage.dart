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
                      "Neko is So cute.",
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
          '''
ねこはとてもかわいい。ねこはめちゃくちゃかわいい。ひるまはずっと寝ています。ゆうがたぐらいに起きてきます。よるは遊びまわっています。おやつをもらう時だけすり寄ってきます。だきあげるとおこられます。お風呂場へ連れて行くとこの世の終わりのようななきかたをします。私が寝ていると上に乗ってきます。時々、うなされます。
          '''
        ),
      ),
    );
  }
}
