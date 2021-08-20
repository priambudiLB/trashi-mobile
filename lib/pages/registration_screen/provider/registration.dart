import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trashi/constants/account_types.dart';
import 'package:trashi/http_request/api_provider.dart';
import 'package:trashi/http_request/models/auth.dart';
import 'package:trashi/http_request/models/errors.dart';
import 'package:trashi/models/trashi_document.dart';
import 'package:trashi/secure_storage/secure_storage.dart';
import 'package:dio/dio.dart';

class RegistrationProvider with ChangeNotifier, DiagnosticableTreeMixin {
  static const int maxPhoneNumberLength = 14;

  String _errorMessage = 'Terjadi kesalahan. Silakan coba beberapa saat lagi.';

  String _firstName;
  String _lastName;

  bool _isSignUpSuccessful = false;
  bool _isGenerateVerificationCodeSuccessful = false;

  SecureStorage _secureStorage = SecureStorage();

  AccountType _accountType;

  AccountType get accountType => _accountType;

  set accountType(AccountType value) {
    _accountType = value;
    notifyListeners();
  }

  bool get isSignUpSuccessful => _isSignUpSuccessful;
  bool get isGenerateVerificationCodeSuccessful =>
      _isGenerateVerificationCodeSuccessful;

  String get errorMessage => _errorMessage;

  bool get has5OTPDigits {
    return _accountType == AccountType.company ||
        _accountType == AccountType.government;
  }

  String accountIdentifier(
    TextEditingController phoneNumberController,
    TextEditingController emailController,
  ) {
    final _phoneNumber = phoneNumberController.text;
    final _email = emailController.text;

    if (_email.isNotEmpty) {
      return _email;
    }

    if (_phoneNumber.isNotEmpty) {
      return _phoneNumber;
    }

    return null;
  }

  void _separateName(String name) {
    List<String> names = name.split(' ');
    _firstName = names[0];
    _lastName = names.sublist(1).join(' ');
  }

  String _buildEmptyValueMessage(String target) {
    return '$target tidak boleh kosong';
  }

  String _buildInvalidValueMessage(String target) {
    return '$target tidak valid';
  }

  bool _isEmail(String text) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text);
  }

  String validateName(String value) {
    int minDigits = nameMinimumDigits();
    int maxDigits = nameMaximumDigits();

    if (value.isEmpty) {
      return _buildEmptyValueMessage('Nama');
    }

    _separateName(value);
    if (_firstName.length < minDigits || _firstName.length > maxDigits) {
      _firstName = '';
      return 'Nama depan harus sepanjang $minDigits hingga $maxDigits karakter.';
    }

    if (_lastName.length < minDigits || _lastName.length > maxDigits) {
      _lastName = '';
      return 'Nama belakang harus sepanjang $minDigits hingga $maxDigits karakter.';
    }

    return null;
  }

  int nameMinimumDigits() {
    switch (accountType) {
      case AccountType.government:
      case AccountType.company:
        return 2;
      case AccountType.RTRW:
      case AccountType.public:
        return 6;
    }

    return 2;
  }

  int nameMaximumDigits() {
    switch (accountType) {
      case AccountType.government:
      case AccountType.company:
        return 20;
      case AccountType.RTRW:
      case AccountType.public:
        return 12;
    }

    return 20;
  }

  String validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return _buildEmptyValueMessage('Nomor telepon');
    }

    if (int.tryParse(value) == null || value.length > maxPhoneNumberLength) {
      return _buildInvalidValueMessage('Nomor telepon');
    }

    return null;
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return _buildEmptyValueMessage('Email');
    }

    if (!_isEmail(value)) {
      return _buildInvalidValueMessage('Email');
    }

    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return _buildEmptyValueMessage('Password');
    }

    if (value.length < 8 || value.length > 20) {
      return 'Password harus sepanjang 8 hingga 20 karakter.';
    }

    return null;
  }

  String validateConfirmPassword(
    String value,
    TextEditingController passwordController,
  ) {
    if (value.isEmpty) {
      return _buildEmptyValueMessage('Password');
    }

    if (value.length < 8 || value.length > 20) {
      return 'Password harus sepanjang 8 hingga 20 karakter.';
    }

    if (passwordController.text.isNotEmpty &&
        value != passwordController.text) {
      return 'Kedua password harus sama';
    }

    return null;
  }

  SignUpRequest _buildSignUpRequest(SignUpParam param) {
    _separateName(param.nameController.text);

    return SignUpRequest(
      email: param.emailController.text,
      password: param.passwordController.text,
      firstname: _firstName,
      lastname: _lastName,
      role: accountType.roleInt,
    );
  }

  SignUpByPhoneRequest _buildSignUpByPhoneRequest(SignUpParam param) {
    _separateName(param.nameController.text);

    return SignUpByPhoneRequest(
      phone: param.phoneNumberController.text,
      password: param.passwordController.text,
      firstname: _firstName,
      lastname: _lastName,
      role: accountType.roleInt,
    );
  }

  Future<void> _signUp(SignUpParam param) async {
    Response<dynamic> response;

    final SignUpRequest _requestBody = _buildSignUpRequest(param);

    response = await ApiProvider().signUp(_requestBody);

    if (ApiProvider.isStatusCodeOK(response.statusCode)) {
      _isSignUpSuccessful = true;

      final signInResponse = SignInResponse.fromJson(response.data);

      await _secureStorage.setSignInResponse(signInResponse);
    } else {
      final errorResponse = ErrorResponse.fromJson(response.data);
      _errorMessage = errorResponse?.errorMessage;
    }
  }

  Future<void> _signUpByPhone(SignUpParam param) async {
    Response<dynamic> response;

    final SignUpByPhoneRequest _requestBody = _buildSignUpByPhoneRequest(param);

    response = await ApiProvider().signUpByPhone(_requestBody);

    if (ApiProvider.isStatusCodeOK(response.statusCode)) {
      _isSignUpSuccessful = true;

      final signInByPhoneResponse =
          SignInByPhoneResponse.fromJson(response.data);

      await _secureStorage.setSignInByPhoneResponse(signInByPhoneResponse);
    } else {
      final errorResponse = ErrorResponse.fromJson(response.data);
      _errorMessage = errorResponse?.errorMessage;
    }
  }

  Future<void> signUp(SignUpParam param) async {
    switch (this.accountType) {
      case AccountType.government:
      case AccountType.company:
        await _signUp(param);
        return;
      case AccountType.RTRW:
      case AccountType.public:
        await _signUpByPhone(param);
        return;
    }
  }

  Future<void> generateVerificationCode() async {
    GenerateVerificationCodeResponse response;

    final GenerateVerificationCodeRequest _requestBody =
        GenerateVerificationCodeRequest(
      method: this.accountType.verificationMethod,
    );

    response = await ApiProvider().generateVerificationCode(_requestBody);

    if (response != null) {
      _isGenerateVerificationCodeSuccessful = true;
    }
  }

  Future<void> uploadRegistrationDocuments(List<TrashiDocument> files) async {
    files.forEach((element) async {
      await ApiProvider().uploadFile(element);
    });
  }
}

class SignUpParam {
  final TextEditingController nameController;
  final TextEditingController phoneNumberController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  SignUpParam({
    @required this.nameController,
    @required this.phoneNumberController,
    @required this.emailController,
    @required this.passwordController,
    @required this.confirmPasswordController,
  });
}
