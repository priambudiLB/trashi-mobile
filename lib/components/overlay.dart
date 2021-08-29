import 'package:flutter/material.dart';
import 'package:trashi/utils/commons.dart';

class OverlayTemplate extends StatelessWidget {
  OverlayTemplate({this.child, this.height = 180});

  final Widget child;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(70,70,70,0.44),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
                color: hexToColor('#ffffff'),
                borderRadius: BorderRadius.circular(16)
            ),
            child: Padding(
              padding: EdgeInsets.all(32),
              child: child
            )
          ),
        ),
      )
    );
  }
}
