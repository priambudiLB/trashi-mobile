import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trashi/components/form.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/components/spacings.dart';
import 'package:trashi/constants/account_types.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/pages/confirmation_otp_screen/confirmation_otp_screen.dart';
import 'package:trashi/pages/registration_screen/components/document_upload_button.dart';
import 'package:trashi/pages/registration_screen/logics/registration.dart';
import 'package:trashi/utils/commons.dart';
import 'package:trashi/verification.dart';

class RegistrationScreen extends StatefulWidget {
  static const String PATH = "registration";

  final AccountType accountType;

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

  RegistrationLogic _logic;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _logic = RegistrationLogic(
      accountType: widget.accountType,
    );
  }

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
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              await _logic.signUp();
              print('jakh');

              if (_logic.isSignUpSuccessful) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationOTPScreen(
                      account: "089635",
                      verification: Verification.phone,
                    ),
                  ),
                );
              }
            }
          },
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

  Widget _buildDocumentButtons(AccountType accountType) {
    switch (accountType) {
      case AccountType.government:
        return _buildAccountDocumentButtons(_requiredDocumentLabelsGovernment);
      case AccountType.company:
        return _buildAccountDocumentButtons(_requiredDocumentLabelsCompany);
      case AccountType.RTRW:
        return _buildAccountDocumentButtons(_requiredDocumentLabelsRTRW);
      case AccountType.public:
      default:
        return _buildAccountDocumentButtons(_requiredDocumentLabelsPublic);
    }
  }

  Widget _buildAccountDocumentButtons(List<String> labels) {
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

  TrashiTextFormField _buildIdentifierField() {
    if (widget.accountType.shouldInputPhoneNumberToRegister) {
      return TrashiTextFormField(
        keyboardType: TextInputType.phone,
        label: 'Phone Number',
        controller: _logic.phoneNumberController,
        validator: _logic.validatePhoneNumber,
      );
    }
    return TrashiTextFormField(
      keyboardType: TextInputType.text,
      label: 'Email',
      controller: _logic.emailController,
      validator: _logic.validateEmail,
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
                    "Registrasi sebagai ${widget.accountType.text}",
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TrashiTextFormField(
                          keyboardType: TextInputType.text,
                          label: 'Name',
                          controller: _logic.nameController,
                          validator: _logic.validateName,
                        ),
                        Spacings.verticalSpace(12),
                        _buildIdentifierField(),
                        Spacings.verticalSpace(12),
                        TrashiTextFormField(
                          keyboardType: TextInputType.text,
                          label: 'Password',
                          isPasswordField: true,
                          controller: _logic.passwordController,
                          validator: _logic.validatePassword,
                        ),
                        Spacings.verticalSpace(12),
                        TrashiTextFormField(
                          keyboardType: TextInputType.text,
                          label: 'Confirm Password',
                          isPasswordField: true,
                          controller: _logic.confirmPasswordController,
                          validator: _logic.validateConfirmPassword,
                        ),
                        Spacings.verticalSpace(12),
                      ],
                    ),
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
