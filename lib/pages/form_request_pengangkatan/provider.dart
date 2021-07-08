import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trashi/pages/form_request_pengangkatan/model/barang.dart';
import 'package:trashi/pages/form_request_pengangkatan/model/berat_barang.dart';
import 'package:trashi/pages/form_request_pengangkatan/model/kendaraan.dart';
import 'package:trashi/pages/form_request_pengangkatan/time_type.dart';

class FormRequestPengangkatanProvider
    with ChangeNotifier, DiagnosticableTreeMixin {
  Barang _selectedBarang;
  BeratBarang _selectedBeratBarang;
  Kendaraan _selectedKendaraan;
  List<Barang> _listBarang = [];
  List<BeratBarang> _listBeratBarang = [];
  List<Kendaraan> _listKendaraan = [];
  FormzStatus _statusFetchData = FormzStatus.pure;
  TimeType _selectedTimeType = TimeType.NOW;
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  List<File> _listFile = [];
  Set<Marker> _markers = {};
  LatLng _selectedLocation;
  String _descriptionLocation = "";

  Barang get selectedBarang => _selectedBarang;
  BeratBarang get selectedBeratBarang => _selectedBeratBarang;
  Kendaraan get selectedKendaraan => _selectedKendaraan;
  List<Barang> get listBarang => _listBarang;
  List<BeratBarang> get listBeratBarang => _listBeratBarang;
  List<Kendaraan> get listKendaraan => _listKendaraan;
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
    Future.delayed(Duration(seconds: 1), () {
      setListBarang([
        Barang(name: "Barang 1"),
        Barang(name: "Barang 2"),
        Barang(name: "Barang 3")
      ]);

      setListBeratBarang([
        BeratBarang(name: "Berat 1"),
        BeratBarang(name: "Berat 2"),
        BeratBarang(name: "Berat 3")
      ]);

      setListKendaraan([
        Kendaraan(name: "Kendaraan 1"),
        Kendaraan(name: "Kendaraan 2"),
        Kendaraan(name: "Kendaraan 3")
      ]);

      setStatusFetchData(FormzStatus.submissionSuccess);
    });
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

  void setSelectedBeratBarang(BeratBarang beratBarang) {
    _selectedBeratBarang = beratBarang;
    notifyListeners();
  }

  void setSelectedKendaraan(Kendaraan kendaraan) {
    _selectedKendaraan = kendaraan;
    notifyListeners();
  }

  void setListBarang(List<Barang> list) {
    _listBarang = list;
    notifyListeners();
  }

  void setListBeratBarang(List<BeratBarang> list) {
    _listBeratBarang = list;
    notifyListeners();
  }

  void setListKendaraan(List<Kendaraan> list) {
    _listKendaraan = list;
    notifyListeners();
  }

  void setTimeType(TimeType type) {
    _selectedTimeType = type;
    notifyListeners();
  }
}
