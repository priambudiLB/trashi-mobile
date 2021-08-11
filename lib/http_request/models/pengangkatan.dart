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
  final int harga;
  final int hargaterbayar;
  @JsonKey(name: 'statuspembayaran')
  final StatusPembayaran statusPembayaran;
  @JsonKey(name: 'statuspengangkatan')
  final StatusPengangkatan statusPengangkatan;
  @JsonKey(name: 'isnow')
  final bool isNow;
  final String username;
  final String userId;
  final String userfirstname;
  final String userlastname;
  final DateTime createdAt;
  final DateTime updatedAt;

  Pengangkatan({
    this.userId,
    this.userfirstname,
    this.userlastname,
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
    this.hargaterbayar,
  });

  factory Pengangkatan.fromJson(Map<String, dynamic> json) =>
      _$PengangkatanFromJson(json);

  Map<String, dynamic> toJson() => _$PengangkatanToJson(this);
}

@JsonSerializable()
class CreatePengangkatanRequest {
  String berat;
  String jenisbarang;
  String jeniskendaraan;
  int dp;
  DateTime waktupengangkatan;
  String lokasi;
  double lat;
  double long;
  int harga;
  bool isnow;

  CreatePengangkatanRequest(
      {this.berat,
      this.dp,
      this.harga,
      this.isnow,
      this.jenisbarang,
      this.jeniskendaraan,
      this.lat,
      this.lokasi,
      this.long,
      this.waktupengangkatan});

  factory CreatePengangkatanRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePengangkatanRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePengangkatanRequestToJson(this);
}

@JsonSerializable()
class CreatePengangkatanResponse {
  Pengangkatan pengangkatan;
  CreatePengangkatanResponse({this.pengangkatan});

  factory CreatePengangkatanResponse.fromJson(Map<String, dynamic> json) =>
      _$CreatePengangkatanResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CreatePengangkatanResponseToJson(this);
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

@JsonSerializable()
class FinishPengangkatanRequest {
  final int idPengangkatan;

  FinishPengangkatanRequest({
    this.idPengangkatan,
  });

  factory FinishPengangkatanRequest.fromJson(Map<String, dynamic> json) =>
      _$FinishPengangkatanRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FinishPengangkatanRequestToJson(this);
}

@JsonSerializable()
class HistoriPengangkatanResponse {
  final List<Pengangkatan> pengangkatan;
  final bool hasInvalidPayment;

  HistoriPengangkatanResponse({
    this.pengangkatan,
    this.hasInvalidPayment,
  });

  factory HistoriPengangkatanResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoriPengangkatanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HistoriPengangkatanResponseToJson(this);
}
