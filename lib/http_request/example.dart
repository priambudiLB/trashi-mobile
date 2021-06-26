import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:trashi/http_request/task.dart';

part 'example.g.dart';

@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("/tasks")
  Future<List<Task>> getTasks();
}
