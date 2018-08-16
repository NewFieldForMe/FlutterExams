import 'package:flutter/material.dart';
import 'package:flutter_exams/enums.dart';
import 'package:flutter_exams/view/CardLayoutPage.dart';
import 'package:flutter_exams/view/ScrollViewPage.dart';
import 'package:flutter_exams/view/MethodChannelPage.dart';
import 'package:flutter_exams/view/MapViewPage.dart';
import 'package:flutter_exams/view/ToptabPage.dart';
import 'package:flutter_exams/view/StackLayoutPage.dart';
import 'package:flutter_exams/view/SliverLayoutPage.dart';
import 'package:flutter_exams/view/RowAndColumnPage.dart';
import 'package:flutter_exams/view/NestedScrollViewPage.dart';
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
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          print(widget.presenter.examples[index].exampleType);
          switch (widget.presenter.examples[index].exampleType) {
            case ExampleEnum.cardLayout:
              return CardLayoutPage();
              break;
            case ExampleEnum.scrollView:
              return ScrollViewPage();
              break;
            case ExampleEnum.methodChannel:
              return MethodChannelPage();
              break;
            case ExampleEnum.map:
              return MapViewPage();
              break;
            case ExampleEnum.topTab:
              return TopTabPage();
              break;
            case ExampleEnum.stack:
              return StackLayoutPage();
              break;
            case ExampleEnum.sliver:
              return SliverLayoutPage();
              break;
            case ExampleEnum.rowAndColoumn:
              return RowAndColumnPage();
              break;
            case ExampleEnum.nestedScrollView:
              return NestedScrollViewPage();
              break;
            default:
              return CardLayoutPage();
          }
        }));
      },
    ));
  }
}
