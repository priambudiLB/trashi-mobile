import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trashi/constants/strings.dart';
import 'package:trashi/utils/strings.dart';
import 'package:trashi/utils/network_exception.dart';
import 'package:trashi/utils/network_model.dart';
import 'package:trashi/utils/cookies.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

// Utility class to communicate with backend API.
// Includes request type POST, GET, PATCH
// @author Izzan
class NetworkUtils {
  static final log = Logger();

  // POST request
  Future<NetworkModel> post(
      {@required String path,
      @required dynamic bodyParams,
      @required bool isLogin,
      bool isSignUp = false}) async {
    try {
      Map<String, String> requestHeaderJson =
          await buildRequestHeader(isLogin, isSignUp);
      NetworkModel responseModel;

      responseModel = await http
          .post(Uri.parse("$API_BASE_URL$path"),
              body: json.encode(bodyParams), headers: requestHeaderJson)
          .then((response) async {
        log.i("POST request called!\n"
            "URL: $API_BASE_URL$path\n"
            "response: ${response.body.toString()}\n"
            "response headers: ${response.headers}");
        if (response.statusCode >= 400) {
          throw new NetworkException(
            errorMessage: "There was an API Error",
            errorStatusCode: response.statusCode,
            response: json.decode(response.body),
          );
        } else {
          dynamic responseBody = json.decode(response.body);
          if (!isLogin) {
            if (isSignUp) {
              if (responseBody.containsKey("key")) {
                setAccessToken(responseBody["key"]);
                CookiesUtils.createCookiesFile(response.headers);
              }
            } else {
              setAccessToken(responseBody["key"]);
              await CookiesUtils.createCookiesFile(response.headers);
            }
          }

          return NetworkModel(
              statusCode: response.statusCode, response: responseBody);
        }
      });

      return responseModel;
    } on Exception catch (e) {
      log.e(
          "POST request failed! path: $API_BASE_URL$path, body params: ${bodyParams.toString()}");
      throw new NetworkException(
          errorMessage: e.toString(),
          errorStatusCode: HttpStatus.internalServerError,
          response: {"message": e.toString()});
    }
  }

  // GET request
  Future<NetworkModel> get(
      {@required String path,
      @required bool isLogin,
      bool isSignUp = false}) async {
    try {
      Map<String, dynamic> requestHeaderJson =
          await buildRequestHeader(isLogin, isSignUp);
      NetworkModel responseModel;
      responseModel = await http
          .get(
        Uri.parse("$API_BASE_URL$path"),
        headers: requestHeaderJson,
      )
          .then((response) async {
        dynamic responseBody = json.decode(response.body);
        if (response.statusCode >= 400) {
          throw new NetworkException(
              errorMessage: "There was an API error.",
              errorStatusCode: response.statusCode,
              response: responseBody);
        } else {
          return NetworkModel(
              statusCode: response.statusCode, response: response.body);
        }
      });

      return responseModel;
    } on Exception catch (e) {
      log.e("GET request failed! path: $API_BASE_URL$path");
      throw new NetworkException(
          errorMessage: e.toString(),
          errorStatusCode: HttpStatus.internalServerError,
          response: {"message": e.toString()});
    }
  }

  // PATCH request
  Future<NetworkModel> patch({
    @required String path,
    @required dynamic bodyParams,
    @required bool isLogin,
    bool isSignUp = false,
  }) async {
    try {
      Map<String, dynamic> requestHeaderJson =
          await buildRequestHeader(isLogin, isSignUp);
      NetworkModel responseModel;

      responseModel = await http
          .patch(Uri.parse("$API_BASE_URL$path"),
              body: json.decode(bodyParams), headers: requestHeaderJson)
          .then((response) async {
        if (response.statusCode >= 400) {
          throw new NetworkException(
            errorMessage: "There was an API error.",
            errorStatusCode: response.statusCode,
            response: json.decode(response.body),
          );
        } else {
          return NetworkModel(
            statusCode: response.statusCode,
            response: json.decode(response.body),
          );
        }
      });

      return responseModel;
    } on Exception catch (e) {
      log.e("PATCH request failed! path: $API_BASE_URL$path");
      throw new NetworkException(
          errorMessage: e.toString(),
          errorStatusCode: HttpStatus.internalServerError,
          response: {"message": e.toString()});
    }
  }

  Future<Map<String, dynamic>> buildRequestHeader(
      bool isLogin, bool isSignUp) async {
    Map<String, String> headers = Map<String, String>();
    headers.putIfAbsent("Content-Type", () => "application/json");

    if (isLogin) {
      List<dynamic> cookiesFile = await CookiesUtils.getCookiesFile();
      setAccessToken(cookiesFile[2]);
      headers.putIfAbsent("Authorization", () => "Token $ACCESS_TOKEN");
      headers.putIfAbsent("X-CSRFToken", () => cookiesFile[0]);
      headers.putIfAbsent("Cookie",
          () => "csrftoken=${cookiesFile[0]}; sessionid=${cookiesFile[1]}");
    } else {
      if (TEMP_ACCESS_TOKEN.isNotEmpty &&
          TEMP_CSRF_TOKEN.isNotEmpty &&
          TEMP_SESSION_ID.isNotEmpty) {
        headers.putIfAbsent("Authorization", () => "Token $TEMP_ACCESS_TOKEN");
        headers.putIfAbsent("X-CSRFToken", () => TEMP_CSRF_TOKEN);
        headers.putIfAbsent("Cookie",
            () => "csrftoken=$TEMP_CSRF_TOKEN; sessionid=$TEMP_SESSION_ID");
      }
    }

    return headers;
  }
}
