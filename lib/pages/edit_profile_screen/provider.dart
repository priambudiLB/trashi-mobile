import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:trashi/http_request/api_provider.dart';
import 'package:trashi/http_request/models/auth.dart';
import 'package:trashi/pages/profile_screen_redesign/role_type.dart';
import 'package:trashi/secure_storage/secure_storage.dart';
import 'package:trashi/utils/commons.dart';

class EditProfileScreenProvider with ChangeNotifier, DiagnosticableTreeMixin {
  SecureStorage _secureStorage = SecureStorage();
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
    CurrentUserResponse currentUser =
        await _secureStorage.getCurrentUserResponse();
    if (currentUser != null) {
      setName(currentUser.currentUser.firstName +
          " " +
          currentUser.currentUser.lastName);
      setEmailOrPhone(currentUser.currentUser.phone);
      setRoleType(getRoleType(currentUser.currentUser.role));
      setPassword("");
    }
    setStatusFetchData(FormzStatus.submissionSuccess);
  }

  void editData() async {
    CurrentUserResponse currentUser =
        await _secureStorage.getCurrentUserResponse();
    dynamic body = {};
    List<String> names = _name.trim().split(" ");
    String firstnameChanged = names[0];
    String lastnameChanged = names.sublist(1).join(" ");

    if (currentUser.currentUser.firstName != firstnameChanged)
      body["firstname"] = firstnameChanged;
    if (currentUser.currentUser.lastName != lastnameChanged)
      body["lastname"] = lastnameChanged;
    if (currentUser.currentUser.phone != emailOrPhone) {
      if (currentUser.currentUser.role == 5)
        body["phone"] = emailOrPhone;
      else
        body["username"] = emailOrPhone;
    }
    if (password != "") body["password"] = password;

    if (body.length > 0) {
      setStatusFetchData(FormzStatus.submissionInProgress);
      final response = await ApiProvider().editProfileApi(body);
      if (response != null) {
        final responseCurrentUser = await ApiProvider().getCurrentUser();
        print(responseCurrentUser.currentUser.lastName);
        if (responseCurrentUser != null) {
          await _secureStorage.setCurrentUserResponse(responseCurrentUser);
          fetchData();
        }
      }
      setStatusFetchData(FormzStatus.submissionSuccess);
    }
  }
}
