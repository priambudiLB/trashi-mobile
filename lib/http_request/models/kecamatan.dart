import 'package:json_annotation/json_annotation.dart';
import 'package:trashi/http_request/models/kabupaten.dart';

part 'kecamatan.g.dart';

@JsonSerializable()
class Kecamatan {
  @JsonKey(name: '_id')
  final int id;
  final Kabupaten kabupaten;
  @JsonKey(name: 'nama')
  final String name;
  @JsonKey(name: '__v')
  final int v;

  Kecamatan({
    this.kabupaten,
    this.v,
    this.id,
    this.name,
  });

  factory Kecamatan.fromJson(Map<String, dynamic> json) =>
      _$KecamatanFromJson(json);
  Map<String, dynamic> toJson() => _$KecamatanToJson(this);
}
