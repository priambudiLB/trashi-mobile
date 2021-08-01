// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:trashi/constants/account_types.dart';
import 'package:trashi/constants/document_type.dart';
import 'package:trashi/http_request/api_provider.dart';
import 'package:trashi/http_request/models/kabupaten.dart';
import 'package:trashi/http_request/models/kecamatan.dart';
import 'package:trashi/http_request/models/upst.dart';
import 'package:trashi/models/trashi_document.dart';
import 'package:trashi/status_upload.dart';
import 'package:trashi/verification.dart';
import 'package:trashi/http_request/models/auth.dart';

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

  void verify() async {
    ValidateVerificationCodeRequest _requestBody =
        ValidateVerificationCodeRequest(
      code: otpComplete,
    );

    final response = await ApiProvider().validateVerificationCode(
      _requestBody,
    );

    if (response != null) {
      print('OTP complete');
      setPopUpSuccessOpen(true);
    }
  }
}

class SubmitDocumentVerification with ChangeNotifier, DiagnosticableTreeMixin {
  StatusUpload _generalStatus = StatusUpload.NOT_UPLOADED;
  StatusUpload _ktpStatus = StatusUpload.NOT_UPLOADED;
  StatusUpload _kkStatus = StatusUpload.NOT_UPLOADED;
  StatusUpload _ktpAndKkStatus = StatusUpload.NOT_UPLOADED;
  FormzStatus _statusFetchData = FormzStatus.pure;
  File _fileKtp;
  File _fileKk;
  File _fileKtpAndKK;

  StatusUpload get generalStatus => _generalStatus;
  StatusUpload get ktpStatus => _ktpStatus;
  StatusUpload get kkStatus => _kkStatus;
  StatusUpload get ktpAndKkStatus => _ktpAndKkStatus;
  FormzStatus get statusFetchData => _statusFetchData;
  File get fileKtp => _fileKtp;
  File get fileKk => _fileKk;
  File get fileKtpAndKK => _fileKtpAndKK;

  void setStatusFetchData(FormzStatus status) {
    _statusFetchData = status;
    notifyListeners();
  }

  void fetchData() async {
    setStatusFetchData(FormzStatus.submissionInProgress);
    print("masuk");
    Future.delayed(Duration(seconds: 1), () {
      setGeneralStatus(StatusUpload.NOT_UPLOADED);
      setKtpStatus(StatusUpload.FAILED);
      setKkStatus(StatusUpload.FAILED);
      setKtpAndKkStatus(StatusUpload.FAILED);
      setStatusFetchData(FormzStatus.submissionSuccess);
    });
    // TODO fetch data from API
  }

  void setGeneralStatus(StatusUpload newStatus) {
    _generalStatus = newStatus;
    notifyListeners();
  }

  void setKtpStatus(StatusUpload newStatus) {
    _ktpStatus = newStatus;
    notifyListeners();
  }

  void setKkStatus(StatusUpload newStatus) {
    _kkStatus = newStatus;
    notifyListeners();
  }

  void setKtpAndKkStatus(StatusUpload newStatus) {
    _ktpAndKkStatus = newStatus;
    notifyListeners();
  }

  void setKtpFile(File file) {
    _fileKtp = file;
    notifyListeners();
  }

  void setKkFile(File file) {
    _fileKk = file;
    notifyListeners();
  }

  void setKtpAndKkFile(File file) {
    _fileKtpAndKK = file;
    notifyListeners();
  }
}

