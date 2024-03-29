import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:trashi/constants/time.dart';
import 'package:trashi/http_request/api_provider.dart';
import 'package:trashi/http_request/models/auth.dart';
import 'package:trashi/http_request/models/errors.dart';
import 'package:trashi/http_request/models/kabupaten.dart';
import 'package:trashi/http_request/models/kecamatan.dart';
import 'package:trashi/http_request/models/retribusi.dart';
import 'package:trashi/http_request/models/upst.dart';
import 'package:trashi/constants/retribution_status.dart';
import 'package:trashi/pages/profile_screen_redesign/role_type.dart';
import 'package:trashi/secure_storage/secure_storage.dart';

class RetributionProvider with ChangeNotifier, DiagnosticableTreeMixin {
  RoleType _roleType;
  RoleType get roleType => _roleType;
  set roleType(RoleType value) {
    _roleType = value;
    notifyListeners();
  }

  bool _isFetching = false;

  DateTime _dateTime;
  String _provinsi = 'DKI Jakarta';
  Kabupaten _kabupaten;
  Kecamatan _kecamatan;
  UPSTHTTPModel _upst;
  RetributionStatus _status;
  List<Month> _months = trashiMonths;
  Month _month;

  GetRetribusiListResponseV2 _getRetribusiListResponse;
  GetRetribusiListResponseV2 get getRetribusiListResponse =>
      _getRetribusiListResponse;

  GetRetribusiListFilter _getRetribusiListFilter;
  GetRetribusiListFilter get getRetribusiListFilter => _getRetribusiListFilter;

  set getRetribusiListFilter(GetRetribusiListFilter value) {
    _getRetribusiListFilter = value;
    notifyListeners();
  }

  List<Kabupaten> _kabupatens;
  List<Kecamatan> _kecamatans;
  List<UPSTHTTPModel> _upsts;

  DateTime get dateTime => _dateTime;
  String get provinsi => _provinsi;
  Kabupaten get kabupaten => _kabupaten;
  Kecamatan get kecamatan => _kecamatan;
  UPSTHTTPModel get upst => _upst;

  List<Kabupaten> get kabupatens => _kabupatens;
  List<Kecamatan> get kecamatans => _kecamatans;
  List<UPSTHTTPModel> get upsts => _upsts;

  Month get month => _month;

  bool get isFetching => _isFetching;

  RetributionStatus get status => _status;

  List<Month> get months => _months;

  String _monthFilter;
  String get monthFilter => _monthFilter;
  set monthFilter(String value) {
    _monthFilter = value;
    notifyListeners();
  }

  String _yearFilter;
  String get yearFilter => _yearFilter;
  set yearFilter(String value) {
    _yearFilter = value;
    notifyListeners();
  }

  set kabupaten(Kabupaten value) {
    _kabupaten = value;
    notifyListeners();
  }

  set kecamatan(Kecamatan value) {
    _kecamatan = value;
    notifyListeners();
  }

  set isFetching(bool value) {
    _isFetching = value;
    notifyListeners();
  }

  set provinsi(String value) {
    _provinsi = provinsi;
  }

  set upst(UPSTHTTPModel value) {
    _upst = value;
    notifyListeners();
  }

  set status(RetributionStatus value) {
    _status = value;
    notifyListeners();
  }

  set month(Month value) {
    _month = value;
    notifyListeners();
  }

