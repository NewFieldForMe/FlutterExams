import 'package:flutter/material.dart';
import 'package:flutter_exams/presenter/ExampleListPagePresenter.dart';
import 'package:flutter_exams/view/ExampleListPage.dart';
import 'package:map_view/map_view.dart';

void main() {
  MapView.setApiKey("your_api_key");
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Examples',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new ExampleListPage(
          title: 'Flutter Examples Home',
          presenter: ExampleListPagePresenter()),
    );
  }
}
