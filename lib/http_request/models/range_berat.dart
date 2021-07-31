import 'package:json_annotation/json_annotation.dart';

part 'range_berat.g.dart';

@JsonSerializable()
class RangeBerat {
  @JsonKey(name: '_id')
  int id;
  String range;

  RangeBerat({this.id, this.range});

  factory RangeBerat.fromJson(Map<String, dynamic> json) =>
      _$RangeBeratFromJson(json);
  Map<String, dynamic> toJson() => _$RangeBeratToJson(this);
}

@JsonSerializable()
class ListRangeBeratReponse {
  List<RangeBerat> list;

  ListRangeBeratReponse(this.list);

  factory ListRangeBeratReponse.fromJson(List<dynamic> json) =>
      ListRangeBeratReponse(json.map((e) => RangeBerat.fromJson(e)).toList());
}
