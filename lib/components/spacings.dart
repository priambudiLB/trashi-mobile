import 'package:flutter/material.dart';

class Spacings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  static Padding verticalSpace(double space) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: space,
      ),
    );
  }

  static Padding horizontalSpace(double space) {
    return Padding(
      padding: EdgeInsets.only(
        right: space,
      ),
    );
  }
}
