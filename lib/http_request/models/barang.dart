import 'package:json_annotation/json_annotation.dart';

part 'barang.g.dart';

@JsonSerializable()
class Barang {
  @JsonKey(name: '_id')
  int id;
  String nama;

  Barang({this.id, this.nama});

  factory Barang.fromJson(Map<String, dynamic> json) => _$BarangFromJson(json);
  Map<String, dynamic> toJson() => _$BarangToJson(this);
}

@JsonSerializable()
class ListBarangReponse {
  List<Barang> list;

  ListBarangReponse(this.list);

  factory ListBarangReponse.fromJson(List<dynamic> json) =>
      ListBarangReponse(json.map((e) => Barang.fromJson(e)).toList());
}
