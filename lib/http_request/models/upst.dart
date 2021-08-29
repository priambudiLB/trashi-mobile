import 'package:json_annotation/json_annotation.dart';
import 'package:trashi/http_request/models/kabupaten.dart';
import 'package:trashi/http_request/models/kecamatan.dart';
import 'package:trashi/http_request/models/kelurahan.dart';

part 'upst.g.dart';

@JsonSerializable()
class UPSTHTTPModel {
  @JsonKey(name: '_id')
  final int id;

  @JsonKey(name: 'nama')
  final String name;

  @JsonKey(name: 'lat')
  final double latitude;

  @JsonKey(name: 'long')
  final double longitude;

  @JsonKey(name: '__v')
  final int v;

  final KecamatanForUPSTResponse kecamatan;
  final Kabupaten kabupaten;
  final Kelurahan kelurahan;

  UPSTHTTPModel({
    this.kelurahan,
    this.latitude,
    this.longitude,
    this.v,
    this.kecamatan,
    this.kabupaten,
    this.id,
    this.name,
  });

  factory UPSTHTTPModel.fromJson(Map<String, dynamic> json) =>
      _$UPSTHTTPModelFromJson(json);
  Map<String, dynamic> toJson() => _$UPSTHTTPModelToJson(this);
}

class UPSTResponse {
  final List<UPSTHTTPModel> list;

  UPSTResponse({this.list});

  factory UPSTResponse.fromJson(List<dynamic> json) => UPSTResponse(
        list: json
            .map(
              (item) => UPSTHTTPModel.fromJson(item),
            )
            .toList(),
      );
}
