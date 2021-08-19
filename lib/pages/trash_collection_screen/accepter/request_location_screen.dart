import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/provider/provider.dart';

class RequestLocationScreen extends StatefulWidget {
  @override
  _RequestLocationScreenState createState() => _RequestLocationScreenState();
}

class _RequestLocationScreenState extends State<RequestLocationScreen> {
  Completer<GoogleMapController> _controller = Completer();
  bool isFirstTimeOpened = true;

  @override
  void dispose() {
    super.dispose();
  }

  void initState() {
    super.initState();
    context.read<TrashCollectionRequestDetailProvider>().isFetching = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<TrashCollectionRequestDetailProvider>().fetchDataMap();
    });
    context.read<TrashCollectionRequestDetailProvider>().isFetching = false;

    setState(() {
      isFirstTimeOpened = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<TrashCollectionRequestDetailProvider>().isFetching ||
            isFirstTimeOpened
        ? Layout(
            body: CircularProgressIndicator(),
          )
        : Scaffold(
            body: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  tiltGesturesEnabled: false,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      context
                          .watch<TrashCollectionRequestDetailProvider>()
                          .pengangkatan
                          .latitude,
                      context
                          .watch<TrashCollectionRequestDetailProvider>()
                          .pengangkatan
                          .longitude,
                    ),
                    zoom: 15,
                  ),
                  myLocationButtonEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: context
                      .watch<TrashCollectionRequestDetailProvider>()
                      .markers,
                ),
              ],
            ),
          );
  }
}
