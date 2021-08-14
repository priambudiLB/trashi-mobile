import 'package:json_annotation/json_annotation.dart';

part 'errors.g.dart';

@JsonSerializable()
class ErrorResponse {
  final List<TrashiError> errors;

  ErrorResponse({
    this.errors,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  String get errorMessage {
    if (errors.length == 0) {
      return 'Terjadi kesalahan.';
    }

    String messages = '';

    errors.forEach((element) {
      messages += element.message + ',';
    });

    messages = messages.substring(0, messages.length - 1);

    return 'Terjadi kesalahan dengan detail berikut: $messages';
  }
}

@JsonSerializable()
class TrashiError {
  final String message;

  TrashiError({
    this.message,
  });

  factory TrashiError.fromJson(Map<String, dynamic> json) =>
      _$TrashiErrorFromJson(json);

  Map<String, dynamic> toJson() => _$TrashiErrorToJson(this);
}
