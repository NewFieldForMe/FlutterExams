import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

class MapViewPage extends StatefulWidget {
  @override
  _MapViewPageState createState() => new _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  var _mapView = MapView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              child: Text('Show Map modal.'),
              onPressed: () { _showMap(); },
            ),
          ],
        ),
      ),
    );
  }

  void _showMap() {
    _mapView.show(new MapOptions(
      showUserLocation: true, 
      hideToolbar: false,
      showMyLocationButton: true,
      showCompassButton: true,
      ),
      toolbarActions: [new ToolbarAction("Close", 1)]
    );
    _mapView.onToolbarAction.listen((id) {
      if (id == 1) { 
        _mapView.dismiss();
      }
    });
  }
}