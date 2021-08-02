import 'package:json_annotation/json_annotation.dart';
import 'package:trashi/constants/pengangkatan.dart';

part 'pengangkatan.g.dart';

@JsonSerializable()
class Pengangkatan {
  @JsonKey(name: '_id')
  final int id;
  final String berat;
  @JsonKey(name: 'jenisbarang')
  final String jenisBarang;
  @JsonKey(name: 'jeniskendaraan')
  final String jenisKendaraan;
  final int dp;
  @JsonKey(name: 'waktupengangkatan')
  final DateTime waktuPengangkatan;
  final String lokasi;
  @JsonKey(name: 'lat')
  final double latitude;
  @JsonKey(name: 'long')
  final double longitude;
  final String username;
  @JsonKey(name: 'isnow')
  final bool isNow;
  final int harga;
  @JsonKey(name: 'statuspembayaran')
  final StatusPembayaran statusPembayaran;
  @JsonKey(name: 'statuspengangkatan')
  final StatusPengangkatan statusPengangkatan;
  final DateTime createdAt;
  final DateTime updatedAt;

  Pengangkatan({
    this.id,
    this.berat,
    this.jenisBarang,
    this.jenisKendaraan,
    this.dp,
    this.waktuPengangkatan,
    this.lokasi,
    this.latitude,
    this.longitude,
    this.username,
    this.isNow,
    this.harga,
    this.statusPembayaran,
    this.statusPengangkatan,
    this.createdAt,
    this.updatedAt,
  });

  factory Pengangkatan.fromJson(Map<String, dynamic> json) =>
      _$PengangkatanFromJson(json);

  Map<String, dynamic> toJson() => _$PengangkatanToJson(this);
}

@JsonSerializable()
class PengangkatanListAdminResponse {
  final List<Pengangkatan> isNow;
  final List<Pengangkatan> notIsNow;
  final List<Pengangkatan> done;

  PengangkatanListAdminResponse({
    this.isNow,
    this.notIsNow,
    this.done,
  });

  factory PengangkatanListAdminResponse.fromJson(Map<String, dynamic> json) =>
      _$PengangkatanListAdminResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PengangkatanListAdminResponseToJson(this);
}
