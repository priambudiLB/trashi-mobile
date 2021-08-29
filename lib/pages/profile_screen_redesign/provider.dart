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
  String _role = "";
  int _isAcc = 0;
  String get name => _name;
  String get role => _role;
  int get isAcc => _isAcc;
  RoleType _roleType;
  RoleType get roleType => _roleType;
  FormzStatus _statusFetchData = FormzStatus.pure;
  FormzStatus get statusFetchData => _statusFetchData;

  void fetchData() async {
    setStatusFetchData(FormzStatus.submissionInProgress);
    CurrentUserResponse currentUser = await ApiProvider().getCurrentUser();
    if (currentUser != null) {
      _secureStorage.setCurrentUserResponse(currentUser);
      setName(currentUser.currentUser.firstName);
      setIsAcc(currentUser.currentUser.isAcc);
      switch (currentUser.currentUser.role) {
        case 1:
          setRoleType(RoleType.ADMIN);
          setRole("Admin");
          break;
        case 2:
          setRoleType(RoleType.PEMERINTAH);
          setRole("Pemerintah");
          break;
        case 3:
          setRoleType(RoleType.SWASTA);
          setRole("Swasta");
          break;
        case 4:
          setRoleType(RoleType.PERSONAL);
          setRole("Masyarakat Umum");
          break;
        case 5:
          setRoleType(RoleType.RTRW);
          setRole("RT/RW");
          break;
      }
    }
    //else {
    //   final response = await ApiProvider().getCurrentUser();
    //   if (response.currentUser != null) {
    //     await _secureStorage.setCurrentUserResponse(response);
    //     fetchData();
    //   } else {
    //     //ngapain yak enaknya
    //   }
    // }
    setStatusFetchData(FormzStatus.submissionSuccess);
  }

  void setIsAcc(int value) {
    _isAcc = value;
    notifyListeners();
  }

  void setRole(String newRole) {
    _role = newRole;
    notifyListeners();
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
