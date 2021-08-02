import 'package:json_annotation/json_annotation.dart';

enum StatusPengangkatan {
  @JsonValue(1)
  menungguPengambilan,
  @JsonValue(2)
  selesai,
}

extension StatusPengangkatanExtension on StatusPengangkatan {
  static const statusPengangkatanText = {
    StatusPengangkatan.menungguPengambilan: 'Menunggu Pengambilan',
    StatusPengangkatan.selesai: 'Selesai'
  };

  String get text => statusPengangkatanText[this];
}

enum StatusPembayaran {
  @JsonValue(1)
  belumBayar,
  @JsonValue(2)
  belumLunas,
  @JsonValue(3)
  lunas,
}

extension StatusPembayaranExtension on StatusPembayaran {
  static const statusPembayaranText = {
    StatusPembayaran.belumBayar: 'Belum Bayar',
    StatusPembayaran.belumLunas: 'Belum Lunas',
    StatusPembayaran.lunas: 'Selesai'
  };

  String get text => statusPembayaranText[this];
}
