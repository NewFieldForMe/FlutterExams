import 'package:flutter/material.dart';
import 'package:flutter_exams/enums.dart';
import 'package:flutter_exams/view/CupertinoStylePage.dart';
import 'package:flutter_exams/view/CardLayoutPage.dart';
import 'package:flutter_exams/view/ScrollViewPage.dart';
import 'package:flutter_exams/view/MethodChannelPage.dart';
import 'package:flutter_exams/view/MapViewPage.dart';
import 'package:flutter_exams/view/ToptabPage.dart';
import 'package:flutter_exams/view/StackLayoutPage.dart';
import 'package:flutter_exams/view/SliverLayoutPage.dart';
import 'package:flutter_exams/view/RowAndColumnPage.dart';
import 'package:flutter_exams/view/NestedScrollViewPage.dart';
import 'package:flutter_exams/view/FirebaseChatPage.dart';
import 'package:flutter_exams/presenter/ExampleListPagePresenter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ExampleListPage extends StatefulWidget {
  final String title;
  final ExampleListPagePresenter presenter;
  ExampleListPage({Key key, this.title, this.presenter}) : super(key: key);

  @override
  _ExampleListPageState createState() => new _ExampleListPageState();
}

class _ExampleListPageState extends State<ExampleListPage> {
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

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
            case ExampleEnum.firebaseChat:
              return FirebaseChatPage();
              break;
            case ExampleEnum.cupertinoStyle:
              return CupertinoStylePage();
              break;
            default:
              return CardLayoutPage();
          }
        }));
      },
    ));
  }

  void _buildDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          content: new Text("Message: $message"),
          actions: <Widget>[
            new FlatButton(
              child: const Text('CLOSE'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            new FlatButton(
              child: const Text('SHOW'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      }
    );
  }

  @override
  void initState() {
    super.initState();
    _setupFirebaseMessaging();
  }

  void _setupFirebaseMessaging() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _buildDialog(context, "onMessage");
        // _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _buildDialog(context, "onLaunch");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _buildDialog(context, "onResume");
        // _navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
    });
    _firebaseMessaging.subscribeToTopic("/topics/all");
  }
}
