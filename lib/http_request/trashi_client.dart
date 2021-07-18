import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:trashi/http_request/models/auth.dart';

part 'trashi_client.g.dart';

@RestApi(baseUrl: 'http://10.0.2.2:8000/api')
abstract class TrashiClient {
  factory TrashiClient(Dio dio, {String baseUrl}) = _TrashiClient;

  @POST('/auth/signin')
  Future<SignInResponse> signIn(
    @Body() SignInRequest body,
  );

  @POST('/auth/signin/byphone')
  Future<SignInByPhoneResponse> signInByPhone(
    @Body() SignInByPhoneRequest body,
  );

  @GET('/auth/currentUser')
  Future<CurrentUserResponse> getCurrentUser();

  @POST('/auth/signout')
  Future<void> signOut();

  @POST('/auth/signup')
  Future<SignInResponse> signUp(
    @Body() SignUpRequest body,
  );

  @POST('/auth/signup/byphone')
  Future<SignInByPhoneResponse> signUpByPhone(
    @Body() SignUpByPhoneRequest body,
  );

  @POST('/token/refresh')
  Future<GenerateVerificationCodeResponse> generateVerificationCode(
    @Body() GenerateVerificationCodeRequest body,
  );
}
