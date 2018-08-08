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
              _buildDescriptionArea()
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
                    margin: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      "Neko is So cute.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ),
                  Container(
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
              color: Colors.red,
            ),
            Text('41'),
          ],
        ));
  }

  Widget _buttonArea() {
    return Container(
        margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildButtonColumn(Icons.call, "CALL"),
            _buildButtonColumn(Icons.near_me, "ROUTE"),
            _buildButtonColumn(Icons.share, "SHARE")
          ],
        ));
  }

  Widget _buildButtonColumn(IconData icon, String label) {
    final color = Theme.of(context).primaryColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color),
          ),
        )
      ],
    );
  }

  Widget _buildDescriptionArea() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        child: Text('''
The Neko is very cute. The Neko is super cute. Neko has been sleeping during the day time. She gets up in the evening. she is playing around at night. She nestles up to me when I get a snack. She gets angly when I pick herup. She cries out like end of the world when I take her to the bathroom. When I am asleep she goes on. Therefore, sometimes, I can be apologized.
          '''),
      ),
    );
  }
}
