import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CupertinoStylePage extends StatefulWidget {
  @override
  _CupertinoStylePageState createState() => new _CupertinoStylePageState();
}

class _CupertinoStylePageState extends State<CupertinoStylePage> {
  Duration _timeDuration;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('Cupertino Style'),
      ),
      body: 
        Column(children: <Widget>[
          SizedBox(height: 16.0,),
          Row(children: <Widget>[
            Expanded(child: _buildCupertinoSegmentedControl(),)
            ],
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: Text(
              _timeDuration == null ? "select time" : _timeDuration.toString()),
          ),
          Expanded(child: _buildCupertinoTimerPicker(),)
        ],)
      );
  }

  Widget _buildCupertinoSegmentedControl() {
    return CupertinoSegmentedControl(
      children: {
        "1": Text("Action Sheet"),
        "2": Text("Picker"),
      },
      onValueChanged: (value) {
        if (value == "1") {
          showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) {
              return _buildCupertinoActionSheet(context);
            }
          );
        }
        if (value == "2") {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return CupertinoPicker(
                onSelectedItemChanged: (value) {},
                itemExtent: 30.0,
                children: <Widget>[
                  Center(child: Text("item 1")),
                  Center(child: Text("item 2")),
                  Center(child: Text("item 3")),
                  Center(child: Text("item 4")),
                  Center(child: Text("item 5")),
                ],
              );
            }
          );
        }
    },);
  }

  Widget _buildCupertinoActionSheet(BuildContext context) {
    return CupertinoActionSheet(
      title: Text("title"),
      message: Text("message"),
      actions: <Widget>[
        CupertinoActionSheetAction(child: Text("none"), onPressed: () { Navigator.pop(context); },),
        CupertinoActionSheetAction(child: Text("default action"), onPressed: () { Navigator.pop(context); }, isDefaultAction: true,),
        CupertinoActionSheetAction(child: Text("destructive action"), onPressed: () { Navigator.pop(context); }, isDestructiveAction: true,),
      ],
      cancelButton: CupertinoActionSheetAction(child: Text("Cancel"), onPressed: () { Navigator.pop(context); },),
    );
  }

  Widget _buildCupertinoTimerPicker() {
    return CupertinoTimerPicker(
      onTimerDurationChanged: (Duration newTimer) {
        setState(() {
          _timeDuration = newTimer;
        });
      }
    );
  }
}
