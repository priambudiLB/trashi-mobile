import 'package:flutter/material.dart';
import 'package:trashi/components/snack_bar.dart';
import 'package:trashi/components/form.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:trashi/components/progress_indicator.dart';
import 'package:trashi/components/spacings.dart';
import 'package:trashi/http_request/api_provider.dart';
import 'package:trashi/http_request/models/auth.dart';
import 'package:trashi/http_request/models/errors.dart';
import 'package:trashi/pages/navbar_screen/bottom_navbar.dart';
import 'package:trashi/pages/registration_screen/account_type_selection_screen.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/components/row_button_wrapper.dart';
import 'package:trashi/secure_storage/secure_storage.dart';
import 'package:trashi/utils/commons.dart';

class LogInScreen extends StatefulWidget {
  static const String PATH = "logIn";

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController _emailOrPhoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isSignInSuccessful = false;

  final _formKey = GlobalKey<FormState>();

  bool isPhoneNumber(String text) {
    try {
      int.parse(text);
      return true;
    } on FormatException {
      return false;
    }
  }

  bool isEmail(String text) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text);
  }

  Future<void> _signIn() async {
    showTrashiProgressIndicator(context);

    if (_formKey.currentState.validate()) {}

    bool isError = false;
    String errorMessage;

    SecureStorage _secureStorage = SecureStorage();

    if (isPhoneNumber(_emailOrPhoneNumberController.text)) {
      SignInByPhoneRequest body = SignInByPhoneRequest(
        password: _passwordController.text,
        phone: _emailOrPhoneNumberController.text,
      );

      final response = await ApiProvider().signInByPhone(body);

      if (ApiProvider.isStatusCodeOK(response.statusCode)) {
        isSignInSuccessful = true;

        final signInByPhoneResponse =
            SignInByPhoneResponse.fromJson(response.data);

        await _secureStorage.setSignInByPhoneResponse(signInByPhoneResponse);
      } else {
        isError = true;

        final errorResponse = ErrorResponse.fromJson(response.data);
        errorMessage = errorResponse.errorMessage;
      }
    } else if (isEmail(_emailOrPhoneNumberController.text)) {
      SignInRequest body = SignInRequest(
        email: _emailOrPhoneNumberController.text,
        password: _passwordController.text,
      );

      final response = await ApiProvider().signIn(body);

      if (ApiProvider.isStatusCodeOK(response.statusCode)) {
        isSignInSuccessful = true;

        final signInResponse = SignInResponse.fromJson(response.data);

        await _secureStorage.setSignInResponse(signInResponse);
      } else {
        isError = true;

        final errorResponse = ErrorResponse.fromJson(response.data);
        errorMessage = errorResponse.errorMessage;
      }
    }

    if (isError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(buildErrorSnackBar(message: errorMessage));
    }

    closeTrashiProgressIndicator(context);
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      color: hexToColor("#4C4C4C"),
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                  Spacings.verticalSpace(12),
                  Text(
                    "Please login to continue",
                    style: TextStyle(
                      color: hexToColor("#909090"),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  Spacings.verticalSpace(24),
                  TrashiTextFormField(
                    controller: _emailOrPhoneNumberController,
                    label: "Email or phone number",
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Email atau nomor telepon tidak boleh kosong';
                      }

                      if (!isPhoneNumber(value) && !isEmail(value)) {
                        return 'Harus salah satu di antara email atau nomor telepon';
                      }
                    },
                  ),
                  Spacings.verticalSpace(12),
                  TrashiTextFormField(
                    controller: _passwordController,
                    label: "Password",
                    keyboardType: TextInputType.text,
                    isPasswordField: true,
                  ),
                  Spacings.verticalSpace(8),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: hexToColor("#32A37F"),
                    ),
                  ),
                  onTap: () {
                    print("forgot password");
                  },
                ),
              ],
            ),
            Spacings.verticalSpace(16),
            RowButtonWrapper(
              backgroundColor: hexToColor("#32A37F"),
              foregroundColor: Colors.white,
              circularBorderRadius: 8,
              borderColor: hexToColor("#32A37F"),
              onPressed: () async {
                await _signIn();

                if (isSignInSuccessful) {
                  print('sign in');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavScreen(
                        navIndex: 2,
                        isVerified: true,
                      ),
                    ),
                  );
                }
              },
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              height: 48,
              padding: EdgeInsets.only(
                top: 14,
                bottom: 14,
              ),
            ),
            Spacings.verticalSpace(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "I'm a new user.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: hexToColor("#909090"),
                  ),
                ),
                Spacings.horizontalSpace(4),
                InkWell(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: hexToColor("#32A37F"),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountTypeSelectionScreen(),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
