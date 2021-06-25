import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:trashi/pages/profile_screen_redesign/role_type.dart';

class ProfileScreenProvider with ChangeNotifier, DiagnosticableTreeMixin {
  RoleType _roleType;
  RoleType get roleType => _roleType;
  FormzStatus _statusFetchData = FormzStatus.pure;
  FormzStatus get statusFetchData => _statusFetchData;

  void fetchData() async {
    setStatusFetchData(FormzStatus.submissionInProgress);
    Future.delayed(Duration(seconds: 1), () {
      setRoleType(RoleType.PEMERINTAH);
    });
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
}
