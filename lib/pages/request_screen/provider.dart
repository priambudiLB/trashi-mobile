import 'package:flutter/foundation.dart';
import 'package:trashi/constants/pengangkatan.dart';
import 'package:trashi/http_request/api_provider.dart';
import 'package:trashi/http_request/models/pembayaran_pengangkatan.dart';
import 'package:trashi/http_request/models/pengangkatan.dart';

class CollectionHistoryProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isFetching = false;
  bool get isFetching => _isFetching;
  set isFetching(bool value) {
    _isFetching = value;
    notifyListeners();
  }

  List<Pengangkatan> _pengangkatanList;
  bool _hasInvalidPayment;

  List<Pengangkatan> get pengangkatanList => _pengangkatanList;
  bool get hasInvalidPayment => _hasInvalidPayment;

  Future<void> getHistoriPengangkatan() async {
    final response = await ApiProvider().getHistoriPengangkatan();

    if (!ApiProvider.isStatusCodeOK(response.statusCode)) {
      return;
    }

    final historiPengangkatanResponse =
        HistoriPengangkatanResponse.fromJson(response.data);

    _pengangkatanList = historiPengangkatanResponse.pengangkatan;
    _hasInvalidPayment = historiPengangkatanResponse.hasInvalidPayment;

    notifyListeners();
  }

  Pengangkatan _pengangkatan;

  Pengangkatan get pengangkatan => _pengangkatan;

  Future<void> getPengangkatanDetail(int id) async {
    final response = await ApiProvider().getPengangkatanDetail(id);

    if (!ApiProvider.isStatusCodeOK(response.statusCode)) {
      return;
    }

    _pengangkatan = Pengangkatan.fromJson(response.data);

    notifyListeners();
  }

  List<PembayaranPengangkatan> _pembayaranPengangkatans;
  PembayaranPengangkatan _pembayaranPengangkatan;
  GetPembayaranListOfPengangkatanResponse
      _getPembayaranListOfPengangkatanResponse;

  List<PembayaranPengangkatan> get pembayaranPengangkatans =>
      _pembayaranPengangkatans;
  PembayaranPengangkatan get pembayaranPengangkatan => _pembayaranPengangkatan;
  GetPembayaranListOfPengangkatanResponse
      get getPembayaranListOfPengangkatanResponse =>
          _getPembayaranListOfPengangkatanResponse;

  Future<void> getPembayaranListOfPengangkatan(int pengangkatanID) async {
    final response =
        await ApiProvider().getPembayaranListOfPengangkatan(pengangkatanID);

    if (!ApiProvider.isStatusCodeOK(response.statusCode)) {
      return;
    }

    _getPembayaranListOfPengangkatanResponse =
        GetPembayaranListOfPengangkatanResponse.fromJson(response.data);

    notifyListeners();
  }

  Future<void> createPembayaranPengangkatan() async {
    final remainderAmount = _pengangkatan.harga - _pengangkatan.hargaterbayar;

    final body = CreatePengangkatanPembayaranInvoiceRequest(
      amount: remainderAmount,
      pengangkatanID: _pengangkatan.id,
    );

    final response =
        await ApiProvider().createPengangkatanPembayaranInvoice(body);

    if (!ApiProvider.isStatusCodeOK(response.statusCode)) {
      return;
    }

    _pembayaranPengangkatan = PembayaranPengangkatan.fromJson(response.data);

    notifyListeners();
  }

  void getLatestPembayaranPengangkatan() {
    _pembayaranPengangkatan =
        _getPembayaranListOfPengangkatanResponse.pembayaranPengangkatan[0];

    notifyListeners();
  }

  Future<void> onPressedLunasiPembayaran() async {
    if (_getPembayaranListOfPengangkatanResponse.shouldCreateNewPayment &&
        _pengangkatan.statusPembayaran != StatusPembayaran.lunas) {
      await createPembayaranPengangkatan();
    } else {
      getLatestPembayaranPengangkatan();
    }
  }
}
