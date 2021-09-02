import 'package:json_annotation/json_annotation.dart';
part 'pembayaran.g.dart';

@JsonSerializable()
class PembayaranResponse {
  @JsonKey(name: '_id')
  final int id;
  final String externalID;
  @JsonKey(name: 'invoice_id')
  final String invoiceID;
  @JsonKey(name: 'invoice_url')
  final String invoiceURL;
  @JsonKey(name: 'expiry_date')
  final DateTime expiryDate;
  @JsonKey(name: 'sourceId ')
  final int sourceId;
  final String status;
  final int internalStatus;
  @JsonKey(name: 'userId')
  final String userID;
  final int amount;

  PembayaranResponse({
    this.id,
    this.externalID,
    this.invoiceID,
    this.invoiceURL,
    this.expiryDate,
    this.sourceId,
    this.status,
    this.internalStatus,
    this.userID,
    this.amount,
  });

  factory PembayaranResponse.fromJson(Map<String, dynamic> json) =>
      _$PembayaranResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PembayaranResponseToJson(this);
}

@JsonSerializable()
class PembayaranInvoiceRequest {
  final int amount;
  @JsonKey(name: 'sourceId')
  final int sourceId;
  final String sourceType;

  PembayaranInvoiceRequest({this.amount, this.sourceId, this.sourceType});

  factory PembayaranInvoiceRequest.fromJson(Map<String, dynamic> json) =>
      _$PembayaranInvoiceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PembayaranInvoiceRequestToJson(this);
}
