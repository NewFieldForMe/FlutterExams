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

  Location userLocation;
  @override
  void initState() {
    super.initState();
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
    _mapView.onMapReady.listen((_) {
      if (userLocation != null) {
        _mapView.setCameraPosition(
          new CameraPosition(new Location(userLocation.latitude, userLocation.longitude), 14.0)
        );
      }
    });
    _mapView.onLocationUpdated.listen((location) {
      if (userLocation == null) {
        userLocation = location;
        _mapView.setCameraPosition(
          new CameraPosition(new Location(userLocation.latitude, userLocation.longitude), 14.0)
        );
      }
    });
  }
}