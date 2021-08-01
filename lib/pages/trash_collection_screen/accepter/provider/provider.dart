import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trashi/http_request/api_provider.dart';
import 'package:trashi/http_request/models/kabupaten.dart';
import 'package:trashi/http_request/models/kecamatan.dart';
import 'package:trashi/http_request/models/upst.dart';

class AcceptTrashCollectionRequestScreenProvider
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
