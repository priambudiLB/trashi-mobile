import 'package:json_annotation/json_annotation.dart';
import 'package:trashi/http_request/models/location_center.dart';

part 'kelurahan.g.dart';

@JsonSerializable()
class Kelurahan {
  final LocationCenter center;
  @JsonKey(name: '_id')
  final int id;
  @JsonKey(name: 'nama')
  final String name;
  final int kecamatan;
  @JsonKey(name: '__v')
  final int v;

  Kelurahan({
    this.center,
    this.id,
    this.name,
    this.kecamatan,
    this.v,
  });

  factory Kelurahan.fromJson(Map<String, dynamic> json) =>
      _$KelurahanFromJson(json);
  Map<String, dynamic> toJson() => _$KelurahanToJson(this);
}
