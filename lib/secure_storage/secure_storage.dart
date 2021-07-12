import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trashi/http_request/models/auth.dart';

enum SecureStorageKeys {
  signInByPhoneResponse,
  signInResponse,
}

class SecureStorageKeysString {
  static String getString(SecureStorageKeys key) {
    switch (key) {
      case SecureStorageKeys.signInResponse:
        return 'signInResponse';
      case SecureStorageKeys.signInByPhoneResponse:
        return 'signInByPhoneResponse';
    }
  }
}

class SecureStorage {
  Future<dynamic> _get(SecureStorageKeys key) async {
    final storage = new FlutterSecureStorage();

    String data = await storage.read(
      key: SecureStorageKeysString.getString(key),
    );

    if (data == null) {
      return null;
    }

    Map<String, dynamic> jsonData = jsonDecode(data);

    switch (key) {
      case SecureStorageKeys.signInByPhoneResponse:
        return SignInByPhoneResponse.fromJson(jsonData);
      case SecureStorageKeys.signInResponse:
        return SignInResponse.fromJson(jsonData);
    }
  }

  Future<void> _set(SecureStorageKeys key, dynamic value) async {
    final storage = new FlutterSecureStorage();

    String jsonValue = json.encode(value);

    await storage.write(
        key: SecureStorageKeysString.getString(key), value: jsonValue);
  }

  Future<void> deleteAll() async {
    final storage = new FlutterSecureStorage();
    await storage.deleteAll();
  }

  // GETTERS
  Future<SignInResponse> getSignInResponse() async {
    return await _get(SecureStorageKeys.signInResponse);
  }

  Future<SignInByPhoneResponse> getSignInByPhoneResponse() async {
    return await _get(SecureStorageKeys.signInByPhoneResponse);
  }

  // SETTERS
  Future<void> setSignInResponse(SignInResponse value) async {
    await _set(SecureStorageKeys.signInResponse, value);
  }

  Future<void> setSignInByPhoneResponse(SignInByPhoneResponse value) async {
    await _set(SecureStorageKeys.signInByPhoneResponse, value);
  }
}
