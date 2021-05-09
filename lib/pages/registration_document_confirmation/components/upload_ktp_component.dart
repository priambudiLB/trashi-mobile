import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:trashi/components/button.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/pages/registration_document_confirmation/components/document_on_verification_button.dart';
import 'package:trashi/providers.dart';
import 'package:trashi/status_upload.dart';
import 'package:trashi/utils/commons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:formz/formz.dart';

class UploadKtpComponent extends StatelessWidget {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    if (context
        .watch<SubmitDocumentVerification>()
        .statusFetchData
        .isSubmissionInProgress) {
      return SkeletonAnimation(
          child: Button(
              onTap: () {},
              title: "Loading",
              width: double.infinity,
              backgroundColor: Color.fromRGBO(114, 120, 151, 0.1)));
    }
    if (context.watch<SubmitDocumentVerification>().generalStatus ==
        StatusUpload.SUBMITTED) {
      return DocumentOnVerificationButton();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Button(
            onTap: () async {
              final pickedFile =
                  await picker.getImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                context
                    .read<SubmitDocumentVerification>()
                    .setKtpFile(File(pickedFile.path));
                context
                    .read<SubmitDocumentVerification>()
                    .setKtpStatus(StatusUpload.DRAFT);
              }
            },
            title: context.watch<SubmitDocumentVerification>().ktpStatus ==
                    StatusUpload.DRAFT
                ? "Ubah foto KTP"
                : "Upload foto KTP",
            backgroundColor: Colors.white,
            fontColor: hexToColor(MAIN_COLOR),
            borderColor: hexToColor(MAIN_COLOR),
            width: double.infinity,
          ),
          context.watch<SubmitDocumentVerification>().fileKtp != null &&
                  context.watch<SubmitDocumentVerification>().ktpStatus ==
                      StatusUpload.DRAFT
              ? Text(basename(
                  context.watch<SubmitDocumentVerification>().fileKtp.path))
              : Container(),
          context.watch<SubmitDocumentVerification>().ktpStatus ==
                  StatusUpload.FAILED
              ? Text(
                  "Foto Anda ditolak. Silakan upload kembali.",
                  style: TextStyle(
                      color: hexToColor("#ED7D31"),
                      fontStyle: FontStyle.italic),
                )
              : Container()
        ],
      );
    }
  }
}
