import 'package:json_annotation/json_annotation.dart';
import 'package:trashi/constants/time.dart';

part 'retribusi.g.dart';

@JsonSerializable()
class Retribusi {
  @JsonKey(name: '_id')
  final int id;
  final String idTransaksi;
  final int tarif;
  final String alamat;
  final String penanggungJawab;
  final int kabupatenID;
  final int kecamatanID;
  final int upstID;
  final List<StatusRetribusi> statuses;

  Retribusi({
    this.idTransaksi,
    this.tarif,
    this.alamat,
    this.penanggungJawab,
    this.id,
    this.kabupatenID,
    this.kecamatanID,
    this.upstID,
    this.statuses,
  });

  factory Retribusi.fromJson(Map<String, dynamic> json) =>
      _$RetribusiFromJson(json);

  Map<String, dynamic> toJson() => _$RetribusiToJson(this);
}

@JsonSerializable()
class StatusRetribusi {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'monthCode')
  final Month month;
  final int year;
  final bool isApproved;

  StatusRetribusi({
    this.id,
    this.month,
    this.year,
    this.isApproved,
  });

  factory StatusRetribusi.fromJson(Map<String, dynamic> json) =>
      _$StatusRetribusiFromJson(json);

  Map<String, dynamic> toJson() => _$StatusRetribusiToJson(this);
}

@JsonSerializable()
class GetRetribusiListResponse {
  List<Retribusi> list;

  GetRetribusiListResponse({
    this.list,
  });

  factory GetRetribusiListResponse.fromJson(List<dynamic> json) =>
      GetRetribusiListResponse(
        list: json
            .map(
              (e) => Retribusi.fromJson(e),
            )
            .toList(),
      );

  Map<String, dynamic> toJson() => _$GetRetribusiListResponseToJson(this);
}

class GetRetribusiListFilter {
  final int statusesMonth;
  final int statusesYear;
  final bool isApproved;
  final int kabupatenID;
  final int kecamatanID;
  final int upstID;
  final int skip;

  final int defaultLimit = 5;

  GetRetribusiListFilter({
    this.statusesMonth,
    this.statusesYear,
    this.isApproved,
    this.kabupatenID,
    this.kecamatanID,
    this.upstID,
    this.skip,
  });

  String get getFilterAsString {
    String statusesMonthFilterString = this.statusesMonth?.toString() ?? '';
    String statusesYearFilterString = this.statusesYear?.toString() ?? '';
    String isApprovedFilterString = this.isApproved?.toString() ?? '';
    String kabupatenIDFilterString = this.kabupatenID?.toString() ?? '';
    String kecamatanIDFilterString = this.kecamatanID?.toString() ?? '';
    String upstIDFilterString = this.upstID?.toString() ?? '';
    String skipFilterString = this.skip?.toString() ?? '';

    return '?statuses.monthCode=$statusesMonthFilterString&statuses.year=$statusesYearFilterString&statuses.isApproved=$isApprovedFilterString&kabupaten=$kabupatenIDFilterString&kecamatan=$kecamatanIDFilterString&upst=$upstIDFilterString&limit=$defaultLimit&skip=$skipFilterString';
  }
}
