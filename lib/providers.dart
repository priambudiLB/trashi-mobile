// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trashi/verification.dart';

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

class RetributionPayment with ChangeNotifier, DiagnosticableTreeMixin {
  bool _popupDateOpen = false;
  String _chosenMonth = DateFormat('MMM').format(new DateTime.now());
  String _chosenYear = DateFormat('y').format(new DateTime.now());
  String _date =
      "${DateFormat('MMM').format(new DateTime.now())}, ${DateFormat('y').format(new DateTime.now())}";

  bool get popupDateOpen => _popupDateOpen;
  String get chosenMonth => _chosenMonth;
  String get chosenYear => _chosenYear;
  String get date => _date;

  void setMonth(String newMonth) {
    _chosenMonth = newMonth;
    notifyListeners();
  }

  void setYear(String newYear) {
    _chosenYear = newYear;
    notifyListeners();
  }

  void setDate() {
    _date = "$_chosenMonth, $_chosenYear";
    notifyListeners();
  }

  void setPopupDateOpen(bool state) {
    _popupDateOpen = state;
    notifyListeners();
  }
}

class UPST with ChangeNotifier, DiagnosticableTreeMixin {
  Map<String, dynamic> _selectedArea = {};
  Map<String, dynamic> _tpstSelected;
  List<dynamic> _listUpstWithGarbage = ["UPST 5/Pool17", "UPST 5/Pool17"];
  List<dynamic> _listUpstWithHighEmission = [
    "UPST 5/Pool17",
    "UPST 5/Pool17",
    "UPST 5/Pool17"
  ];

  Map<String, dynamic> get selectedArea => _selectedArea;
  Map<String, dynamic> get tpstSelected => _tpstSelected;
  List<dynamic> get listUpstWithGarbage => _listUpstWithGarbage;
  List<dynamic> get listUpstWithHighEmission => _listUpstWithHighEmission;

  void setSelectedArea(Map<String, dynamic> newSelectedArea) {
    _selectedArea = newSelectedArea;
    notifyListeners();
  }

  void setTpstSelected(Map<String, dynamic> newTpst) {
    _tpstSelected = newTpst;
    notifyListeners();
  }

  void setListUpstWithGarbage(List<dynamic> newListUpstWithGarbage) {
    _listUpstWithGarbage = newListUpstWithGarbage;
    notifyListeners();
  }

  void setListUpstWithHighEmission(List<dynamic> newListUpstWithHighEmission) {
    _listUpstWithHighEmission = newListUpstWithHighEmission;
    notifyListeners();
  }
}

class OTP with ChangeNotifier, DiagnosticableTreeMixin {
  String _otp1 = "";
  String _otp2 = "";
  String _otp3 = "";
  String _otp4 = "";
  String _account = "";
  bool _popUpSuccessOpen = false;
  Verification _verificationOption = Verification.email;

  String get otp1 => _otp1;
  String get otp2 => _otp2;
  String get otp3 => _otp3;
  String get otp4 => _otp4;
  String get otpComplete => _otp1 + _otp2 + _otp3 + _otp4;
  String get account => _account;
  bool get popUpSuccessOpen => _popUpSuccessOpen;
  Verification get verificationOption => _verificationOption;

  void setOtp1(String newValue) {
    _otp1 = newValue;
    notifyListeners();
  }

  void setOtp2(String newValue) {
    _otp2 = newValue;
    notifyListeners();
  }

  void setOtp3(String newValue) {
    _otp3 = newValue;
    notifyListeners();
  }

  void setOtp4(String newValue) {
    _otp4 = newValue;
    notifyListeners();
  }

  void setAccount(String newValue) {
    _account = newValue;
    notifyListeners();
  }

  void setPopUpSuccessOpen(bool state) {
    _popUpSuccessOpen = state;
    notifyListeners();
  }

  void setVerificationOption(Verification verification) {
    _verificationOption = verification;
    notifyListeners();
  }

  void sendVerificationCode() {
    switch (_verificationOption) {
      case Verification.email:
        //TODO
        break;
      case Verification.phone:
        //TODO
        break;
    }
  }

  void verify() {
    //TODO
    setPopUpSuccessOpen(true);
  }
}
