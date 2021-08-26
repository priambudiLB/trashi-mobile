import 'package:flutter/material.dart';
import 'package:trashi/components/button.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/pages/profile_screen_redesign/registration_document_confirmation/registration_document_confirmation.dart';
import 'package:trashi/utils/commons.dart';

class WaitingForDocumentConfirmationComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.access_time,
          size: 40,
          color: hexToColor("#CBCBCB"),
        ),
        Container(
          height: 20,
        ),
        Text(
          "Silakan cek notifikasi secara berkala di untuk\nmengetahui informasi terbaru dokumen\nAnda.",
          style: TextStyle(fontSize: 14, color: hexToColor("#909090")),
          textAlign: TextAlign.center,
        ),
        Container(
          height: 35,
        ),
        Button(
          onTap: () => Navigator.of(context)
              .pushNamed(RegistrationDocumentConfirmation.PATH),
          title: "Cek Status Konfirmasi Dokumen",
          width: MediaQuery.of(context).size.width,
          backgroundColor: Colors.white,
          fontColor: hexToColor(MAIN_COLOR),
          borderColor: hexToColor(MAIN_COLOR),
        )
      ],
    );
  }
}
