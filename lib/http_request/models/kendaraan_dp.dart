import 'package:json_annotation/json_annotation.dart';

part 'kendaraan_dp.g.dart';

@JsonSerializable()
class KendaraanDanDP {
  @JsonKey(name: '_id')
  int id;
  String kendaraan;
  int dp;

  KendaraanDanDP({this.id, this.kendaraan, this.dp});

  factory KendaraanDanDP.fromJson(Map<String, dynamic> json) =>
      _$KendaraanDanDPFromJson(json);
  Map<String, dynamic> toJson() => _$KendaraanDanDPToJson(this);
}

@JsonSerializable()
class ListKendaraanDanDPReponse {
  List<KendaraanDanDP> list;

  ListKendaraanDanDPReponse(this.list);

  factory ListKendaraanDanDPReponse.fromJson(List<dynamic> json) =>
      ListKendaraanDanDPReponse(
          json.map((e) => KendaraanDanDP.fromJson(e)).toList());
}
