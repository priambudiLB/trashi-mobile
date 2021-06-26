import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:trashi/pages/profile_screen_redesign/role_type.dart';

class EditProfileScreenProvider with ChangeNotifier, DiagnosticableTreeMixin {
  RoleType _roleType;
  String _name;
  String _emailOrPhone;
  String _password;
  bool _isPasswordVisible = false;
  FormzStatus _statusFetchData = FormzStatus.pure;

  RoleType get roleType => _roleType;
  String get name => _name;
  String get emailOrPhone => _emailOrPhone;
  String get password => _password;
  bool get isPasswordVisible => _isPasswordVisible;
  FormzStatus get statusFetchData => _statusFetchData;

  void setRoleType(RoleType role) {
    _roleType = role;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setEmailOrPhone(String value) {
    _emailOrPhone = value;
    notifyListeners();
  }

  void setStatusFetchData(FormzStatus status) {
    _statusFetchData = status;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setPasswordVisible(bool visible) {
    _isPasswordVisible = visible;
    notifyListeners();
  }

  void fetchData() async {
    setStatusFetchData(FormzStatus.submissionInProgress);
    Future.delayed(Duration(seconds: 1), () {
      setName("Indras");
      setEmailOrPhone("value");
      setPassword("password");
    });
    setStatusFetchData(FormzStatus.submissionSuccess);
  }
}
