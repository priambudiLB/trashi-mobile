import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:trashi/http_request/models/auth.dart';
import 'package:trashi/secure_storage/secure_storage.dart';

class ApiProvider {
  Dio _dio;
  String token = '';
  SecureStorage _secureStorage = SecureStorage();

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
          final sessionToken = await _secureStorage.getSessionToken();

          // to prevent other request enter this interceptor.
          _dio.interceptors.requestLock.lock();
          // We use a new Dio(to avoid dead lock) instance to request token.
          //Set the cookie to headers

          if (sessionToken != null)
            options.headers['cookie'] = sessionToken.token;

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

  Future<void> _saveTokenFromCookies(List<String> cookies) async {
    if (cookies.isNotEmpty && cookies.length > 0) {
      List<String> splittedCookies = cookies[0].split(';');

      if (splittedCookies.length > 0) {
        String requestToken = splittedCookies[0];

        final sessionToken = SessionToken(token: requestToken);
        await _secureStorage.setSessionToken(sessionToken);
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

    await _saveTokenFromCookies(cookies);

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

    await _saveTokenFromCookies(cookies);

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

    await _saveTokenFromCookies(cookies);

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

    await _saveTokenFromCookies(cookies);

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

  Future<String> validateVerificationCode(
      ValidateVerificationCodeRequest body) async {
    final response = await _dio.post('/token/verify', data: body).catchError(
          _onError,
        );

    if (response == null) {
      return null;
    }

    return response.toString();
  }
}


/**
 * SOURCE:
 * https://medium.com/@prolongservices.com/how-to-set-cookie-in-header-with-the-request-flutter-dea56efc71a6
 */