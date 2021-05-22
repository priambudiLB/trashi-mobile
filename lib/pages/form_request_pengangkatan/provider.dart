import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:trashi/pages/form_request_pengangkatan/model/barang.dart';
import 'package:trashi/pages/form_request_pengangkatan/model/berat_barang.dart';
import 'package:trashi/pages/form_request_pengangkatan/model/kendaraan.dart';

class FormRequestPengangkatanProvider
    with ChangeNotifier, DiagnosticableTreeMixin {
  Barang _selectedBarang;
  BeratBarang _selectedBeratBarang;
  Kendaraan _selectedKendaraan;
  List<Barang> _listBarang;
  List<BeratBarang> _listBeratBarang;
  List<Kendaraan> _listKendaraan;
  FormzStatus _statusFetchData = FormzStatus.pure;

  Barang get selectedBarang => _selectedBarang;
  BeratBarang get selectedBeratBarang => _selectedBeratBarang;
  Kendaraan get selectedKendaraan => _selectedKendaraan;
  List<Barang> get listBarang => _listBarang;
  List<BeratBarang> get listBeratBarang => _listBeratBarang;
  List<Kendaraan> get listKendaraan => _listKendaraan;
  FormzStatus get statusFetchData => _statusFetchData;

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
}
