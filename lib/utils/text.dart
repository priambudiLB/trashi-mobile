import 'package:flutter/material.dart';
import 'package:trashi/utils/commons.dart';

Text buildTitleText(String text, {String colorInHex = "#FBD1A2"}) {
  return Text(
    text,
    textAlign: TextAlign.end,
    style: TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w700,
      color: hexToColor(colorInHex),
      fontSize: 24,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(0.0, 4.0),
          blurRadius: 4.0,
          color: Color.fromRGBO(0, 0, 0, 0.25),
        ),
      ],
    ),
  );
}

Text buildSubtitleText(String text, {String colorInHex = "#C4C4C4"}) {
  return Text(
    text,
    textAlign: TextAlign.end,
    style: TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600,
      color: hexToColor(colorInHex),
      fontSize: 14,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(0.0, 4.0),
          blurRadius: 4.0,
          color: Color.fromRGBO(0, 0, 0, 0.25),
        ),
      ],
    ),
  );
}
