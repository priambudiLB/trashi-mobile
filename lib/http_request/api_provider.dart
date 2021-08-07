import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:trashi/http_request/models/auth.dart';
import 'package:trashi/http_request/models/barang.dart';
import 'package:trashi/http_request/models/kendaraan_dp.dart';
import 'package:trashi/http_request/models/pengangkatan.dart';
import 'package:trashi/http_request/models/range_berat.dart';
import 'package:trashi/models/trashi_document.dart';
import 'package:trashi/secure_storage/secure_storage.dart';
import 'package:trashi/constants/document_type.dart';

class ApiProvider {
  Dio _dio;
  String token = '';
  SecureStorage _secureStorage = SecureStorage();

  final BaseOptions options = new BaseOptions(
    baseUrl: 'http://10.0.2.2:5000/api',
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

  static bool isStatusCodeOK(int statusCode) {
    return statusCode >= 200 && statusCode <= 399;
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

  Future<CurrentUserResponse> getCurrentUser() async {
    final response = await _dio
        .get(
          '/auth/currentUser',
        )
        .catchError(
          _onError,
        );

    if (response == null) {
      return null;
    }
    return CurrentUserResponse.fromJson(response.data);
  }

  Future<ListBarangReponse> getBarang() async {
    final response = await _dio
        .get(
          '/map/barang',
        )
        .catchError(
          _onError,
        );

    if (response == null) {
      return null;
    }

    return ListBarangReponse.fromJson(response.data);
  }

  Future<ListKendaraanDanDPReponse> getKendaraanDanDP() async {
    final response = await _dio
        .get(
          '/map/kendaraandandp',
        )
        .catchError(
          _onError,
        );

    if (response == null) {
      return null;
    }

    return ListKendaraanDanDPReponse.fromJson(response.data);
  }

  Future<ListRangeBeratReponse> getRangeBerat() async {
    final response = await _dio
        .get(
          '/map/rangeberat',
        )
        .catchError(
          _onError,
        );

    if (response == null) {
      return null;
    }

    return ListRangeBeratReponse.fromJson(response.data);
  }

  Future<void> uploadFile(TrashiDocument file) async {
    FormData uploadFileData = FormData.fromMap({
      'upload': await MultipartFile.fromFile(file.file.path),
    });

    final response = await _dio.post(
      '/files/upload',
      data: uploadFileData,
      options: Options(
        headers: {
          'label': file.type.label,
        },
      ),
    );

    if (response == null) {
      return null;
    }
  }

  Future<Response<dynamic>> getKabupatens() async {
    final response = await _dio
        .get(
          '/map/kabupaten',
        )
        .catchError(
          _onError,
        );

    return response;
  }

  Future<Response<dynamic>> getKecamatans({int kabupatenID}) async {
    String path = '/map/kecamatan';

    if (kabupatenID != null) {
      path = path + '?kabupaten._id=$kabupatenID';
    }

    final response = await _dio
        .get(
          path,
        )
        .catchError(
          _onError,
        );

    return response;
  }

  Future<Response<dynamic>> getUPSTs({
    int kabupatenID,
    int kecamatanID,
  }) async {
    String path = '/map/upst';

    if (kabupatenID != null || kecamatanID != null) {
      path = path + '?';

      if (kabupatenID != null) {
        String filterKabupatenID = 'kabupaten._id=$kabupatenID';

        path = path + filterKabupatenID;
      }

      if (kecamatanID != null) {
        String filterKecamatanID = 'kecamatan._id=$kecamatanID';

        if (!path.endsWith('?')) {
          path = path + '&';
        }
        path = path + filterKecamatanID;
      }
    }

    final response = await _dio
        .get(
          path,
        )
        .catchError(
          _onError,
        );

    return response;
  }

  Future<Response<dynamic>> getPengangkatanListAdmin() async {
    final response = await _dio
        .get(
          '/pengangkatan/list/admin',
        )
        .catchError(
          _onError,
        );

    return response;
  }

  Future<Response<dynamic>> finishPengangkatan(
    FinishPengangkatanRequest body,
  ) async {
    final response = await _dio
        .post(
          '/pengangkatan/selesai',
          data: body,
        )
        .catchError(
          _onError,
        );

    return response;
  }

  Future<Response<dynamic>> getPengangkatanDetail(
    int id,
  ) async {
    final response = await _dio
        .get(
          '/pengangkatan/$id',
        )
        .catchError(
          _onError,
        );

    return response;
  }

  Future<Response<dynamic>> getHistoriPengangkatan() async {
    final response = await _dio
        .get(
          '/pengangkatan/histori',
        )
        .catchError(
          _onError,
        );

    return response;
  }

  Future<EditProfileResponse> editProfileApi(dynamic body) async {
    String path = '/users/info';
    final response =
        await _dio.put(path, data: jsonEncode(body)).catchError(_onError);
    final cookies = response.headers.map['set-cookie'];

    await _saveTokenFromCookies(cookies);
    print(response);
    return EditProfileResponse.fromJson(response.data);
  }
}

/**
 * SOURCE:
 * https://medium.com/@prolongservices.com/how-to-set-cookie-in-header-with-the-request-flutter-dea56efc71a6
 */