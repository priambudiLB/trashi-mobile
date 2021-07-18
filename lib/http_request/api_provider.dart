import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:trashi/http_request/models/auth.dart';

class ApiProvider {
  Dio _dio;
  String token = '';

  final BaseOptions options = new BaseOptions(
    contentType: 'application/json',
    baseUrl: 'http://192.168.100.4:5000/api',
    connectTimeout: 15000,
    receiveTimeout: 13000,
  );
  static final ApiProvider _instance = ApiProvider._internal();

  factory ApiProvider() => _instance;

  ApiProvider._internal() {
    _dio = Dio(options);
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (Options options) async {
          // to prevent other request enter this interceptor.
          _dio.interceptors.requestLock.lock();
          // We use a new Dio(to avoid dead lock) instance to request token.
          //Set the cookie to headers
          options.headers['cookie'] = token;

          _dio.interceptors.requestLock.unlock();
          return options; //continue
        },
      ),
    );
  }

  void _onError(Object obj) {
    switch (obj.runtimeType) {
      case DioError:
        // Here's the sample to get the failed response error code and message
        final res = (obj as DioError).response;
        Logger logger = Logger();
        logger.e('Got error : ${res.statusCode} -> ${res.statusMessage}');
        logger.e('Data : ${res.data}');
        break;
      default:
    }
  }

  void _saveTokenFromCookies(List<String> cookies) {
    if (cookies.isNotEmpty && cookies.length > 0) {
      List<String> splittedCookies = cookies[0].split(';');

      if (splittedCookies.length > 0) {
        String requestToken = splittedCookies[0];
        token = requestToken;

        print(token);
      }
    }
  }

  Future<SignInByPhoneResponse> signInByPhone(SignInByPhoneRequest body) async {
    final response = await _dio
        .post(
          '/auth/signin/byphone',
          data: body,
        )
        .catchError(
          _onError,
        );

    if (response == null) {
      return null;
    }

    final cookies = response.headers.map['set-cookie'];

    _saveTokenFromCookies(cookies);

    return SignInByPhoneResponse.fromJson(response.data);
  }

  Future<SignInResponse> signIn(SignInRequest body) async {
    final response = await _dio
        .post(
          '/auth/signin',
          data: body,
        )
        .catchError(
          _onError,
        );

    if (response == null) {
      return null;
    }

    final cookies = response.headers.map['set-cookie'];

    _saveTokenFromCookies(cookies);

    return SignInResponse.fromJson(response.data);
  }

  Future<dynamic> signOut() async {
    final response = await _dio
        .post(
          '/auth/signout',
        )
        .catchError(
          _onError,
        );

    if (response == null) {
      return null;
    }

    token = '';

    return response.data;
  }

  Future<SignInResponse> signUp(SignUpRequest body) async {
    final response = await _dio
        .post(
          '/auth/signup',
          data: body,
        )
        .catchError(
          _onError,
        );

    if (response == null) {
      return null;
    }

    final cookies = response.headers.map['set-cookie'];

    _saveTokenFromCookies(cookies);

    return SignInResponse.fromJson(response.data);
  }

  Future<SignInByPhoneResponse> signUpByPhone(SignUpByPhoneRequest body) async {
    final response = await _dio
        .post(
          '/auth/signup/byphone',
          data: body,
        )
        .catchError(
          _onError,
        );

    if (response == null) {
      return null;
    }

    final cookies = response.headers.map['set-cookie'];

    _saveTokenFromCookies(cookies);

    return SignInByPhoneResponse.fromJson(response.data);
  }

  Future<GenerateVerificationCodeResponse> generateVerificationCode(
    GenerateVerificationCodeRequest body,
  ) async {
    final response = await _dio
        .post(
          '/token/refresh',
          data: body,
        )
        .catchError(
          _onError,
        );

    if (response == null) {
      return null;
    }

    return GenerateVerificationCodeResponse.fromJson(response.data);
  }
}


/**
 * SOURCE:
 * https://medium.com/@prolongservices.com/how-to-set-cookie-in-header-with-the-request-flutter-dea56efc71a6
 */