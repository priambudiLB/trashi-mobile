import 'package:flutter/material.dart';
import 'package:trashi/components/button.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/pages/profile_screen_redesign/registration_document_confirmation/components/upload_kk_component.dart';
import 'package:trashi/pages/profile_screen_redesign/registration_document_confirmation/components/upload_ktp_and_kk_component.dart';
import 'package:trashi/pages/profile_screen_redesign/registration_document_confirmation/components/upload_ktp_component.dart';
import 'package:trashi/pages/profile_screen_redesign/registration_document_confirmation/provider.dart';
import 'package:trashi/pages/profile_screen_redesign/registration_document_confirmation/status_upload.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';

class RegistrationDocumentConfirmation extends StatefulWidget {
  static const String PATH = "registrasidocumentconfirmation";

  @override
  _RegistrationDocumentConfirmationState createState() =>
      _RegistrationDocumentConfirmationState();
}

class _RegistrationDocumentConfirmationState
    extends State<RegistrationDocumentConfirmation> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SubmitDocumentVerification>().fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: new RefreshIndicator(
        onRefresh: () async {
          context.read<SubmitDocumentVerification>().fetchData();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Status Konfirmasi Dokumen",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: hexToColor("#4D4D4D")),
                ),
                Container(
                  height: 24,
                ),
                Text(
                  "Foto KTP",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: hexToColor("#4D4D4D")),
                ),
                Container(
                  height: 8,
                ),
                UploadKtpComponent(),
                Container(
                  height: 16,
                ),
                Text(
                  "Foto KK",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: hexToColor("#4D4D4D")),
                ),
                Container(
                  height: 8,
                ),
                UploadKkComponent(),
                Container(
                  height: 16,
                ),
                Text(
                  "Foto bersama KTP dan KK",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: hexToColor("#4D4D4D")),
                ),
                Container(
                  height: 8,
                ),
                UploadKtpAndKkComponent(),
                Container(
                  height: 60,
                ),
                context.watch<SubmitDocumentVerification>().generalStatus !=
                        StatusUpload.SUBMITTED
                    ? Button(
                        onTap: () {
                          context
                              .read<SubmitDocumentVerification>()
                              .setGeneralStatus(StatusUpload.SUBMITTED);
                        },
                        title: "Submit",
                        width: double.infinity,
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
