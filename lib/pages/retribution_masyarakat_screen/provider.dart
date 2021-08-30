import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:trashi/constants/retribution_status.dart';
import 'package:trashi/http_request/api_provider.dart';
import 'package:trashi/http_request/models/retribusi.dart';

class RetributionMasyarakatProvider
    with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isFetching = false;
  FormzStatus _statusFetchData = FormzStatus.pure;
  PembayaranRetribusiResponse _pembayaranRetribusiResponse;
  List<RetribusiNowResponse> _data = [];
  bool get isFetching => _isFetching;
  FormzStatus get statusFetchData => _statusFetchData;
  List<RetribusiNowResponse> get data => _data;
  RumahResponse rumahResponse = new RumahResponse();
  PembayaranRetribusiResponse get pembayaranRetribusiResponse =>
      _pembayaranRetribusiResponse;

  RetributionStatus _status;
  RetributionStatus get status => _status;

  set status(RetributionStatus value) {
    _status = value;
    notifyListeners();
  }

  // filter V2
  GetRetribusiListFilterV2 _getRetribusiListFilterV2;
  GetRetribusiListFilterV2 get getRetribusiListFilterV2 =>
      _getRetribusiListFilterV2;

  set getRetribusiListFilterV2(GetRetribusiListFilterV2 value) {
    _getRetribusiListFilterV2 = value;
    notifyListeners();
  }

  Future<void> getRetribusiListByRole({
    GetRetribusiListFilterV2 filter,
  }) async {}

  Future<void> getList({GetRetribusiListFilterV2 filter}) async {
    final response = await ApiProvider().getRetribusiListMasyarakat(filter);
    List<RetribusiNowResponse> tmp = List<RetribusiNowResponse>.from(
            response.data.map((value) => RetribusiNowResponse.fromJson(value)))
        .toList();
    setListData(tmp);
  }

  Future<void> fetchData() async {
    setFetching(true);
    final response = await ApiProvider()
        .getRetribusiListMasyarakat(GetRetribusiListFilterV2());
    List<RetribusiNowResponse> tmp = List<RetribusiNowResponse>.from(
            response.data.map((value) => RetribusiNowResponse.fromJson(value)))
        .toList();
    setListData(tmp);
    setFetching(false);
  }

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

  void resetAllFilters() {
    _status = null;
    _monthFilter = null;
    _yearFilter = null;
  }

  void createPembayaranRetribusi(int amount, int id) async {
    setCreateStatus(FormzStatus.submissionInProgress);
    final body = CreatePembayaranRetribusiInvoiceRequest(
        amount: amount, idRetribusi: id);
    final response = await ApiProvider().createPembayaranRetribusiInvoice(body);
    print(response.invoiceURL);
    if (response != null) {
      setPembayaranResposnse(response);
    }
    setCreateStatus(FormzStatus.submissionSuccess);
  }

  void setPembayaranResposnse(PembayaranRetribusiResponse value) {
    _pembayaranRetribusiResponse = value;
    notifyListeners();
  }

  void setListData(List<dynamic> value) {
    _data = value;
    notifyListeners();
  }

  void setFetching(bool value) {
    _isFetching = value;
    notifyListeners();
  }

  void setCreateStatus(FormzStatus value) {
    _statusFetchData = value;
    notifyListeners();
  }
}
