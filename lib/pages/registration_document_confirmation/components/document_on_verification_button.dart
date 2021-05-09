import 'package:flutter/material.dart';
import 'package:trashi/components/button.dart';
import 'package:trashi/utils/commons.dart';

class DocumentOnVerificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Button(
      onTap: () {},
      title: "Sedang diverifikasi",
      width: double.infinity,
      backgroundColor: hexToColor("#F2F2F2"),
      fontColor: hexToColor("#C4C4C4"),
      borderColor: hexToColor("#DFDFDF"),
    );
  }
}
