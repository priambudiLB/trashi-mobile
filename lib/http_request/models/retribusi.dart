import 'package:json_annotation/json_annotation.dart';

part 'retribusi.g.dart';

@JsonSerializable()
class Retribusi {
  final String idTransaksi;
  final int tarif;
  final String alamat;
  final String status;
  final String penanggungJawab;

  Retribusi({
    this.idTransaksi,
    this.tarif,
    this.alamat,
    this.status,
    this.penanggungJawab,
  });

  factory Retribusi.fromJson(Map<String, dynamic> json) =>
      _$RetribusiFromJson(json);

  Map<String, dynamic> toJson() => _$RetribusiToJson(this);
}

@JsonSerializable()
class GetRetribusiListResponse {
  List<Retribusi> retribusi;

  GetRetribusiListResponse({
    this.retribusi,
  });

  factory GetRetribusiListResponse.fromJson(Map<String, dynamic> json) =>
      _$GetRetribusiListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetRetribusiListResponseToJson(this);
}
