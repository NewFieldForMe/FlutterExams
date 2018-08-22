import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class FirebaseChatPage extends StatefulWidget {
  FirebaseApp app;
  @override
  _FirebaseChatPageState createState() => new _FirebaseChatPageState();
}

class _FirebaseChatPageState extends State<FirebaseChatPage> {
  final _mainReference = FirebaseDatabase.instance.reference().child("messages");
  final _textEditController = TextEditingController();

  List<ChatEntry> entries = new List();

  @override
  initState() {
    super.initState();
    _mainReference.onChildAdded.listen(_onEntryAdded);
  }

  _onEntryAdded(Event e) {
    setState(() {
      entries.add(new ChatEntry.fromSnapShot(e.snapshot));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Firebase Chat")
      ),
      body: Container(
        child: new Column(
          children: <Widget>[
            Expanded(
              child: 
              ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (BuildContext context, int index) {
                  return _buildRow(index);
                },
                itemCount: entries.length,
              ),
            ),
            Divider(height: 4.0,),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildInputArea()
            )
          ],
        )
      ),
    );
  }

  Widget _buildRow(int index) {
    return Card(
      child: ListTile(
        title: Text(entries[index].message)
      )
    );
  }

  Widget _buildInputArea() {
    return Row(
      children: <Widget>[
        SizedBox(width: 16.0,),
        Expanded(
          child: TextField(
            controller: _textEditController,
          ),
        ),
        CupertinoButton(
          child: Text("Send"),
          onPressed: () {
            _mainReference.push().set(ChatEntry(DateTime.now(), _textEditController.text).toJson());
            _textEditController.clear();
            // キーボードを閉じる
            FocusScope.of(context).requestFocus(new FocusNode());
          },
        )
      ],
    );
  }
}

class ChatEntry {
  String key;
  DateTime dateTime;
  String message;

  ChatEntry(this.dateTime, this.message);

  ChatEntry.fromSnapShot(DataSnapshot snapshot):
    key = snapshot.key,
    dateTime = new DateTime.fromMillisecondsSinceEpoch(snapshot.value["date"]),
    message = snapshot.value["message"];

  toJson() {
    return {
      "date": dateTime.millisecondsSinceEpoch,
      "message": message,
    };
  }
}