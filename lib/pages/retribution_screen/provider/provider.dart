import 'package:flutter/foundation.dart';
import 'package:trashi/constants/time.dart';
import 'package:trashi/http_request/api_provider.dart';
import 'package:trashi/http_request/models/kabupaten.dart';
import 'package:trashi/http_request/models/kecamatan.dart';
import 'package:trashi/http_request/models/retribusi.dart';
import 'package:trashi/http_request/models/upst.dart';
import 'package:trashi/constants/retribution_status.dart';

class RetributionProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isFetching = false;

  DateTime _dateTime;
  String _provinsi = 'DKI Jakarta';
  Kabupaten _kabupaten;
  Kecamatan _kecamatan;
  UPSTHTTPModel _upst;
  RetributionStatus _status;
  List<Month> _months = trashiMonths;
  Month _month;

  GetRetribusiListResponse _getRetribusiListResponse;
  GetRetribusiListResponse get getRetribusiListResponse =>
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

    _getRetribusiListResponse = GetRetribusiListResponse.fromJson(
      response.data,
    );

    notifyListeners();
  }

  /// for retributions approval
  Map<String, List<StatusRetribusi>> _toBeApprovedValues =
      Map<String, List<StatusRetribusi>>();

  Map<String, List<StatusRetribusi>> get toBeApprovedValues =>
      _toBeApprovedValues;

  void addToBeApprovedValue(String key, List<StatusRetribusi> value) {
    if (value.isEmpty || value.length < 1) {
      if (_toBeApprovedValues.containsKey(key)) {
        _toBeApprovedValues.remove(key);
      }
    } else {
      _toBeApprovedValues[key] = value;
    }

    notifyListeners();
  }

  void emptyToBeApprovedValues() {
    _toBeApprovedValues = Map<String, List<StatusRetribusi>>();
    notifyListeners();
  }

  String generateKeyForToBeApprovedValues(Retribusi retribusi) {
    final idTransaksi = retribusi.idTransaksi;
    final alamat = retribusi.alamat;

    return '$idTransaksi-$alamat';
  }

  ApproveRetribusiRequest _createApproveRetribusiRequest(
    Retribusi retribusi,
    StatusRetribusi status,
  ) {
    return ApproveRetribusiRequest(
      idRetribusi: retribusi.id,
      month: status.month,
      year: status.year,
    );
  }

  bool areMonthsToBeApprovedOK(
    List<StatusRetribusi> statusToBeApproved,
    List<StatusRetribusi> statusAvailable,
  ) {
    final monthsToBeApprovedInNumbers = statusToBeApproved
        .map(
          (element) => element.month.inNumber,
        )
        .toList();

    final monthsAvailableInNumbers = statusAvailable
        .map(
          (element) => element.month.inNumber,
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

  Future<void> approveRetribusi(
    ApproveRetribusiRequest body,
  ) async {
    final response = await ApiProvider().approveRetribusi(body);

    if (!ApiProvider.isStatusCodeOK(response.statusCode)) {
      return;
    }
  }

  Future<void> approveRetribusiList() async {
    if (_toBeApprovedValues.keys.length < 1) {
      return;
    }

    List<ApproveRetribusiRequest> _toBeApprovedList = [];

    _toBeApprovedList.forEach((element) {
      approveRetribusi(element);
    });
  }
}
