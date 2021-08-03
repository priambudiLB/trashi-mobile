import 'package:flutter/foundation.dart';
import 'package:trashi/http_request/api_provider.dart';
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
}
