import 'package:flutter/material.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/utils/commons.dart';

final ThemeData modiAppDefaultTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Avenir',
  primaryColor: hexToColor(MAIN_COLOR),
  accentColor: hexToColor(MAIN_COLOR),
);

ThemeData get defaultTheme => modiAppDefaultTheme;
