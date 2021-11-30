import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget{
  @override
  _MapScreenState createState()=>_MapScreenState();
}
class _MapScreenState extends State<MapScreen>{

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37,-122),
    zoom: 11.5,
  );

  GoogleMapController _googleMapController;

  @override
  void dispose(){
    _googleMapController.dispose();
    super.dispose();
  }

  Marker _origin;
  Marker _destination;
  String _locationData;
  var _location;

  var _newCameraPosition= CameraPosition(
    target: LatLng(30,-120),
    zoom: 11.5,);

  _updateLocation() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
      }
    }
    var locationData = await location.getLocation();
    _location = locationData;
    _locationData="Longitud ${locationData.longitude}. Latitude ${locationData.latitude} ";
    print(_locationData);
    var newPosition = CameraPosition(
        target: LatLng(locationData.latitude, locationData.longitude),
        zoom: 16);

    CameraUpdate update =CameraUpdate.newCameraPosition(newPosition);
    CameraUpdate zoom = CameraUpdate.zoomTo(16);

    _googleMapController.moveCamera(update);
  }

      @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SizedBox(
          width: 400,  // or use fixed size like 200
          height: 700,
          child : GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) =>_googleMapController= controller,
            markers:{
              if(_origin != null) _origin,
              if(_destination != null) _destination
            },
          )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed:(){
          _updateLocation();
          print("Pressed");
          ()=> _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(_initialCameraPosition)
          );
          print("After Moveg");
        },
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
