import 'package:flutter/material.dart';
import 'package:trashi/utils/commons.dart';

Text BuildTitleText(String text) {
  return Text(
    text,
    textAlign: TextAlign.end,
    style: TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w700,
      color: hexToColor('#FBD1A2'),
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

Text BuildSubtitleText(String text) {
  return Text(
    text,
    textAlign: TextAlign.end,
    style: TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600,
      color: hexToColor('#C4C4C4'),
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
