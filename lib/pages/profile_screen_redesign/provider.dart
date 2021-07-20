import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:trashi/http_request/api_provider.dart';
import 'package:trashi/http_request/models/auth.dart';
import 'package:trashi/pages/profile_screen_redesign/role_type.dart';
import 'package:trashi/secure_storage/secure_storage.dart';

class ProfileScreenProvider with ChangeNotifier, DiagnosticableTreeMixin {
  SecureStorage _secureStorage = SecureStorage();
  String _name = "";
  String get name => _name;
  RoleType _roleType;
  RoleType get roleType => _roleType;
  FormzStatus _statusFetchData = FormzStatus.pure;
  FormzStatus get statusFetchData => _statusFetchData;

  void fetchData() async {
    setStatusFetchData(FormzStatus.submissionInProgress);
    CurrentUserResponse currentUser =
        await _secureStorage.getCurrentUserResponse();
    if (currentUser != null) {
      setName(currentUser.currentUser.firstName);
      switch (currentUser.currentUser.role) {
        case 1:
          setRoleType(RoleType.ADMIN);
          break;
        case 2:
          setRoleType(RoleType.PEMERINTAH);
          break;
        case 3:
          setRoleType(RoleType.SWASTA);
          break;
        case 4:
          setRoleType(RoleType.PERSONAL);
          break;
        case 5:
          setRoleType(RoleType.RTRW);
      }
    } else {
      final response = await ApiProvider().getCurrentUser();
      if (response.currentUser != null) {
        await _secureStorage.setCurrentUserResponse(response);
        fetchData();
      } else {
        //ngapain yak enaknya
      }
    }
    setStatusFetchData(FormzStatus.submissionSuccess);
  }

  void setRoleType(RoleType role) {
    _roleType = role;
    notifyListeners();
  }

  void setStatusFetchData(FormzStatus status) {
    _statusFetchData = status;
    notifyListeners();
  }

  void setName(String value) {
    _name = value;
    notifyListeners();
  }
}
