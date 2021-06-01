import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class LocationPickerForm extends StatefulWidget {
  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-6.2339227, 106.8387889),
    zoom: 15,
  );

  @override
  _LocationPickerFormState createState() => _LocationPickerFormState();
}

class _LocationPickerFormState extends State<LocationPickerForm> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              tiltGesturesEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: LocationPickerForm._initialPosition,
              myLocationButtonEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(right: 24, left: 24, top: 24, bottom: 32),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)),
                      color: Colors.white),
                  child: Column(
                    children: [],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
