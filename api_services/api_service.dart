import 'package:aagyo_vendor/helper/helper_widget.dart';
import 'package:aagyo_vendor/const/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static final Dio _dio = Dio();

  static void init() {
    // Initialize common configurations such as base URL, headers, etc.
    _dio.options.baseUrl = baseUrl;
    // _dio.options.connectTimeout = const Duration(seconds: 15);
    // _dio.options.receiveTimeout = const Duration(seconds: 15);

    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Do something before request is sent
          // For example, add headers
          options.headers.addAll({'Authorization': 'Bearer your_access_token'});
          return handler.next(options); // continue
        },
        onResponse: (response, handler) {
          // Do something with the response data
          return handler.next(response); // continue
        },
        onError: (e, handler) {
          // Do something with the error
          if (e.response != null) {
            // The request was made and the server responded with a status code
            // that falls out of the range of 2xx.

            if (e.response?.data["message"] is List) {
              showInToast(msg: "${e.response?.data["message"][0]}");
            } else {
              showInToast(msg: "${e.response?.data["message"]}");
            }
            debugPrint('Error status: ${e.response!.statusCode}');
            debugPrint('Error message: ${e.response!.statusMessage}');
            debugPrint('Error data: ${e.response!.data}');
          } else {
            // Something happened in setting up or sending the request that triggered an Error
            debugPrint('Dio Error: $e');
            if(InternetStatus.connected==true) {
              showInToast(msg: " connection time out");
            }else{
              showInToast(msg: "check your internet connection");
            }
          }
          return handler.next(e); // continue
        },
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestBody: true,
      ));
    }
  }

  static Future<Response> getData(String path,
      {Map<String, dynamic>? queryParameters, dynamic data}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        data: data,
      );
      return response;
    } catch (e) {
      // Handle error gracefully
      throw 'Failed to fetch data: $e';
    }
  }

  static Future<Response> postData(
      {required url, dynamic data, options}) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        options: options,
      );

      return response;
    } catch (e) {
      throw 'Failed to post data: $e';
    }
  }

// Add other methods for different HTTP methods as needed
}
