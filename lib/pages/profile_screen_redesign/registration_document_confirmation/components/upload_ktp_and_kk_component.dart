import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:trashi/components/button.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/pages/profile_screen_redesign/registration_document_confirmation/components/document_on_verification_button.dart';
import 'package:trashi/pages/profile_screen_redesign/registration_document_confirmation/provider.dart';
import 'package:trashi/pages/profile_screen_redesign/registration_document_confirmation/status_upload.dart';
import 'package:trashi/utils/commons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:formz/formz.dart';

class UploadKtpAndKkComponent extends StatefulWidget {
  @override
  _UploadKtpAndKkComponentState createState() =>
      _UploadKtpAndKkComponentState();
}

class _UploadKtpAndKkComponentState extends State<UploadKtpAndKkComponent> {
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
    } else if (context.watch<SubmitDocumentVerification>().generalStatus ==
        StatusUpload.SUBMITTED) {
      return DocumentOnVerificationButton();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Button(
            onTap: _showPickImageSource,
            title: context.watch<SubmitDocumentVerification>().ktpAndKkStatus ==
                    StatusUpload.DRAFT
                ? "Ubah foto bersama KTP dan KK"
                : "Upload foto bersama KTP dan KK",
            backgroundColor: Colors.white,
            fontColor: hexToColor(MAIN_COLOR),
            borderColor: hexToColor(MAIN_COLOR),
            width: double.infinity,
          ),
          context.watch<SubmitDocumentVerification>().fileKtpAndKK != null &&
                  context.watch<SubmitDocumentVerification>().ktpAndKkStatus ==
                      StatusUpload.DRAFT
              ? Text(Path.basename(context
                  .watch<SubmitDocumentVerification>()
                  .fileKtpAndKK
                  .path))
              : Container(),
          context.watch<SubmitDocumentVerification>().ktpAndKkStatus ==
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

  void _showPickImageSource() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Pilih sumber foto'),
        actions: <Widget>[
          TextButton(
            onPressed: () => _onTapUploadFromCamera(),
            child: const Text('Kamera'),
          ),
          TextButton(
            onPressed: () => _onTapUploadFromGallery(),
            child: const Text('Galeri'),
          ),
        ],
      ),
    );
  }

  void _onTapUploadFromGallery() async {
    final pickedFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      context
          .read<SubmitDocumentVerification>()
          .setKtpAndKkFile(File(pickedFile.path));
      context
          .read<SubmitDocumentVerification>()
          .setKtpAndKkStatus(StatusUpload.DRAFT);
      Navigator.of(context).pop();
    }
  }

  void _onTapUploadFromCamera() async {
    final pickedFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      context
          .read<SubmitDocumentVerification>()
          .setKtpAndKkFile(File(pickedFile.path));
      context
          .read<SubmitDocumentVerification>()
          .setKtpAndKkStatus(StatusUpload.DRAFT);
      Navigator.of(context).pop();
    }
  }
}
