import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class SignInRequest {
  @JsonKey(name: 'username')
  String email;
  String password;
  String requestSource;

  SignInRequest({this.email, this.password, this.requestSource});

  factory SignInRequest.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignInRequestToJson(this);
}

@JsonSerializable()
class SignInResponse {
  int isAcc;
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'username')
  String email;
  int role;
  @JsonKey(name: 'firstname')
  String firstName;
  @JsonKey(name: 'lastName')
  String lastName;

  SignInResponse({
    this.isAcc,
    this.id,
    this.email,
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
  String requestSource;

  SignInByPhoneRequest({this.phone, this.password, this.requestSource});

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

@JsonSerializable()
class CurrentUser {
  int isAcc;
  @JsonKey(name: 'id')
  String id;
  int role;
  @JsonKey(name: 'firstname')
  String firstName;
  @JsonKey(name: 'lastname')
  String lastName;
  String phone;
  String username;
  int iat;
  List<String> label;
  List<dynamic> permission;

  CurrentUser(
      {this.isAcc,
      this.id,
      this.role,
      this.firstName,
      this.lastName,
      this.phone,
      this.username,
      this.iat,
      this.label,
      this.permission});

  factory CurrentUser.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentUserToJson(this);
}

@JsonSerializable()
class CurrentUserResponse {
  CurrentUser currentUser;
  CurrentUserResponse({this.currentUser});

  factory CurrentUserResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentUserResponseToJson(this);
}

@JsonSerializable()
class SignUpRequest {
  @JsonKey(name: 'username')
  String email;
  String password;
  String firstname;
  String lastname;
  int role;

  SignUpRequest({
    this.email,
    this.password,
    this.firstname,
    this.lastname,
    this.role,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}

@JsonSerializable()
class SignUpByPhoneRequest {
  String phone;
  String password;
  String firstname;
  String lastname;
  int role;

  SignUpByPhoneRequest({
    this.phone,
    this.password,
    this.firstname,
    this.lastname,
    this.role,
  });

  factory SignUpByPhoneRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpByPhoneRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpByPhoneRequestToJson(this);
}

@JsonSerializable()
class GenerateVerificationCodeRequest {
  final String method;

  GenerateVerificationCodeRequest({
    this.method,
  });

  factory GenerateVerificationCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$GenerateVerificationCodeRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GenerateVerificationCodeRequestToJson(this);
}

@JsonSerializable()
class GenerateVerificationCodeResponse {
  @JsonKey(name: '_id')
  String id;
  String userId;
  String username;
  String code;
  DateTime expiry;
  DateTime delay;
  @JsonKey(name: '__v')
  int v;
  String method;

  GenerateVerificationCodeResponse({
    this.id,
    this.userId,
    this.username,
    this.code,
    this.expiry,
    this.delay,
    this.v,
    this.method,
  });

  factory GenerateVerificationCodeResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GenerateVerificationCodeResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GenerateVerificationCodeResponseToJson(this);
}

@JsonSerializable()
class SessionToken {
  String token;

  SessionToken({
    this.token,
  });

  factory SessionToken.fromJson(Map<String, dynamic> json) =>
      _$SessionTokenFromJson(json);

  Map<String, dynamic> toJson() => _$SessionTokenToJson(this);
}

@JsonSerializable()
class ValidateVerificationCodeRequest {
  String code;

  ValidateVerificationCodeRequest({
    this.code,
  });

  factory ValidateVerificationCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$ValidateVerificationCodeRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ValidateVerificationCodeRequestToJson(this);
}

@JsonSerializable()
class EditProfileResponse {
  int isAcc;
  @JsonKey(name: "_id")
  String id;
  String username;
  int role;
  String firstname;
  String lastname;
  String phone;

  EditProfileResponse(
      {this.isAcc,
      this.id,
      this.username,
      this.firstname,
      this.lastname,
      this.phone,
      this.role});

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$EditProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileResponseToJson(this);
}
