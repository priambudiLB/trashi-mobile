import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
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

  Future<void> fetchData() async {
    setFetching(true);
    final response = await ApiProvider().getRetribusiListMasyarakat();
    List<RetribusiNowResponse> tmp = List<RetribusiNowResponse>.from(
            response.data.map((value) => RetribusiNowResponse.fromJson(value)))
        .toList();
    setListData(tmp);
    setFetching(false);
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
