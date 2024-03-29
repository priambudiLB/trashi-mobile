import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:google_maps_webservice/places.dart';
import 'package:trashi/components/button.dart';
import 'package:trashi/components/routes.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/pages/form_request_pengangkatan/form_request_pengangkatan.dart';
import 'package:trashi/utils/commons.dart';
import 'package:trashi/pages/form_request_pengangkatan/provider.dart';
import 'package:provider/provider.dart';

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
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textDescriptionEditingController =
      TextEditingController();
  FocusNode _textFocusNode = FocusNode();
  FocusNode _textDescriptionFocusNode = FocusNode();

  @override
  void dispose() {
    _textFocusNode.dispose();
    _textDescriptionFocusNode.dispose();
    super.dispose();
  }

  void onError(PlacesAutocompleteResponse response) {
    print("error with respon ${response.errorMessage}");
  }

  void onAddMarkerButtonPressed(LatLng latlang) {
    context.read<FormRequestPengangkatanProvider>().setMarkers(
        {Marker(markerId: MarkerId(latlang.toString()), position: latlang)});
    context
        .read<FormRequestPengangkatanProvider>()
        .setSelectedLocation(latlang);
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FormRequestPengangkatanProvider>().fetchDataMap();
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentScope = FocusScope.of(context);

    return GestureDetector(
      onTap: () {
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: new Scaffold(
        body: Stack(
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
              markers: context.watch<FormRequestPengangkatanProvider>().markers,
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.only(right: 24, left: 24, top: 24, bottom: 32),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Container(
                        height: 16,
                      ),
                      context
                                  .watch<FormRequestPengangkatanProvider>()
                                  .selectedLocation !=
                              null
                          ? Text(context
                              .watch<FormRequestPengangkatanProvider>()
                              .selectedLocation
                              .toString())
                          : Container(),
                      Container(
                        height: 16,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              width: 1, color: hexToColor("#CBCBCB")),
                        ),
                        child: TextField(
                          focusNode: _textDescriptionFocusNode,
                          controller: _textDescriptionEditingController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Tulis Alamat Detail",
                            contentPadding: EdgeInsets.all(0),
                          ),
                        ),
                      ),
                      Container(
                        height: 16,
                      ),
                      Button(
                        onTap: () {
                          if (context
                                  .read<FormRequestPengangkatanProvider>()
                                  .selectedLocation !=
                              null) {
                            context
                                .read<FormRequestPengangkatanProvider>()
                                .setDescriptionLocation(
                                    _textDescriptionEditingController.text);
                            Navigator.pushReplacement(
                                context,
                                SlideLeftRoute(
                                    page: FormRequestPengangkatan()));
                          }
                        },
                        title: "Pilih Lokasi Ini",
                        width: double.infinity,
                        fontColor: context
                                    .watch<FormRequestPengangkatanProvider>()
                                    .selectedLocation !=
                                null
                            ? Colors.white
                            : hexToColor("#C4C4C4"),
                        backgroundColor: context
                                    .watch<FormRequestPengangkatanProvider>()
                                    .selectedLocation !=
                                null
                            ? hexToColor(MAIN_COLOR)
                            : Colors.grey[200],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
