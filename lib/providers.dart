// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


/// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin
class Counter with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }
}

class OnBoarding with ChangeNotifier, DiagnosticableTreeMixin {
  int _index = 0;

  int get index => _index;

  void increment() {
    if (_index == 2) {
      _index = 0;
    } else {
      _index++;
    }
    notifyListeners();
  }

  void decrement() {
    if (_index == 0) {
      _index = 2;
    } else {
      _index--;
    }
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('index', index));
  }
}

// class AuthenticationFormData {
//   AuthenticationFormData({
//     this.registerName,
//     this.registerEmail,
//     this.registerPhone,
//     this.registerPassword,
//     this.loginEmail,
//     this.loginPassword,
//   });
//
//   final String registerName;
//   final String registerEmail;
//   final String registerPhone;
//   final String registerPassword;
//   final String loginEmail;
//   final String loginPassword;
// }

class Authentication with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isLogin = true;
  String _registerName = "";
  String _registerEmail = "";
  String _registerPhone = "";
  String _registerPassword = "";
  String _loginEmail = "";
  String _loginPassword = "";

  bool get isLogin => _isLogin;
  String get registerName => _registerName;
  String get registerEmail => _registerEmail;
  String get registerPhone => _registerPhone;
  String get registerPassword => _registerPassword;
  String get loginEmail => _loginEmail;
  String get loginPassword => _loginPassword;

  void setRegister() {
    if (_isLogin) {
      _isLogin = false;
      notifyListeners();
    }
  }

  void setLogin() {
    if (!_isLogin) {
      _isLogin = true;
      notifyListeners();
    }
  }

  void setRegisterName(String newRegisterName) {
    _registerName = newRegisterName;
    notifyListeners();
  }

  void setRegisterEmail(String newRegisterEmail) {
    _registerEmail = newRegisterEmail;
    notifyListeners();
  }

  void setRegisterPhone(String newRegisterPhone) {
    _registerPhone = newRegisterPhone;
    notifyListeners();
  }

  void setRegisterPassword(String newRegisterPassword) {
    _registerPassword = newRegisterPassword;
    notifyListeners();
  }

  void setLoginEmail(String newLoginEmail) {
    _loginEmail = newLoginEmail;
    notifyListeners();
  }

  void setLoginPassword(String newLoginPassword) {
    _loginPassword = newLoginPassword;
    notifyListeners();
  }
}