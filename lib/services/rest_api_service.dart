import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../enums/endpoint.dart';
import '../enums/http_method.dart';
import '../enums/log_severity.dart';
import '../model/rest_error.dart';
import '../utils/error_message.dart';
import '../utils/log_util.dart';
import 'connectivity_service.dart';

class RestApiService {
  static final RestApiService _instance = RestApiService();

  bool _isConnected = false;

  static Future<RestApiService> getInstance() async {
    return _instance;
  }

  // Create storage
  final _dio = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 10), // 10 seconds
      receiveTimeout: const Duration(seconds: 40) // 40 seconds
      ));

  Future initialise(ConnectivityService connectivity) async {
    // Add the following line
    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ));

      _dio.interceptors.add(
        RetryInterceptor(
            dio: _dio,
            logPrint: debugPrint,
            // specify log function (optional)
            retries: 3,
            // retry count (optional)
            retryDelays: const [
              // set delays between retries (optional)
              Duration(seconds: 1), // wait 1 sec before first retry
              Duration(seconds: 5), // wait 5 sec before second retry
              Duration(seconds: 10), // wait 10 sec before third retry
            ],
            retryEvaluator: (DioError error, int attempt) {
              return error.type == DioErrorType.connectionTimeout;
            }),
      );
    }

    _isConnected = connectivity.isConnected();

    connectivity.listen((result) {
      _isConnected = result;
    });
  }

  Future<Response> makeRestCall(
      String baseUrl,
      Endpoint endpoint,
      HttpMethod method,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      Map<String, String>? headers,
      {CancelToken? cancelToken}) async {
    return _performCall(baseUrl, endpoint.value(), method, queryParameters,
        data, null, headers, cancelToken);
  }
  
  Future<Response> makeCustomCall(
      String baseUrl,
      String endpoint,
      HttpMethod method,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      Map<String, String>? headers,
      {CancelToken? cancelToken}) {
    return _performCall(baseUrl, endpoint, method, queryParameters, data, null,
        headers, cancelToken);
  }

  Future<Response> _performCall(
      String baseUrl,
      String endpoint,
      HttpMethod method,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      Map<String, dynamic>? formData,
      Map<String, String>? headers,
      CancelToken? cancelToken) async {
    if (!_isConnected) throw RestError(message: ErrorMessages.noInternet);

    try {
      Response response;
      var url = baseUrl + endpoint;
      switch (method) {
        case HttpMethod.Post:
          response = await _dio.post(url,
              data: data != null
                  ? jsonEncode(data)
                  : formData != null
                      ? FormData.fromMap(formData)
                      : null,
              options: Options(headers: headers),
              queryParameters: queryParameters,
              cancelToken: cancelToken);
          break;
        case HttpMethod.Get:
          response = await _dio.get(url,
              options: Options(headers: headers),
              queryParameters: queryParameters,
              cancelToken: cancelToken);
          break;
        case HttpMethod.Delete:
          response = await _dio.delete(url,
              options: Options(headers: headers),
              queryParameters: queryParameters,
              cancelToken: cancelToken);
          break;
        case HttpMethod.Patch:
          response = await _dio.patch(url,
              data: jsonEncode(data),
              options: Options(headers: headers),
              queryParameters: queryParameters,
              cancelToken: cancelToken);
          break;
      }

      return response;
    } on DioError catch (e) {
      var response = e.response;

      var errorString = e.message;

      if (response != null && response.data['error'] != null) {
        errorString = response.data['error'];
      } else if (response != null && response.data['message'] != null) {
        errorString = response.data['message'];
      }

      LogUtil.printLog(
          message: 'Error Occurred: ${e.toString()} ',
          methodName: '_makeRestCall',
          className: 'RestApiService',
          logSeverity: LogSeverity.Error);

      throw RestError(message: errorString!, statusCode: response?.statusCode);
    }
  }


  Future<Response> makeRestCallJSONString(
      String baseUrl,
      Endpoint endpoint,
      HttpMethod method,
      Map<String, dynamic>? queryParameters,
      String? data,
      Map<String, String>? headers,
      {CancelToken? cancelToken}) async {
    return _performCallJSONString(baseUrl, endpoint.value(), method, queryParameters,
        data, null, headers, cancelToken);
  }

  Future<Response> _performCallJSONString(
      String baseUrl,
      String endpoint,
      HttpMethod method,
      Map<String, dynamic>? queryParameters,
      String? data,
      Map<String, dynamic>? formData,
      Map<String, String>? headers,
      CancelToken? cancelToken) async {
    if (!_isConnected) throw RestError(message: ErrorMessages.noInternet);

    try {
      Response response;
      var url = baseUrl + endpoint;
      switch (method) {
        case HttpMethod.Post:
          response = await _dio.post(url,
              data: data != null
                  ? data
                  : formData != null
                  ? FormData.fromMap(formData)
                  : null,
              options: Options(headers: headers),
              queryParameters: queryParameters,
              cancelToken: cancelToken);
          break;
        case HttpMethod.Get:
          response = await _dio.get(url,
              options: Options(headers: headers),
              queryParameters: queryParameters,
              cancelToken: cancelToken);
          break;
        case HttpMethod.Delete:
          response = await _dio.delete(url,
              options: Options(headers: headers),
              queryParameters: queryParameters,
              cancelToken: cancelToken);
          break;
        case HttpMethod.Patch:
          response = await _dio.patch(url,
              data: jsonEncode(data),
              options: Options(headers: headers),
              queryParameters: queryParameters,
              cancelToken: cancelToken);
          break;
      }

      return response;
    } on DioError catch (e) {
      var response = e.response;

      var errorString = e.message;

      if (response != null && response.data['error'] != null) {
        errorString = response.data['error'];
      } else if (response != null && response.data['message'] != null) {
        errorString = response.data['message'];
      }

      LogUtil.printLog(
          message: 'Error Occurred: ${e.toString()} ',
          methodName: '_makeRestCall',
          className: 'RestApiService',
          logSeverity: LogSeverity.Error);

      throw RestError(message: errorString!, statusCode: response?.statusCode);
    }
  }
}
