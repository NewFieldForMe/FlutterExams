import 'package:flutter/material.dart';

class TopTabPage extends StatefulWidget {
  @override
  _TopTabPageState createState() => new _TopTabPageState();
}

class _TopTabPageState extends State<TopTabPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: TabBar(
              tabs: [
                new Tab(text: "swift"),
                new Tab(text: "kotlin"),
                new Tab(text: "dart"),
              ],
            ),
          ),
          title: Text('Tabs Demo'),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
