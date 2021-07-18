import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trashi/http_request/models/auth.dart';
import 'package:trashi/http_request/trashi_client.dart';
import 'package:trashi/secure_storage/secure_storage.dart';
import 'package:dio/dio.dart';

class SplashScreenProvider with ChangeNotifier, DiagnosticableTreeMixin {
  SecureStorage _secureStorage = SecureStorage();
  bool _isLogin = false;
  bool _fetchingDone = false;
  bool get isLogin => _isLogin;
  bool get fetchingDone => _fetchingDone;
  void fetchData() async {
    await _secureStorage.deleteAll();
    Future.delayed(Duration(seconds: 2), () async {
      final client = TrashiClient(
        Dio(
          BaseOptions(contentType: 'application/json'),
        ),
      );

      CurrentUserResponse response;
      await client.getCurrentUser().then((value) {
        response = value;
      });
      print(response.currentUser);
      if (response.currentUser != null) {
        await _secureStorage.setCurrentUserResponse(response);
        setIsLogin(true);
      } else {
        setIsLogin(false);
      }
      setFetchingDone(true);
    });
  }

  void setIsLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }

  void setFetchingDone(bool value) {
    _fetchingDone = value;
    notifyListeners();
  }
}
