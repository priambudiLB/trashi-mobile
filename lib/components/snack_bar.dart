import 'package:flutter/material.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/utils/commons.dart';

SnackBar buildErrorSnackBar({
  String message,
}) {
  if (message == null) {
    message = 'Terjadi kesalahan. Silakan coba beberapa saat lagi.';
  }

  return buildTrashiSnackBar(
    message: message,
    backgroundColor: hexToColor('#B00020'),
    textColor: Colors.white,
  );
}

SnackBar buildSuccessSnackBar({
  String message,
}) {
  if (message == null) {
    message = 'Sukses';
  }

  return buildTrashiSnackBar(
    message: message,
    backgroundColor: hexToColor(MAIN_COLOR),
    textColor: Colors.white,
  );
}

SnackBar buildTrashiSnackBar({
  String message,
  Color backgroundColor,
  Color textColor,
}) {
  return SnackBar(
    content: Text(
      message,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
    ),
    backgroundColor: backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(8),
      ),
    ),
    duration: Duration(seconds: 3),
  );
}
