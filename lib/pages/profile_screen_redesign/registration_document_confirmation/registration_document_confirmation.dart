import 'package:flutter/material.dart';
import 'package:trashi/components/button.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/components/progress_indicator.dart';
import 'package:trashi/components/snack_bar.dart';
import 'package:trashi/components/spacings.dart';
import 'package:trashi/pages/profile_screen_redesign/registration_document_confirmation/components/document_on_verification_button_redesigned.dart';
import 'package:trashi/pages/profile_screen_redesign/registration_document_confirmation/provider.dart';
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
  bool isFirstTimeOpened = true;

  @override
  void initState() {
    super.initState();

    context.read<SubmitDocumentProvider>().emptyAllRegistrationDocumentFiles();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<SubmitDocumentProvider>().isFetching = true;
      await context
          .read<SubmitDocumentProvider>()
          .getFileLabelsToBeUploadedByUser();
      context.read<SubmitDocumentProvider>().isFetching = false;

      setState(() {
        isFirstTimeOpened = false;
      });
    });
  }

  Widget _buildAccountDocumentButtons() {
    final fileLabelsToBeUploaded =
        context.watch<SubmitDocumentProvider>().fileLabelsToBeUploaded;

    List<Widget> _children = [];

    for (var i = 0; i < fileLabelsToBeUploaded.length; i++) {
      _children.add(
        Text(
          "Foto " + fileLabelsToBeUploaded[i],
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: hexToColor("#4D4D4D")),
        ),
      );

      _children.add(Spacings.verticalSpace(8));

      _children.add(
        DocumentOnVerificationButtonRedesigned(
          label: fileLabelsToBeUploaded[i],
        ),
      );

      _children.add(
        Padding(
          padding: EdgeInsets.only(bottom: 12),
        ),
      );
    }

    if (fileLabelsToBeUploaded.length < 1) {
      _children.add(
        Text('Tidak ada dokumen yang perlu diupload.'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _children,
    );
  }

  Widget _buildSubmitButton() {
    return context
                .watch<SubmitDocumentProvider>()
                .fileLabelsToBeUploaded
                .length >
            0
        ? Button(
            onTap: () async {
              showTrashiProgressIndicator(context);

              await context
                  .read<SubmitDocumentProvider>()
                  .uploadVerificationDocuments();

              closeTrashiProgressIndicator(context);

              ScaffoldMessenger.of(context).showSnackBar(
                buildSuccessSnackBar(message: 'Berhasil mengupload dokumen.'),
              );
            },
            title: "Submit",
            width: double.infinity,
          )
        : SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<SubmitDocumentProvider>().isFetching ||
            isFirstTimeOpened
        ? Layout(
            body: CircularProgressIndicator(),
          )
        : Layout(
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
                      _buildAccountDocumentButtons(),
                      Spacings.verticalSpace(24),
                      _buildSubmitButton()
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
