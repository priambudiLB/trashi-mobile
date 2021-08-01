import 'package:json_annotation/json_annotation.dart';
import 'package:trashi/http_request/models/kabupaten.dart';
import 'package:trashi/http_request/models/location_center.dart';

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
  final LocationCenter center;

  Kecamatan({
    this.kabupaten,
    this.v,
    this.id,
    this.name,
    this.center,
  });

  factory Kecamatan.fromJson(Map<String, dynamic> json) =>
      _$KecamatanFromJson(json);
  Map<String, dynamic> toJson() => _$KecamatanToJson(this);
}

class KecamatanResponse {
  final List<Kecamatan> list;

  KecamatanResponse({this.list});

  factory KecamatanResponse.fromJson(List<dynamic> json) => KecamatanResponse(
        list: json
            .map(
              (item) => Kecamatan.fromJson(item),
            )
            .toList(),
      );
}

@JsonSerializable()
class KecamatanForUPSTResponse {
  @JsonKey(name: '_id')
  final int id;
  final int kabupaten;
  @JsonKey(name: 'nama')
  final String name;
  @JsonKey(name: '__v')
  final int v;
  final LocationCenter center;

  KecamatanForUPSTResponse({
    this.kabupaten,
    this.v,
    this.id,
    this.name,
    this.center,
  });

  factory KecamatanForUPSTResponse.fromJson(Map<String, dynamic> json) =>
      _$KecamatanForUPSTResponseFromJson(json);
  Map<String, dynamic> toJson() => _$KecamatanForUPSTResponseToJson(this);
}
