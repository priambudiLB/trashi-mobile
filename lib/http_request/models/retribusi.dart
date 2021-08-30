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

@JsonSerializable()
class ApproveRetribusiRequest {
  @JsonKey(name: '_id')
  final int idRetribusi;
  @JsonKey(name: 'monthCode')
  final Month month;
  final int year;

  ApproveRetribusiRequest({
    this.idRetribusi,
    this.month,
    this.year,
  });

  factory ApproveRetribusiRequest.fromJson(Map<String, dynamic> json) =>
      _$ApproveRetribusiRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ApproveRetribusiRequestToJson(this);
}

@JsonSerializable()
class RetribusiNowResponse {
  @JsonKey(name: '_id')
  final int id;
  final int yearMonth;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final RumahResponse rumah;

  RetribusiNowResponse({
    this.id,
    this.yearMonth,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.rumah,
  });

  factory RetribusiNowResponse.fromJson(Map<String, dynamic> json) =>
      _$RetribusiNowResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RetribusiNowResponseToJson(this);
}

@JsonSerializable()
class RumahResponse {
  @JsonKey(name: '_id')
  final int id;
  final List<String> penanggungJawabIds;
  final String userId;
  final String firstname;
  final String lastname;
  final String alamat;
  final double lat;
  final double long;
  @JsonKey(name: 'kabupaten')
  final int kabupatenID;
  @JsonKey(name: 'kecamatan')
  final int kecamatanID;
  @JsonKey(name: 'kelurahan')
  final int kelurahanID;
  @JsonKey(name: 'upst')
  final int upstID;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int tarifRetribusi;

  RumahResponse({
    this.id,
    this.penanggungJawabIds,
    this.userId,
    this.firstname,
    this.lastname,
    this.alamat,
    this.lat,
    this.long,
    this.kabupatenID,
    this.kecamatanID,
    this.kelurahanID,
    this.upstID,
    this.createdAt,
    this.updatedAt,
    this.tarifRetribusi,
  });

  factory RumahResponse.fromJson(Map<String, dynamic> json) =>
      _$RumahResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RumahResponseToJson(this);

  String get fullName {
    return this.firstname + ' ' + this.lastname;
  }
}

@JsonSerializable()
class RetribusiAllItemResponse {
  @JsonKey(name: '_id')
  final int id;
  @JsonKey(name: 'rumah')
  final int rumahID;
  final int yearMonth;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  RetribusiAllItemResponse({
    this.id,
    this.rumahID,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.yearMonth,
  });

  factory RetribusiAllItemResponse.fromJson(Map<String, dynamic> json) =>
      _$RetribusiAllItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RetribusiAllItemResponseToJson(this);

  int get year {
    String yearMonthStr = this.yearMonth.toString();

    final year = yearMonthStr.substring(0, 4);
    final month = yearMonthStr.substring(4);

    return int.parse(year);
  }

  int get month {
    String yearMonthStr = this.yearMonth.toString();

    final year = yearMonthStr.substring(0, 4);
    final month = yearMonthStr.substring(4);

    return int.parse(month);
  }

  String get monthText {
    return getMonthText(this.month);
  }
}

@JsonSerializable()
class GetRetribusiListItemResponse {
  final RetribusiNowResponse now;
  final List<RetribusiAllItemResponse> all;

  GetRetribusiListItemResponse({
    this.now,
    this.all,
  });

  factory GetRetribusiListItemResponse.fromJson(Map<String, dynamic> json) =>
      _$GetRetribusiListItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetRetribusiListItemResponseToJson(this);
}

@JsonSerializable()
class GetRetribusiListResponseV2 {
  List<GetRetribusiListItemResponse> list;

  GetRetribusiListResponseV2({
    this.list,
  });

  factory GetRetribusiListResponseV2.fromJson(List<dynamic> json) =>
      GetRetribusiListResponseV2(
        list: json
            .map(
              (e) => GetRetribusiListItemResponse.fromJson(e),
            )
            .toList(),
      );

  Map<String, dynamic> toJson() => _$GetRetribusiListResponseV2ToJson(this);
}

class GetRetribusiListFilterV2 {
  String yearMonth;
  int kabupatenID;
  int kecamatanID;
  int upstID;
  int status;
  int skip;
  int defaultLimit = 5;

  GetRetribusiListFilterV2({
    this.yearMonth,
    this.kabupatenID,
    this.kecamatanID,
    this.upstID,
    this.status,
    this.skip,
  });

  String get getFilterAsString {
    String yearMonthFilterString = this.yearMonth?.toString() ?? '';
    String kabupatenIDFilterString = this.kabupatenID?.toString() ?? '';
    String kecamatanIDFilterString = this.kecamatanID?.toString() ?? '';
    String upstIDFilterString = this.upstID?.toString() ?? '';
    String skipFilterString = this.skip?.toString() ?? '';
    String statusFilterString = this.status?.toString() ?? '';

    return '?yearMonth=$yearMonthFilterString&rumah.kabupaten=$kabupatenIDFilterString&rumah.kecamatan=$kecamatanIDFilterString&rumah.upst=$upstIDFilterString&status=$statusFilterString&limit=$defaultLimit&skip=$skipFilterString';
  }

  String getFilterString() {
    String filter = '?limit=10';

    if (this.yearMonth != null) {
      String yearMonthFilterString = this.yearMonth?.toString() ?? '';
      filter += '&yearMonth=$yearMonthFilterString';
    }

    if (this.kabupatenID != null) {
      String kabupatenIDFilterString = this.kabupatenID?.toString() ?? '';
      filter += '&rumah.kabupaten=$kabupatenIDFilterString';
    }

    if (this.kecamatanID != null) {
      String kecamatanIDFilterString = this.kecamatanID?.toString() ?? '';
      filter += '&rumah.kecamatan=$kecamatanIDFilterString';
    }

    if (this.upstID != null) {
      String upstIDFilterString = this.upstID?.toString() ?? '';
      filter += '&rumah.upst=$upstIDFilterString';
    }

    if (this.status != null) {
      String statusFilterString = this.status?.toString() ?? '';
      filter += '&status=$statusFilterString';
    }

    if (this.skip != null) {
      String skipFilterString = this.skip?.toString() ?? '';
      filter += '&skip=$skipFilterString';
    }

    return filter;
  }
}
