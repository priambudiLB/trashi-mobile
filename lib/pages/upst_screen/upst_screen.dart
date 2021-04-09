import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UPSTScreen extends StatefulWidget {
  static const String PATH = "home";

  @override
  _UPSTScreenState createState() => _UPSTScreenState();
}

class _UPSTScreenState extends State<UPSTScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBarEmpty(),
        body: MapSample()
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-6.2339227,106.8387889),
    zoom: 11,
  );

  // List for storing markers
  List<Marker> allMarkers = [];

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), 'assets/images/jakarta.png')
        .then((onValue) {
      setState(() {
        // add marker
        allMarkers.add(Marker(
            markerId: MarkerId('Jakarta'),
            draggable: false,
            icon: onValue,
            position: LatLng(-6.201247,106.8436123)
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        markers: Set.from(allMarkers),
        mapType: MapType.normal,
        tiltGesturesEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialPosition,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}