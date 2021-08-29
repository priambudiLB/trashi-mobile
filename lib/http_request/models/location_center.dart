import 'package:json_annotation/json_annotation.dart';

part 'location_center.g.dart';

@JsonSerializable()
class LocationCenter {
  @JsonKey(name: 'lat')
  final double latitude;
  @JsonKey(name: 'long')
  final double longitude;

  LocationCenter({
    this.latitude,
    this.longitude,
  });

  factory LocationCenter.fromJson(Map<String, dynamic> json) =>
      _$LocationCenterFromJson(json);

  Map<String, dynamic> toJson() => _$LocationCenterToJson(this);
}
