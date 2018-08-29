import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';

class FirebaseChatPage extends StatefulWidget {
  @override
  _FirebaseChatPageState createState() => new _FirebaseChatPageState();
}

class _FirebaseChatPageState extends State<FirebaseChatPage> {
  /// 現在ログインしているユーザー
  FirebaseUser _user;
  final _googleSignIn = new GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  final _mainReference =
      FirebaseDatabase.instance.reference().child("messages");
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
        title: new Text("Firebase Chat"),
        actions: _buildAppBarActionButton()
      ),
      body: Container(
          child: _user == null ? _buildGoogleSignInButton() : _buildChatArea()),
    );
  }

  List<Widget> _buildAppBarActionButton() {
    return _user == null ? null :
      <Widget>[
        MaterialButton(
          onPressed: () {
            StatelessWidget dialog;
            dialog = Platform.isIOS ? 
            _buildSignOutDialogiOS() 
            : _buildSignOutDialogAndroid();

            showDialog(
              context: context,
              builder: (context) {
                return dialog;
              }
            );
          },
          child: Text(
            "SignOut",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white
            ),
          ),
        )
      ];
  }

  Widget _buildSignOutDialogAndroid() {
    return AlertDialog(
      title: Text("Confirm"),
      content: Text("Are you sure you want to Sign out?"),
      actions: <Widget>[
        FlatButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: const Text("SignOut"),
          onPressed: () { 
            Navigator.pop(context);
            _signOut(); 
          },
        )
      ]
    );
  }

  Widget _buildSignOutDialogiOS() {
    return CupertinoAlertDialog(
      title: Text("Confirm"),
      content: Text("Are you sure you want to Sign out?"),
      actions: <Widget>[
        CupertinoDialogAction(
          child: const Text("Cancel"),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: const Text("SignOut"),
          isDestructiveAction: true,
          onPressed: () { 
            Navigator.pop(context);
            _signOut(); 
          },
        )
      ]
    );
  }

  void _signOut() {
    _auth.signOut()
      .then((_) {
        setState(() {
          _user = null;
        });
      })
      .catchError((error) {
        print(error);
      });
  }

  /// GoogleLoginを実行するボタンのWidgetを作成する
  Widget _buildGoogleSignInButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
            child: RaisedButton(
          child: Text("Google Sign In"),
          onPressed: () {
            _handleGoogleSignIn().then((user) {
              setState(() {
                _user = user;
              });
            }).catchError((error) {
              print(error);
            });
          },
        )),
      ],
    );
  }

  /// チャットの内容を表示するWidgetを作成する
  Widget _buildChatArea() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (BuildContext context, int index) {
              return _buildRow(index);
            },
            itemCount: entries.length,
          ),
        ),
        Divider(
          height: 4.0,
        ),
        Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildInputArea())
      ],
    );
  }

  Widget _buildRow(int index) {
    ChatEntry entry = entries[index];
    return Container(
        margin: EdgeInsets.only(top: 8.0),
        child: _user.email == entry.userEmail
            ? _currentUserCommentRow(entry)
            : _otherUserCommentRow(entry));
  }

  Widget _currentUserCommentRow(ChatEntry entry) {
    return Row(children: <Widget>[
      Container(child: _avatarLayout(entry)),
      SizedBox(
        width: 16.0,
      ),
      new Expanded(child: _messageLayout(entry, CrossAxisAlignment.start)),
    ]);
  }

  Widget _otherUserCommentRow(ChatEntry entry) {
    return Row(children: <Widget>[
      new Expanded(child: _messageLayout(entry, CrossAxisAlignment.end)),
      SizedBox(
        width: 16.0,
      ),
      Container(child: _avatarLayout(entry)),
    ]);
  }

  Widget _messageLayout(ChatEntry entry, CrossAxisAlignment alignment) {
    return Column(
      crossAxisAlignment: alignment,
      children: <Widget>[
        Text(entry.userName,
            style: TextStyle(fontSize: 14.0, color: Colors.grey)),
        Text(entry.message)
      ],
    );
  }

  Widget _avatarLayout(ChatEntry entry) {
    return CircleAvatar(
      backgroundImage: NetworkImage(entry.userImageUrl),
    );
  }

  Widget _buildInputArea() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: TextField(
            controller: _textEditController,
          ),
        ),
        CupertinoButton(
          child: Text("Send"),
          onPressed: () {
            _mainReference.push().set(
                ChatEntry(DateTime.now(), _textEditController.text, _user)
                    .toJson());
            _textEditController.clear();
            // キーボードを閉じる
            FocusScope.of(context).requestFocus(new FocusNode());
          },
        )
      ],
    );
  }

  Future<FirebaseUser> _handleGoogleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("signed in " + user.displayName);
    return user;
  }
}

class ChatEntry {
  String key;
  DateTime dateTime;
  String message;
  String userName;
  String userEmail;
  String userImageUrl;

  ChatEntry(this.dateTime, this.message, FirebaseUser _user) {
    this.userName = _user.displayName;
    this.userEmail = _user.email;
    this.userImageUrl = _user.photoUrl;
  }

  ChatEntry.fromSnapShot(DataSnapshot snapshot)
      : key = snapshot.key,
        dateTime =
            new DateTime.fromMillisecondsSinceEpoch(snapshot.value["date"]),
        message = snapshot.value["message"],
        userName = snapshot.value["user_name"],
        userEmail = snapshot.value["user_email"],
        userImageUrl = snapshot.value["user_image_url"];

  toJson() {
    return {
      "date": dateTime.millisecondsSinceEpoch,
      "message": message,
      "user_name": userName,
      "user_email": userEmail,
      "user_image_url": userImageUrl,
    };
  }
}
