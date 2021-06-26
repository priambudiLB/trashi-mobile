import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trashi/components/button.dart';
import 'package:trashi/components/form.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/components/spacings.dart';
import 'package:trashi/constants/account_types.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/pages/registration_screen/components/document_upload_button.dart';
import 'package:trashi/utils/commons.dart';

class RegistrationScreen extends StatefulWidget {
  static const String PATH = "registration";

  final String accountType;

  const RegistrationScreen({Key key, this.accountType}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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

  _buildDocumentButtons(String accountType) {
    switch (accountType) {
      case accountTypeGovernment:
        return _buildAccountDocumentButtons(_requiredDocumentLabelsGovernment);
      case accountTypeCompany:
        return _buildAccountDocumentButtons(_requiredDocumentLabelsCompany);
      case accountTypePublic:
        return _buildAccountDocumentButtons(_requiredDocumentLabelsPublic);
      case accountTypeRTRW:
        return _buildAccountDocumentButtons(_requiredDocumentLabelsRTRW);
    }
  }

  _buildAccountDocumentButtons(List<String> labels) {
    List<Widget> _children = [];

    for (var i = 0; i < labels.length; i++) {
      _children.add(
        DocumentUploadButton(labelText: labels[i]),
      );

      _children.add(
        Padding(
          padding: EdgeInsets.only(bottom: 12),
        ),
      );
    }

    return Column(
      children: _children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Registrasi sebagai ${widget.accountType}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Mohon untuk mengisi data-data di bawah ini dengan benar dan lengkap untuk mempermudah tim kami memvalidasi akun Anda.",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
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
                      TrashiTextFormField(
                        keyboardType: TextInputType.text,
                        label: 'Name',
                      ),
                      Spacings.verticalSpace(12),
                      TrashiTextFormField(
                        keyboardType: TextInputType.phone,
                        label: 'Phone Number',
                      ),
                      Spacings.verticalSpace(12),
                      TrashiTextFormField(
                        keyboardType: TextInputType.text,
                        label: 'Password',
                        isPasswordField: true,
                      ),
                      Spacings.verticalSpace(12),
                      TrashiTextFormField(
                        keyboardType: TextInputType.text,
                        label: 'Confirm Password',
                        isPasswordField: true,
                      ),
                      Spacings.verticalSpace(12),
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Kelengkapan Dokumen",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                ),
                Container(
                  child: Column(
                    children: [
                      _buildDocumentButtons(widget.accountType),
                      Padding(
                        padding: EdgeInsets.only(bottom: 24),
                      ),
                      _buildRegisterButton(),
                      Padding(
                        padding: EdgeInsets.only(bottom: 28),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
