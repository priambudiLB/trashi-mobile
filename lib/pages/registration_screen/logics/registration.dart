import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:trashi/constants/account_types.dart';
import 'package:trashi/http_request/models/auth.dart';
import 'package:trashi/http_request/trashi_client.dart';
import 'package:dio/dio.dart';

class RegistrationLogic {
  static const int maxPhoneNumberLength = 14;

  TextEditingController _nameController;
  TextEditingController _phoneNumberController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;
  final AccountType accountType;

  TrashiClient _client;

  String _firstName;
  String _lastName;

  bool _isSignUpSuccessful;

  RegistrationLogic({
    @required this.accountType,
  }) {
    _nameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _client = TrashiClient(
      Dio(
        BaseOptions(contentType: 'application/json'),
      ),
    );

    _isSignUpSuccessful = false;
  }

  TextEditingController get nameController => _nameController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  bool get isSignUpSuccessful => _isSignUpSuccessful;

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

  void _onSignUpError(Object obj) {
    switch (obj.runtimeType) {
      case DioError:
        // Here's the sample to get the failed response error code and message
        final res = (obj as DioError).response;
        Logger logger = Logger();
        logger.e("Got error : ${res.statusCode} -> ${res.statusMessage}");
        logger.e(res.data);
        break;
      default:
    }
  }

  Future<void> _signUp() async {
    SignInResponse response;

    final SignUpRequest _requestBody = _buildSignUpRequest();

    await _client
        .signUp(_requestBody)
        .then(
          (value) => response = value,
        )
        .catchError(_onSignUpError);

    if (response != null) {
      _isSignUpSuccessful = true;
    }
  }

  Future<void> _signUpByPhone() async {
    SignInByPhoneResponse response;

    final SignUpByPhoneRequest _requestBody = _buildSignUpByPhoneRequest();

    await _client
        .signUpByPhone(_requestBody)
        .then(
          (value) => response = value,
        )
        .catchError(_onSignUpError);

    if (response != null) {
      _isSignUpSuccessful = true;
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
}
