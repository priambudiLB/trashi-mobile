import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:trashi/constants/account_types.dart';
import 'package:trashi/http_request/api_provider.dart';
import 'package:trashi/http_request/models/auth.dart';
import 'package:trashi/models/trashi_document.dart';
import 'package:trashi/secure_storage/secure_storage.dart';
import 'package:trashi/constants/document_type.dart';

class RegistrationLogic {
  static const int maxPhoneNumberLength = 14;

  TextEditingController _nameController;
  TextEditingController _phoneNumberController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;
  final AccountType accountType;

  String _firstName;
  String _lastName;

  bool _isSignUpSuccessful;
  bool _isGenerateVerificationCodeSuccessful;

  SecureStorage _secureStorage;

  RegistrationLogic({
    @required this.accountType,
  }) {
    _nameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _isSignUpSuccessful = false;
    _isGenerateVerificationCodeSuccessful = false;

    _secureStorage = SecureStorage();
  }

  TextEditingController get nameController => _nameController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  bool get isSignUpSuccessful => _isSignUpSuccessful;
  bool get isGenerateVerificationCodeSuccessful =>
      _isGenerateVerificationCodeSuccessful;

  String get phoneNumber => _phoneNumberController.text;
  String get email => _emailController.text;

  String get accountIdentifier {
    final _phoneNumber = _phoneNumberController.text;
    final _email = _emailController.text;

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
    if (value.isEmpty) {
      return _buildEmptyValueMessage('Nama');
    }

    _separateName(value);
    if (_firstName.length < 8 || _firstName.length > 20) {
      _firstName = '';
      return 'Nama depan harus sepanjang 8 hingga 20 karakter.';
    }

    if (_lastName.length < 8 || _lastName.length > 20) {
      _lastName = '';
      return 'Nama belakang harus sepanjang 8 hingga 20 karakter.';
    }

    return null;
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

  String validateConfirmPassword(String value) {
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

  SignUpRequest _buildSignUpRequest() {
    _separateName(nameController.text);

    return SignUpRequest(
      email: emailController.text,
      password: passwordController.text,
      firstname: _firstName,
      lastname: _lastName,
      role: accountType.roleInt,
    );
  }

  SignUpByPhoneRequest _buildSignUpByPhoneRequest() {
    _separateName(nameController.text);

    return SignUpByPhoneRequest(
      phone: phoneNumberController.text,
      password: passwordController.text,
      firstname: _firstName,
      lastname: _lastName,
      role: accountType.roleInt,
    );
  }

  Future<void> _signUp() async {
    SignInResponse response;

    final SignUpRequest _requestBody = _buildSignUpRequest();

    response = await ApiProvider().signUp(_requestBody);

    if (response != null) {
      _isSignUpSuccessful = true;

      await _secureStorage.setSignInResponse(response);
    }
  }

  Future<void> _signUpByPhone() async {
    SignInByPhoneResponse response;

    final SignUpByPhoneRequest _requestBody = _buildSignUpByPhoneRequest();

    response = await ApiProvider().signUpByPhone(_requestBody);

    if (response != null) {
      _isSignUpSuccessful = true;

      await _secureStorage.setSignInByPhoneResponse(response);
    }
  }

  Future<void> signUp() async {
    switch (this.accountType) {
      case AccountType.government:
      case AccountType.company:
        await _signUp();
        return;
      case AccountType.RTRW:
      case AccountType.public:
        await _signUpByPhone();
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
