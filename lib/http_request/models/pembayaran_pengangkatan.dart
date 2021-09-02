import 'package:json_annotation/json_annotation.dart';
import 'package:trashi/http_request/models/pembayaran.dart';

part 'pembayaran_pengangkatan.g.dart';

@JsonSerializable()
class PembayaranPengangkatan {
  @JsonKey(name: '_id')
  final int id;
  final String externalID;
  @JsonKey(name: 'invoice_id')
  final String invoiceID;
  @JsonKey(name: 'invoice_url')
  final String invoiceURL;
  @JsonKey(name: 'expiry_date')
  final DateTime expiryDate;
  @JsonKey(name: 'idPengangkatan')
  final int pengangkatanID;
  final String status;
  final int internalStatus;
  @JsonKey(name: 'userId')
  final String userID;
  final int amount;

  PembayaranPengangkatan({
    this.id,
    this.externalID,
    this.invoiceID,
    this.invoiceURL,
    this.expiryDate,
    this.pengangkatanID,
    this.status,
    this.internalStatus,
    this.userID,
    this.amount,
  });

  factory PembayaranPengangkatan.fromJson(Map<String, dynamic> json) =>
      _$PembayaranPengangkatanFromJson(json);

  Map<String, dynamic> toJson() => _$PembayaranPengangkatanToJson(this);
}

/// response of this endpoint: /api/pengangkatan/:id/pembayaran/list
@JsonSerializable()
class GetPembayaranListOfPengangkatanResponse {
  final List<PembayaranResponse> pembayaranPengangkatan;
  final bool hasInvalidPayment;
  final bool shouldCreateNewPayment;

  GetPembayaranListOfPengangkatanResponse({
    this.pembayaranPengangkatan,
    this.hasInvalidPayment,
    this.shouldCreateNewPayment,
  });

  factory GetPembayaranListOfPengangkatanResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetPembayaranListOfPengangkatanResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetPembayaranListOfPengangkatanResponseToJson(this);
}

/// request for this endpoint: /api/pengangkatan/pembayaran/invoice/create
@JsonSerializable()
class CreatePengangkatanPembayaranInvoiceRequest {
  final int amount;
  @JsonKey(name: 'idPengangkatan')
  final int pengangkatanID;

  CreatePengangkatanPembayaranInvoiceRequest({
    this.amount,
    this.pengangkatanID,
  });

  factory CreatePengangkatanPembayaranInvoiceRequest.fromJson(
          Map<String, dynamic> json) =>
      _$CreatePengangkatanPembayaranInvoiceRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreatePengangkatanPembayaranInvoiceRequestToJson(this);
}

/// response for this endpoint: /api/pengangkatan/pembayaran/invoice/create
@JsonSerializable()
class CreatePengangkatanPembayaranInvoiceResponse {
  final String id;
  @JsonKey(name: 'external_id')
  final String externalID;
  final String status;
  @JsonKey(name: 'invoice_url')
  final String invoiceURL;
  final int amount;

  CreatePengangkatanPembayaranInvoiceResponse({
    this.id,
    this.externalID,
    this.status,
    this.invoiceURL,
    this.amount,
  });

  factory CreatePengangkatanPembayaranInvoiceResponse.fromJson(
          Map<String, dynamic> json) =>
      _$CreatePengangkatanPembayaranInvoiceResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreatePengangkatanPembayaranInvoiceResponseToJson(this);
}