class SubmitDocumentOnRegistration
    with ChangeNotifier, DiagnosticableTreeMixin {
  File _fileKTP;
  File _fileKK;
  File _filePhotoWithKTPAndKK;
  File _fileOfficialDocument;
  File _filePhotoWithOfficialDocument;
  File _fileBusinessPermission;
  File _filePhotoWithBusinessPermission;

  File get fileKTP => _fileKTP;
  File get fileKK => _fileKK;
  File get filePhotoWithKTPAndKK => _filePhotoWithKTPAndKK;
  File get fileOfficialDocument => _fileOfficialDocument;
  File get filePhotoWithOfficialDocument => _filePhotoWithOfficialDocument;
  File get fileBusinessPermission => _fileBusinessPermission;
  File get filePhotoWithBusinessPermission => _filePhotoWithBusinessPermission;

  void emptyAllRegistrationDocumentFiles() {
    _fileKTP = null;
    _fileKK = null;
    _filePhotoWithKTPAndKK = null;
    _fileOfficialDocument = null;
    _filePhotoWithOfficialDocument = null;
    _fileBusinessPermission = null;
    _filePhotoWithBusinessPermission = null;
  }

  set fileKTP(File file) {
    _fileKTP = file;
    notifyListeners();
  }

  set fileKK(File file) {
    _fileKK = file;
    notifyListeners();
  }

  set filePhotoWithKTPAndKK(File file) {
    _filePhotoWithKTPAndKK = file;
    notifyListeners();
  }

  set fileOfficialDocument(File file) {
    _fileOfficialDocument = file;
    notifyListeners();
  }

  set filePhotoWithOfficialDocument(File file) {
    _filePhotoWithOfficialDocument = file;
    notifyListeners();
  }

  set fileBusinessPermission(File file) {
    _fileBusinessPermission = file;
    notifyListeners();
  }

  set filePhotoWithBusinessPermission(File file) {
    _filePhotoWithBusinessPermission = file;
    notifyListeners();
  }

  bool areAllDocumentsUploaded(AccountType accountType) {
    switch (accountType) {
      case AccountType.government:
        return ![_fileOfficialDocument, _filePhotoWithOfficialDocument]
            .contains(null);
      case AccountType.company:
        return ![_fileBusinessPermission, _filePhotoWithBusinessPermission]
            .contains(null);
      case AccountType.RTRW:
      case AccountType.public:
        return ![_fileKTP, _fileKK, _filePhotoWithKTPAndKK].contains(null);
      default:
        return null;
    }
  }

  List<TrashiDocument> getDocumentsByAccountType(
    AccountType accountType,
  ) {
    switch (accountType) {
      case AccountType.government:
        return [
          TrashiDocument(
            file: _fileOfficialDocument,
            type: DocumentType.officialDocument,
          ),
          TrashiDocument(
            file: _filePhotoWithOfficialDocument,
            type: DocumentType.photoWithOfficialDocument,
          )
        ];
      case AccountType.company:
        return [
          TrashiDocument(
            file: _fileBusinessPermission,
            type: DocumentType.businessPermission,
          ),
          TrashiDocument(
            file: _filePhotoWithBusinessPermission,
            type: DocumentType.photoWithBusinessPermission,
          )
        ];
      case AccountType.RTRW:
      case AccountType.public:
        return [
          TrashiDocument(
            file: _fileKTP,
            type: DocumentType.KTP,
          ),
          TrashiDocument(
            file: _fileKK,
            type: DocumentType.KK,
          ),
          TrashiDocument(
            file: _filePhotoWithKTPAndKK,
            type: DocumentType.photoWithKTPAndKK,
          )
        ];
      default:
        return null;
    }
  }
}

class AcceptTrashCollectionRequestScreenFilter
    with ChangeNotifier, DiagnosticableTreeMixin {
  String _errorMessage = 'Terjadi kesalahan. Silakan coba beberapa saat lagi.';
  bool _isFetching;

  DateTime _dateTime;
  String _provinsi = 'DKI Jakarta';
  Kabupaten _kabupaten;
  Kecamatan _kecamatan;
  UPSTHTTPModel _upst;

  List<Kabupaten> _kabupatens;
  List<Kecamatan> _kecamatans;
  List<UPSTHTTPModel> _upsts;

  bool get isFetching => _isFetching;
  String get errorMessage => _errorMessage;

  DateTime get dateTime => _dateTime;
  String get provinsi => _provinsi;
  Kabupaten get kabupaten => _kabupaten;
  Kecamatan get kecamatan => _kecamatan;
  UPSTHTTPModel get upst => _upst;

  List<Kabupaten> get kabupatens => _kabupatens;
  List<Kecamatan> get kecamatans => _kecamatans;
  List<UPSTHTTPModel> get upsts => _upsts;

  set isFetching(bool value) {
    _isFetching = value;
    notifyListeners();
  }

  set dateTime(DateTime dateTime) {
    _dateTime = dateTime;
    notifyListeners();
  }

  set provinsi(String value) {
    _provinsi = provinsi;
  }

  set kabupaten(Kabupaten value) {
    _kabupaten = value;
    notifyListeners();
  }

  set kecamatan(Kecamatan value) {
    _kecamatan = value;
    notifyListeners();
  }

  set upst(UPSTHTTPModel value) {
    _upst = value;
    notifyListeners();
  }

  Future<void> getKabupatens() async {
    _isFetching = true;
    notifyListeners();

    final response = await ApiProvider().getKabupatens();

    if (!ApiProvider.isStatusCodeOK(response.statusCode)) {
      isFetching = false;
      return;
    }

    final kabupatenResponse = KabupatenResponse.fromJson(response.data);

    _kabupatens = kabupatenResponse.list;

    _isFetching = false;

    notifyListeners();
  }

  Future<void> getKecamatans({String kabupatenID}) async {
    _isFetching = true;
    notifyListeners();

    final response = await ApiProvider().getKecamatans(
      kabupatenID: kabupatenID,
    );

    if (!ApiProvider.isStatusCodeOK(response.statusCode)) {
      isFetching = false;
      return;
    }

    final kecamatanResponse = KecamatanResponse.fromJson(response.data);

    _kecamatans = kecamatanResponse.list;

    _isFetching = false;

    notifyListeners();
  }

  Future<void> getUPSTs({String kabupatenID, String kecamatanID}) async {
    _isFetching = true;
    notifyListeners();

    final response = await ApiProvider().getUPSTs(
      kabupatenID: kabupatenID,
      kecamatanID: kecamatanID,
    );

    if (!ApiProvider.isStatusCodeOK(response.statusCode)) {
      isFetching = false;
      return;
    }

    final upstResponse = UPSTResponse.fromJson(response.data);

    _upsts = upstResponse.list;

    _isFetching = false;

    notifyListeners();
  }
}
