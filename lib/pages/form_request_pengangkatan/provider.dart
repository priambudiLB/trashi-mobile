import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trashi/http_request/api_provider.dart';
import 'package:trashi/http_request/models/barang.dart';
import 'package:trashi/http_request/models/kendaraan_dp.dart';
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
  TimeType _selectedTimeType = TimeType.NOW;
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  List<File> _listFile = [];
  Set<Marker> _markers = {};
  LatLng _selectedLocation;
  String _descriptionLocation = "";

  Barang get selectedBarang => _selectedBarang;
  RangeBerat get selectedBeratBarang => _selectedBeratBarang;
  KendaraanDanDP get selectedKendaraan => _selectedKendaraan;
  List<Barang> get listBarang => _listBarang;
  List<RangeBerat> get listBeratBarang => _listBeratBarang;
  List<KendaraanDanDP> get listKendaraan => _listKendaraan;
  FormzStatus get statusFetchData => _statusFetchData;
  TimeType get selectedTimeType => _selectedTimeType;
  DateTime get selectedDate => _selectedDate;
  TimeOfDay get selectedTime => _selectedTime;
  List<File> get listFile => _listFile;
  Set<Marker> get markers => _markers;
  LatLng get selectedLocation => _selectedLocation;
  String get descriptionLocation => _descriptionLocation;
  bool get isValid =>
      _selectedBarang != null &&
      _selectedBeratBarang != null &&
      _selectedKendaraan != null &&
      (_selectedTimeType == TimeType.NOW ||
          (_selectedDate != null && _selectedTime != null));

  void fetchDataMap() async {
    LatLng latlang = new LatLng(-6.2339227, 106.8387889);
    Future.delayed(Duration(seconds: 1), () {
      setMarkers(
          {Marker(markerId: MarkerId(latlang.toString()), position: latlang)});
      setSelectedLocation(latlang);
    });
  }

  void fetchData() async {
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
}
