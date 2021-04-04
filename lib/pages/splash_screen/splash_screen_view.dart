import 'package:flutter/material.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/utils/commons.dart';

class SplashScreenView extends StatelessWidget {
  // TODO: change with proper splash screen frontend
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor(MAIN_COLOR),
      body: Center(
        child: new Text("Ceritanya ini splash screen"),
      ),
    );
  }
}
