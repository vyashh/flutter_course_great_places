import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';
import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation intitialLocation;
  final bool isSelecting;

  MapScreen(
      {this.intitialLocation =
          const PlaceLocation(latitude: 52.3676, longitude: 4.9041),
      this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectPlace(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your map'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
                icon: Icon(Icons.check),
                onPressed: _pickedLocation == null
                    ? null
                    : () {
                        Navigator.of(context).pop(_pickedLocation);
                      })
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.intitialLocation.latitude,
              widget.intitialLocation.longitude),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectPlace : null,
        markers: _pickedLocation == null
            ? null
            : {
                Marker(markerId: MarkerId('m1'), position: _pickedLocation),
              },
      ),
    );
  }
}
