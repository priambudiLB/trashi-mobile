import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trashi/components/button.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/utils/commons.dart';

class RegistrationAsRTRWScreen extends StatefulWidget {
  static const String PATH = "registrationAsRTRW";

  @override
  _RegistrationAsRTRWScreenState createState() =>
      _RegistrationAsRTRWScreenState();
}

class _RegistrationAsRTRWScreenState extends State<RegistrationAsRTRWScreen> {
  static const String ktpLabel = "Upload foto KTP";
  static const String kkLabel = "Upload foto KK";
  static const String withKKAndKTPLabel = "Upload foto bersama KTP dan KK";
  static const String officialDocumentLabel = "Upload foto dokumen resmi";
  static const String withOfficialDocumentLabel =
      "Upload foto bersama dokumen resmi";
  static const String businessLicenseDocumentLabel = "Upload foto izin usaha";
  static const String withBusinessLicenseDocumentLabel =
      "Upload foto bersama izin usaha";

  var _requiredDocumentLabelsRTRW = [
    ktpLabel,
    kkLabel,
    withKKAndKTPLabel,
  ];
  var _requiredDocumentLabelsPublic = [
    ktpLabel,
    kkLabel,
    withKKAndKTPLabel,
  ];
  var _requiredDocumentLabelsGovernment = [
    officialDocumentLabel,
    withOfficialDocumentLabel,
  ];
  var _requiredDocumentLabelsCompany = [
    businessLicenseDocumentLabel,
    withBusinessLicenseDocumentLabel,
  ];

  _buildTextFormField(TextInputType keyboardType, String label,
      {bool obscureText = false}) {
    TextFormField textFormField = TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.fromLTRB(16, 14, 16, 15),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );

    return Column(
      children: [
        Container(
          height: 48,
          child: textFormField,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 12),
        ),
      ],
    );
  }

  void _onTapUploadDocument() async {
    FilePicker.platform.pickFiles();
  }

  _buildDocumentButton(String label) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          color: hexToColor(MAIN_COLOR),
        ),
      ),
      child: ButtonTheme(
        minWidth: double.infinity,
        height: 48,
        child: MaterialButton(
          onPressed: () => _onTapUploadDocument(),
          child: Text(
            label,
            style: TextStyle(
              color: hexToColor(MAIN_COLOR),
            ),
          ),
        ),
      ),
    );
  }

  _buildRegisterButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: hexToColor(MAIN_COLOR),
      ),
      child: ButtonTheme(
        minWidth: double.infinity,
        height: 48,
        child: MaterialButton(
          onPressed: () {},
          child: Text(
            "Registrasi",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _buildRTRWDocumentButtons() {
    return Column(
      children: [
        _buildDocumentButton(
          "Upload foto KTP",
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 12),
        ),
        _buildDocumentButton(
          "Upload foto KK",
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 12),
        ),
        _buildDocumentButton(
          "Upload foto bersama KTP dan KK",
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 24),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Container(
        child: Column(
          children: [
            Text(
              "Registrasi sebagai RT/RW",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              "Mohon untuk mengisi data-data di bawah ini dengan benar dan lengkap untuk mempermudah tim kami memvalidasi akun Anda.",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 16,
              ),
            ),
            Container(
              child: Column(
                children: [
                  _buildTextFormField(
                    TextInputType.text,
                    "Name",
                  ),
                  _buildTextFormField(
                    TextInputType.phone,
                    "Phone Number",
                  ),
                  _buildTextFormField(
                    TextInputType.text,
                    "Password",
                    obscureText: true,
                  ),
                  _buildTextFormField(
                    TextInputType.text,
                    "Confirm Password",
                    obscureText: true,
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: hexToColor(COLOR_INACTIVE_GREY),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 24),
            ),
            Text(
              "Kelengkapan Dokumen",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16),
            ),
            Container(
              child: Column(
                children: [
                  _buildRTRWDocumentButtons(),
                  _buildRegisterButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
