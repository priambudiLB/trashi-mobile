import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class SignInRequest {
  String username;
  String password;

  SignInRequest({
    this.username,
    this.password,
  });

  factory SignInRequest.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignInRequestToJson(this);
}

@JsonSerializable()
class SignInResponse {
  int isAcc;
  @JsonKey(name: '_id')
  String id;
  String username;
  int role;
  @JsonKey(name: 'firstname')
  String firstName;
  @JsonKey(name: 'lastName')
  String lastName;

  SignInResponse({
    this.isAcc,
    this.id,
    this.username,
    this.role,
    this.firstName,
    this.lastName,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);
}

@JsonSerializable()
class SignInByPhoneRequest {
  String phone;
  String password;

  SignInByPhoneRequest({this.phone, this.password});

  factory SignInByPhoneRequest.fromJson(Map<String, dynamic> json) =>
      _$SignInByPhoneRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignInByPhoneRequestToJson(this);
}

@JsonSerializable()
class SignInByPhoneResponse {
  int isAcc;
  @JsonKey(name: '_id')
  String id;
  int role;
  @JsonKey(name: 'firstname')
  String firstName;
  @JsonKey(name: 'lastName')
  String lastName;
  String phone;

  SignInByPhoneResponse({
    this.isAcc,
    this.id,
    this.role,
    this.firstName,
    this.lastName,
    this.phone,
  });

  factory SignInByPhoneResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInByPhoneResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SignInByPhoneResponseToJson(this);
}
