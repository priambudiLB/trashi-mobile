import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/utils/commons.dart';

class UPSTScreen extends StatefulWidget {
  static const String PATH = "home";

  @override
  _UPSTScreenState createState() => _UPSTScreenState();
}

class _UPSTScreenState extends State<UPSTScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            height: screenHeight,
            child: Stack(
              children: [
                MapSample(),
                GeneralInformationTrash(screenWidth: screenWidth)
              ],
            )));
  }
}

class GeneralInformationTrash extends StatelessWidget {
  const GeneralInformationTrash({
    Key key,
    @required this.screenWidth,
  }) : super(key: key);

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        child: Container(
          height: 200,
          width: screenWidth,
          decoration: BoxDecoration(
              color: hexToColor(MAIN_COLOR),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Image.asset("assets/images/caution-image.png")),
                    Container(
                      width: 8,
                    ),
                    Text(
                      "Peringatan",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: 1,
                          color: hexToColor(COLOR_YELLOW)),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150,
                        padding: EdgeInsets.only(
                            top: 4, bottom: 4, left: 12, right: 12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Text(
                              "2",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: hexToColor(COLOR_RED)),
                            ),
                            Text(
                              "Tumpukan Sampah",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("data"))
                          ],
                        ),
                      ),
                      Container(
                        width: 150,
                        padding: EdgeInsets.only(
                            top: 4, bottom: 4, left: 12, right: 12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Text(
                              "2",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: hexToColor(COLOR_RED)),
                            ),
                            Text(
                              "Emisi Tinggi",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-6.2339227, 106.8387889),
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
            position: LatLng(-6.201247, 106.8436123)));
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
