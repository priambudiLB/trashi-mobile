import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

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
                BottomContainer(screenWidth: screenWidth)
              ],
            )));
  }
}

class BottomContainer extends StatelessWidget {
  const BottomContainer({
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
          child: context.watch<UPST>().tpstSelected == null
              ? GarbageEmissionInformation()
              : UpstDetail(),
        ));
  }
}

class UpstDetail extends StatelessWidget {
  const UpstDetail({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      color: hexToColor("#15C711"), shape: BoxShape.circle)),
              Container(
                width: 8,
              ),
              Text(
                context.watch<UPST>().tpstSelected["name"],
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    letterSpacing: 1,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 135,
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: [
                      Image.asset(
                        "assets/images/upst-inactive.png",
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/images/beban.png",
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Container(
                                        width: 3,
                                      ),
                                      Text(
                                        "total\nweight",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 8),
                                      )
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    context
                                            .watch<UPST>()
                                            .tpstSelected["total_weight"]
                                            .toString() +
                                        " Kg",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/images/recycle.png",
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Container(
                                        width: 3,
                                      ),
                                      Text(
                                        "recycling\nrate",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 8),
                                      )
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    context
                                            .watch<UPST>()
                                            .tpstSelected["recycling_rate"]
                                            .toString() +
                                        " %",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/images/reducing.png",
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Container(
                                        width: 3,
                                      ),
                                      Text(
                                        "reducing\nrate",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 8),
                                      )
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    context
                                            .watch<UPST>()
                                            .tpstSelected["reducing_rate"]
                                            .toString() +
                                        " %",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 135,
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: [
                      Image.asset(
                        "assets/images/pabrik.png",
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("SO2"),
                            Text(
                              context
                                  .watch<UPST>()
                                  .tpstSelected["SO2"]
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w700),
                            ),
                            Text("mg/Nm3",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w700))
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("CO"),
                            Text(
                              context
                                  .watch<UPST>()
                                  .tpstSelected["CO"]
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w700),
                            ),
                            Text("mg/Nm3",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w700))
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("NOX"),
                            Text(
                              context
                                  .watch<UPST>()
                                  .tpstSelected["NOX"]
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w700),
                            ),
                            Text("mg/Nm3",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w700))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class GarbageEmissionInformation extends StatelessWidget {
  const GarbageEmissionInformation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(child: Image.asset("assets/images/caution-image.png")),
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
                  width: 140,
                  padding:
                      EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Text(
                        context
                            .watch<UPST>()
                            .listUpstWithGarbage
                            .length
                            .toString(),
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
                          child: context
                                      .watch<UPST>()
                                      .listUpstWithGarbage
                                      .length ==
                                  0
                              ? Center(
                                  child: Text("Tidak ada data"),
                                )
                              : Column(
                                  children: List.generate(
                                      context
                                          .watch<UPST>()
                                          .listUpstWithGarbage
                                          .length,
                                      (index) => Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 7),
                                                    height: 12,
                                                    width: 12,
                                                    decoration: BoxDecoration(
                                                        color: hexToColor(
                                                            COLOR_RED),
                                                        shape:
                                                            BoxShape.circle)),
                                                Text(
                                                  context
                                                          .watch<UPST>()
                                                          .listUpstWithGarbage[
                                                      index],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ],
                                            ),
                                          )),
                                ))
                    ],
                  ),
                ),
                Container(
                  width: 140,
                  padding:
                      EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Text(
                        context
                            .watch<UPST>()
                            .listUpstWithHighEmission
                            .length
                            .toString(),
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
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: context
                                      .watch<UPST>()
                                      .listUpstWithGarbage
                                      .length ==
                                  0
                              ? Center(
                                  child: Text("Tidak ada data"),
                                )
                              : Column(
                                  children: List.generate(
                                      context
                                          .watch<UPST>()
                                          .listUpstWithHighEmission
                                          .length,
                                      (index) => Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 7),
                                                    height: 12,
                                                    width: 12,
                                                    decoration: BoxDecoration(
                                                        color: hexToColor(
                                                            COLOR_RED),
                                                        shape:
                                                            BoxShape.circle)),
                                                Text(
                                                  context
                                                          .watch<UPST>()
                                                          .listUpstWithHighEmission[
                                                      index],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ],
                                            ),
                                          )),
                                ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
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
            onTap: () {
              if (context.read<UPST>().tpstSelected == null) {
                context.read<UPST>().setTpstSelected({
                  "name": "TPST Lubang Buaya",
                  "total_weight": 275,
                  "recycling_rate": 63.63,
                  "reducing_rate": 36.37,
                  "SO2": 50,
                  "CO": 330,
                  "NOX": 200
                });
              } else {
                context.read<UPST>().setTpstSelected(null);
              }
            },
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
