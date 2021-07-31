import 'package:json_annotation/json_annotation.dart';
import 'package:trashi/http_request/models/location_center.dart';

part 'kabupaten.g.dart';

@JsonSerializable()
class Kabupaten {
  final LocationCenter center;
  @JsonKey(name: '_id')
  final int id;
  @JsonKey(name: 'nama')
  final String name;

  Kabupaten({
    this.center,
    this.id,
    this.name,
  });

  factory Kabupaten.fromJson(Map<String, dynamic> json) =>
      _$KabupatenFromJson(json);
  Map<String, dynamic> toJson() => _$KabupatenToJson(this);
}
