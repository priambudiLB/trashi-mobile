import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trashi/http_request/api_provider.dart';
import 'package:trashi/http_request/models/barang.dart';
import 'package:trashi/http_request/models/kendaraan_dp.dart';
import 'package:trashi/http_request/models/pembayaran.dart';
import 'package:trashi/http_request/models/pembayaran_pengangkatan.dart';
import 'package:trashi/http_request/models/pengangkatan.dart';
import 'package:trashi/http_request/models/range_berat.dart';

import 'package:trashi/pages/form_request_pengangkatan/time_type.dart';

class FormRequestPengangkatanProvider
    with ChangeNotifier, DiagnosticableTreeMixin {
  Barang _selectedBarang;
  RangeBerat _selectedBeratBarang;
  KendaraanDanDP _selectedKendaraan;
  List<Barang> _listBarang = [];
  List<RangeBerat> _listBeratBarang = [];
  List<KendaraanDanDP> _listKendaraan = [];
  FormzStatus _statusFetchData = FormzStatus.pure;
  FormzStatus _statusSubmitRequestPengangkatan = FormzStatus.pure;
  FormzStatus _statusSubmitLanjutPembayaran = FormzStatus.pure;
  TimeType _selectedTimeType = TimeType.NOW;
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  List<File> _listFile = [];
  Set<Marker> _markers = {};
  LatLng _selectedLocation;
  String _descriptionLocation = "";
  Pengangkatan _pengangkatan;
  bool _isNow;
  PembayaranResponse _pembayaranPengangkatan;

  Barang get selectedBarang => _selectedBarang;
  RangeBerat get selectedBeratBarang => _selectedBeratBarang;
  KendaraanDanDP get selectedKendaraan => _selectedKendaraan;
  List<Barang> get listBarang => _listBarang;
  List<RangeBerat> get listBeratBarang => _listBeratBarang;
  List<KendaraanDanDP> get listKendaraan => _listKendaraan;
  FormzStatus get statusFetchData => _statusFetchData;
  FormzStatus get statusSubmitRequestPengangkatan =>
      _statusSubmitRequestPengangkatan;
  FormzStatus get statusSubmitLanjutPembayaran => _statusSubmitLanjutPembayaran;
  TimeType get selectedTimeType => _selectedTimeType;
  DateTime get selectedDate => _selectedDate;
  TimeOfDay get selectedTime => _selectedTime;
  List<File> get listFile => _listFile;
  Set<Marker> get markers => _markers;
  LatLng get selectedLocation => _selectedLocation;
  String get descriptionLocation => _descriptionLocation;
  Pengangkatan get pengangkatan => _pengangkatan;
  bool get isNow => _isNow;
  PembayaranResponse get pembayaranPengatan => _pembayaranPengangkatan;

  bool get isValid =>
      _selectedBarang != null &&
      _selectedBeratBarang != null &&
      _selectedKendaraan != null &&
      (_selectedTimeType == TimeType.NOW ||
          (_selectedDate != null && _selectedTime != null));

  void setIsNow(bool value) {
    _isNow = value;
    notifyListeners();
  }

  void setPembayaranPengangkatan(
      PembayaranResponse pembayaranPengangkatan) {
    _pembayaranPengangkatan = pembayaranPengangkatan;
    notifyListeners();
  }

  void setPengangkatan(Pengangkatan value) {
    _pengangkatan = value;
    notifyListeners();
  }

  void setSelectedLocation(LatLng location) {
    _selectedLocation = location;
    notifyListeners();
  }

  void setDescriptionLocation(String desc) {
    _descriptionLocation = desc;
    notifyListeners();
  }

  void setMarkers(Set<Marker> markers) {
    _markers = markers;
    notifyListeners();
  }

  void setListFile(List<File> list) {
    _listFile = list;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setSelectedTime(TimeOfDay time) {
    _selectedTime = time;
    notifyListeners();
  }

  void setStatusFetchData(FormzStatus status) {
    _statusFetchData = status;
    notifyListeners();
  }

  void setStatusSubmitRequestPengangkatan(FormzStatus status) {
    _statusSubmitRequestPengangkatan = status;
    notifyListeners();
  }

  void setStatusSubmitLanjutPembayaran(FormzStatus status) {
    _statusSubmitLanjutPembayaran = status;
    notifyListeners();
  }

  void setSelectedBarang(Barang barang) {
    _selectedBarang = barang;
    notifyListeners();
  }

  void setSelectedBeratBarang(RangeBerat beratBarang) {
    _selectedBeratBarang = beratBarang;
    notifyListeners();
  }

  void setSelectedKendaraan(KendaraanDanDP kendaraan) {
    _selectedKendaraan = kendaraan;
    notifyListeners();
  }

  void setListBarang(List<Barang> list) {
    _listBarang = list;
    notifyListeners();
  }

  void setListBeratBarang(List<RangeBerat> list) {
    _listBeratBarang = list;
    notifyListeners();
  }

  void setListKendaraan(List<KendaraanDanDP> list) {
    _listKendaraan = list;
    notifyListeners();
  }

  void setTimeType(TimeType type) {
    _selectedTimeType = type;
    notifyListeners();
  }

  void fetchDataMap() async {
    LatLng latlang = new LatLng(-6.2339227, 106.8387889);
    Future.delayed(Duration(seconds: 1), () {
      setMarkers(
          {Marker(markerId: MarkerId(latlang.toString()), position: latlang)});
      setSelectedLocation(latlang);
    });
  }

  void fetchData() async {
    setPembayaranPengangkatan(null);
    setPengangkatan(null);
    setIsNow(false);
    setSelectedBarang(null);
    setSelectedBeratBarang(null);
    setSelectedDate(null);
    setSelectedTime(null);
    setListFile([]);
    setSelectedKendaraan(null);
    setStatusFetchData(FormzStatus.submissionInProgress);

    final getBarangResponse = await ApiProvider().getBarang();
    if (getBarangResponse != null) {
      setListBarang(getBarangResponse.list);
    }

    final getKenderaanResponse = await ApiProvider().getKendaraanDanDP();
    if (getKenderaanResponse != null) {
      setListKendaraan(getKenderaanResponse.list);
    }

    final getRangeBeratResponse = await ApiProvider().getRangeBerat();
    if (getRangeBeratResponse != null) {
      setListBeratBarang(getRangeBeratResponse.list);
    }

    setStatusFetchData(FormzStatus.submissionSuccess);
  }

  void submitRequestPengangkatan() async {
    setStatusSubmitRequestPengangkatan(FormzStatus.submissionInProgress);
    CreatePengangkatanRequest body = CreatePengangkatanRequest(
        berat: _selectedBeratBarang.range,
        dp: _selectedKendaraan.dp,
        harga: 10000,
        isnow: _isNow,
        jenisbarang: _selectedBarang.nama,
        jeniskendaraan: _selectedKendaraan.kendaraan,
        lat: _selectedLocation.latitude,
        long: _selectedLocation.longitude,
        lokasi: _descriptionLocation,
        waktupengangkatan: new DateTime(_selectedDate.year, _selectedDate.month,
            _selectedDate.day, _selectedTime.hour, _selectedTime.minute));
    final createPengangkatanReponse =
        await ApiProvider().submitRequestPengangkatan(body);
    if (createPengangkatanReponse != null) {
      setPengangkatan(createPengangkatanReponse.pengangkatan);
      setStatusSubmitRequestPengangkatan(FormzStatus.submissionSuccess);
    }
  }

  void submitLanjutPembayaran() async {
    setStatusSubmitLanjutPembayaran(FormzStatus.submissionInProgress);
    final body = PembayaranInvoiceRequest(
      amount: _pengangkatan.dp,
      sourceId: _pengangkatan.id,
      sourceType: "PENGANGKATAN"
    );

    final response =
        await ApiProvider().createPembayaranInvoice(body);

 
    setPembayaranPengangkatan(response);
    setStatusSubmitLanjutPembayaran(FormzStatus.submissionSuccess);
  }
}
