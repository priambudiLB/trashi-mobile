import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trashi/components/form.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/components/progress_indicator.dart';
import 'package:trashi/components/snack_bar.dart';
import 'package:trashi/components/spacings.dart';
import 'package:trashi/constants/account_types.dart';
import 'package:trashi/constants/colors.dart';
import 'package:trashi/pages/confirmation_otp_screen/confirmation_otp_screen.dart';
import 'package:trashi/pages/registration_screen/components/document_upload_button.dart';
import 'package:trashi/pages/registration_screen/provider/registration.dart';
import 'package:trashi/utils/commons.dart';
import 'package:provider/provider.dart';
import 'package:trashi/providers.dart';

class RegistrationScreen extends StatefulWidget {
  static const String PATH = "registration";

  final AccountType accountType;

  const RegistrationScreen({Key key, this.accountType}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _nameController;
  TextEditingController _phoneNumberController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;

  bool areAllDocumentsUploaded;

  void setAreAllDocumentsUploadedState(bool value) {
    setState(() {
      areAllDocumentsUploaded = value;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<SubmitDocumentOnRegistration>()
          .emptyAllRegistrationDocumentFiles();
      context.read<RegistrationProvider>().accountType = widget.accountType;
    });
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
          onPressed: () async {
            final _featureProvider =
                context.read<SubmitDocumentOnRegistration>();

            if (_featureProvider.areAllDocumentsUploaded(widget.accountType)) {
              setAreAllDocumentsUploadedState(true);
            } else {
              setAreAllDocumentsUploadedState(false);
              return;
            }

            if (_formKey.currentState.validate()) {
              showTrashiProgressIndicator(context);

              final signUpParam = SignUpParam(
                confirmPasswordController: _confirmPasswordController,
                emailController: _emailController,
                nameController: _nameController,
                passwordController: _passwordController,
                phoneNumberController: _phoneNumberController,
              );

              await context.read<RegistrationProvider>().signUp(signUpParam);

              if (!context.read<RegistrationProvider>().isSignUpSuccessful) {
                ScaffoldMessenger.of(context).showSnackBar(buildErrorSnackBar(
                  message: context.read<RegistrationProvider>().errorMessage,
                ));
                return;
              }

              await context
                  .read<RegistrationProvider>()
                  .uploadRegistrationDocuments(_featureProvider
                      .getDocumentsByAccountType(widget.accountType));

              await context
                  .read<RegistrationProvider>()
                  .generateVerificationCode();

              if (!context
                  .read<RegistrationProvider>()
                  .isGenerateVerificationCodeSuccessful) {
                ScaffoldMessenger.of(context).showSnackBar(buildErrorSnackBar(
                  message:
                      'Terjadi kesalahan dalam me-generate verification code. Silakan coba beberapa saat lagi.',
                ));
                return;
              }

              closeTrashiProgressIndicator(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfirmationOTPScreen(
                    account:
                        context.read<RegistrationProvider>().accountIdentifier(
                              _phoneNumberController,
                              _emailController,
                            ),
                    verification: widget.accountType.verification,
                  ),
                ),
              );
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

  Widget _buildAccountDocumentButtons() {
    List<Widget> _children = [];

    for (var i = 0;
        i < widget.accountType.shouldBeUploadedDocuments.length;
        i++) {
      _children.add(
        DocumentUploadButton(
          documentType: widget.accountType.shouldBeUploadedDocuments[i],
        ),
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
        controller: _phoneNumberController,
        validator: context.read<RegistrationProvider>().validatePhoneNumber,
      );
    }
    return TrashiTextFormField(
      keyboardType: TextInputType.text,
      label: 'Email',
      controller: _emailController,
      validator: context.read<RegistrationProvider>().validateEmail,
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
                          controller: _nameController,
                          validator:
                              context.read<RegistrationProvider>().validateName,
                        ),
                        Spacings.verticalSpace(12),
                        _buildIdentifierField(),
                        Spacings.verticalSpace(12),
                        TrashiTextFormField(
                          keyboardType: TextInputType.text,
                          label: 'Password',
                          isPasswordField: true,
                          controller: _passwordController,
                          validator: context
                              .read<RegistrationProvider>()
                              .validatePassword,
                        ),
                        Spacings.verticalSpace(12),
                        TrashiTextFormField(
                          keyboardType: TextInputType.text,
                          label: 'Confirm Password',
                          isPasswordField: true,
                          controller: _confirmPasswordController,
                          validator: (value) => context
                              .read<RegistrationProvider>()
                              .validateConfirmPassword(
                                value,
                                _passwordController,
                              ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAccountDocumentButtons(),
                      if (areAllDocumentsUploaded != null &&
                          !areAllDocumentsUploaded) ...[
                        Text(
                          'Semua dokumen harus diupload',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
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
