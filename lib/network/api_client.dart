import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:http/http.dart' as http;
import '/services/app_exceptions.dart';

class ApiClient {
  final int timeoutSeconds = 10;

  /// POST request without authentication (login)
  Future<dynamic> postLogin(String url, Map<String, dynamic> data) async {
    if (kDebugMode) {
      print("POST LOGIN URL: $url");
      print("DATA: $data");
    }

    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: timeoutSeconds));

      return _handleResponse(response);
    } on SocketException {
      throw InternetException("internet_error".tr);
    } on HttpException {
      throw FetchDataException("couldnot_find_the_resource".tr);
    } on FormatException {
      throw FetchDataException("bad_response_format".tr);
    } on RequestTimeOut {
      throw RequestTimeOut("request_timed_out".tr);
    }
  }

  /// POST request with authentication token
  Future<dynamic> post(
    String url,
    Map<String, dynamic> data,
    String token,
  ) async {
    if (kDebugMode) {
      print("POST URL: $url");
      print("DATA: $data");
      print("Token: $token");
    }

    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Token $token',
            },
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: timeoutSeconds));

      return _handleResponse(response);
    } on SocketException {
      throw InternetException("internet_error".tr);
    } on RequestTimeOut {
      throw RequestTimeOut("request_timed_out".tr);
    }
  }

  /// GET request with authentication token
  Future<dynamic> get(String url, String token) async {
    if (kDebugMode) {
      print("GET URL: $url");
    }

    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Token $token',
            },
          )
          .timeout(Duration(seconds: timeoutSeconds));

      return _handleResponse(response);
    } on SocketException {
      throw InternetException("internet_error".tr);
    } on RequestTimeOut {
      throw RequestTimeOut("request_timed_out".tr);
    }
  }

  /// PUT request with authentication token
  Future<dynamic> put(
    String url,
    Map<String, dynamic> data,
    String token,
  ) async {
    if (kDebugMode) {
      print("PUT URL: $url");
      print("DATA: $data");
    }

    try {
      final response = await http
          .put(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Token $token',
            },
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: timeoutSeconds));

      return _handleResponse(response);
    } on SocketException {
      throw InternetException("internet_error".tr);
    } on RequestTimeOut {
      throw RequestTimeOut("request_timed_out".tr);
    }
  }

  /// DELETE request with authentication token
  Future<dynamic> delete(String url, String token) async {
    if (kDebugMode) {
      print("DELETE URL: $url");
    }

    try {
      final response = await http
          .delete(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Token $token',
            },
          )
          .timeout(Duration(seconds: timeoutSeconds));

      return _handleResponse(response);
    } on SocketException {
      throw InternetException("internet_error".tr);
    } on RequestTimeOut {
      throw RequestTimeOut("request_timed_out".tr);
    }
  }

  /// Handle HTTP responses
  dynamic _handleResponse(http.Response response) {
    if (kDebugMode) {
      print("RESPONSE CODE: ${response.statusCode}");
      print("RESPONSE BODY: ${response.body}");
    }

    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body.isEmpty ? '{}' : response.body);
      case 201:
        return jsonDecode(response.body.isEmpty ? '{}' : response.body);
      case 204:
        return jsonDecode(response.body.isEmpty ? '{}' : response.body);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw NotFoundException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
          "${'error_occurred_while_communicating_with_server'.tr}: ${response.statusCode}",
        );
    }
  }
}