  void resetAllFilters() {
    _kabupaten = null;
    _kecamatan = null;
    _upst = null;
    _month = null;
    _status = null;
    _monthFilter = null;
    _yearFilter = null;
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

  Future<void> getKecamatans({int kabupatenID}) async {
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

  Future<void> getUPSTs({int kabupatenID, int kecamatanID}) async {
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

  Future<void> getRetribusiList({
    GetRetribusiListFilter filter,
  }) async {
    GetRetribusiListFilter getRetribusiListFilter = GetRetribusiListFilter();
    if (filter != null) {
      getRetribusiListFilter = filter;
    }

    final response =
        await ApiProvider().getRetribusiList(getRetribusiListFilter);

    if (!ApiProvider.isStatusCodeOK(response.statusCode)) {
      return;
    }

    _getRetribusiListResponse = GetRetribusiListResponseV2.fromJson(
      response.data,
    );

    notifyListeners();
  }

  Future<void> getRetribusiListPemerintah({
    GetRetribusiListFilterV2 filter,
  }) async {
    GetRetribusiListFilterV2 getRetribusiListFilterV2 =
        GetRetribusiListFilterV2();
    if (filter != null) {
      getRetribusiListFilterV2 = filter;
    }

    final response = await ApiProvider()
        .getRetribusiListPemerintah(getRetribusiListFilterV2);

    if (!ApiProvider.isStatusCodeOK(response.statusCode)) {
      return;
    }

    _getRetribusiListResponse = GetRetribusiListResponseV2.fromJson(
      response.data,
    );

    notifyListeners();
  }

  Future<void> getRetribusiListRTRW({
    GetRetribusiListFilterV2 filter,
  }) async {
    GetRetribusiListFilterV2 getRetribusiListFilterV2 =
        GetRetribusiListFilterV2();
    if (filter != null) {
      getRetribusiListFilterV2 = filter;
    }

    final response =
        await ApiProvider().getRetribusiListRTRW(getRetribusiListFilterV2);

    if (!ApiProvider.isStatusCodeOK(response.statusCode)) {
      return;
    }

    _getRetribusiListResponse = GetRetribusiListResponseV2.fromJson(
      response.data,
    );

    notifyListeners();
  }

  Future<void> getRetribusiListByRole({
    GetRetribusiListFilterV2 filter,
  }) async {
    switch (_roleType) {
      case RoleType.ADMIN:
      case RoleType.PEMERINTAH:
        return await getRetribusiListPemerintah(filter: filter);
      case RoleType.RTRW:
        return await getRetribusiListRTRW(filter: filter);
    }

    return;
  }

  /// for retributions approval

  String _approvalResultMessage = '';
  String get approvalResultMessage => _approvalResultMessage;

  bool _isErrorOnApproval = false;
  bool get isErrorOnApproval => _isErrorOnApproval;

  Map<String, List<RetribusiAllItemResponse>> _toBeApprovedValues =
      Map<String, List<RetribusiAllItemResponse>>();

  Map<String, List<RetribusiAllItemResponse>> get toBeApprovedValues =>
      _toBeApprovedValues;

  void addToBeApprovedValue(String key, List<RetribusiAllItemResponse> value) {
    if (value.isEmpty || value.length < 1) {
      if (_toBeApprovedValues.containsKey(key)) {
        _toBeApprovedValues.remove(key);
      }
    } else {
      _toBeApprovedValues[key] = value;
    }

    notifyListeners();
  }

  int getTarifToBeApproved() {
    int total = 0;

    _toBeApprovedValues.keys.forEach((element) {
      total += _getTarifFromKey(element) * _toBeApprovedValues[element].length;
    });

    return total;
  }

  void emptyToBeApprovedValues() {
    _toBeApprovedValues = Map<String, List<RetribusiAllItemResponse>>();
    notifyListeners();
  }

  String generateKeyForToBeApprovedValues(
    RetribusiNowResponse retribusiNowResponse,
  ) {
    return retribusiNowResponse.id.toString() +
        retribusiNowResponse.rumah.id.toString() +
        retribusiNowResponse.rumah.userId +
        ";;tarifRetribusi;;" +
        retribusiNowResponse.rumah.tarifRetribusi.toString();
  }

  int _getTarifFromKey(String key) {
    final arr = key.split(";;tarifRetribusi;;");

    final tarif = arr.last;

    return int.parse(tarif);
  }

  bool areMonthsToBeApprovedOK(
    List<RetribusiAllItemResponse> retribusiToBeApproved,
    List<RetribusiAllItemResponse> retribusiAvailable,
  ) {
    final monthsToBeApprovedInNumbers = retribusiToBeApproved
        .map(
          (element) => element.yearMonth,
        )
        .toList();

    final monthsAvailableInNumbers = retribusiAvailable
        .map(
          (element) => element.yearMonth,
        )
        .toList();

    monthsToBeApprovedInNumbers.sort();
    monthsAvailableInNumbers.sort();

    for (var i = 0; i < monthsToBeApprovedInNumbers.length; i++) {
      if (monthsToBeApprovedInNumbers[i] != monthsAvailableInNumbers[i]) {
        return false;
      }
    }

    return true;
  }

  Future<bool> approveRetribusiAndShowResult(
    RetribusiAllItemResponse item,
  ) async {
    final response = await ApiProvider().approveRetribusi(item.id);

    if (!ApiProvider.isStatusCodeOK(response.statusCode)) {
      return false;
    }

    return true;
  }

  Future<void> approveRetribusiList() async {
    if (_toBeApprovedValues.keys.length < 1) {
      return;
    }

    int successCount = 0;
    int failedCount = 0;

    List<RetribusiAllItemResponse> _toBeApprovedList = [];

    _toBeApprovedValues.values.forEach((element) {
      _toBeApprovedList.addAll(element);
    });

    _toBeApprovedList.forEach((element) async {
      bool resultSuccess = await approveRetribusiAndShowResult(element);
      if (resultSuccess) {
        successCount++;
      } else {
        failedCount++;
      }
    });

    if (failedCount > 0) {
      _approvalResultMessage =
          'Terdapat kesalahan dalam me-approve sejumlah $failedCount data retribusi';
      _isErrorOnApproval = true;
    }

    _toBeApprovedValues = Map<String, List<RetribusiAllItemResponse>>();
    getRetribusiListByRole();
  }

  // filter V2
  GetRetribusiListFilterV2 _getRetribusiListFilterV2;
  GetRetribusiListFilterV2 get getRetribusiListFilterV2 =>
      _getRetribusiListFilterV2;

  set getRetribusiListFilterV2(GetRetribusiListFilterV2 value) {
    _getRetribusiListFilterV2 = value;
    notifyListeners();
  }

  bool shouldShowPenanggungJawabColumn() {
    switch (_roleType) {
      case RoleType.ADMIN:
      case RoleType.PEMERINTAH:
        return true;
      case RoleType.RTRW:
        return false;
    }

    return false;
  }

  String _errorApproveMessage = '';
  String get errorApproveMessage => _errorApproveMessage;

  Future<bool> signInWithoutUpdateSessionByPhone(String password) async {
    final signInByPhoneResponse =
        await SecureStorage().getSignInByPhoneResponse();

    if (signInByPhoneResponse == null) {
      _errorApproveMessage = 'Terjadi kesalahan. Silakan coba lagi';
      notifyListeners();
      return false;
    }

    final request = SignInByPhoneRequest(
      phone: signInByPhoneResponse.phone,
      password: password,
      requestSource: 'mobile-app',
    );

    final response =
        await ApiProvider().signInWithoutUpdateSessionByPhone(request);

    if (!ApiProvider.isStatusCodeOK(response.statusCode)) {
      final errorResponse = ErrorResponse.fromJson(response.data);
      _errorApproveMessage = errorResponse?.errorMessage;
      notifyListeners();
      return false;
    }

    return true;
  }

  // search

  Timer _debounce;

  bool _shouldDeleteSearchText = false;
  bool get shouldDeleteSearchText => _shouldDeleteSearchText;

  set shouldDeleteSearchText(bool value) {
    _shouldDeleteSearchText = value;
    notifyListeners();
  }

  onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (_getRetribusiListFilterV2 == null) {
        _getRetribusiListFilterV2 = GetRetribusiListFilterV2(search: value);
      } else {
        _getRetribusiListFilterV2.setSearch(value);
      }

      await getRetribusiListByRole(filter: _getRetribusiListFilterV2);
      notifyListeners();
    });
  }
}
