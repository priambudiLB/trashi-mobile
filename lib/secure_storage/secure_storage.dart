import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:trashi/http_request/models/auth.dart';

enum SecureStorageKeys {
  signInByPhoneResponse,
  signInResponse,
  sessionToken,
}

extension SecureStorageKeysExtension on SecureStorageKeys {
  String get key {
    switch (this) {
      case SecureStorageKeys.signInByPhoneResponse:
        return 'signInByPhoneResponse';
      case SecureStorageKeys.signInResponse:
        return 'signInResponse';
      case SecureStorageKeys.sessionToken:
        return 'sessionToken';
      default:
        return '';
    }
  }
}

class SecureStorage {
  Future<dynamic> _get(SecureStorageKeys key) async {
    final storage = new FlutterSecureStorage();

    String data = await storage.read(
      key: key.key,
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
      case SecureStorageKeys.sessionToken:
        return SessionToken.fromJson(jsonData);
    }
  }

  Future<void> _set(SecureStorageKeys key, dynamic value) async {
    final storage = new FlutterSecureStorage();

    String jsonValue = json.encode(value);

    await storage.write(key: key.key, value: jsonValue);
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

  Future<SessionToken> getSessionToken() async {
    return await _get(SecureStorageKeys.sessionToken);
  }

  // SETTERS
  Future<void> setSignInResponse(SignInResponse value) async {
    await _set(SecureStorageKeys.signInResponse, value);
  }

  Future<void> setSignInByPhoneResponse(SignInByPhoneResponse value) async {
    await _set(SecureStorageKeys.signInByPhoneResponse, value);
  }

  Future<void> setSessionToken(SessionToken value) async {
    await _set(SecureStorageKeys.sessionToken, value);
  }
}
