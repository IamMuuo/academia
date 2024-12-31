import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import './auth_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  // static const String _baseUrl = "http://192.168.43.218:8000/v2";
  static const String _baseUrl = "http://192.168.43.218:8000";

  DioClient() {
    dio.interceptors.add(
      PrettyDioLogger(
        error: true,
        responseBody: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        maxWidth: 90,
        compact: true,
        enabled: kDebugMode,
      ),
    );

    _addAuthInterceptor();
  }

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      preserveHeaderCase: true,
      receiveDataWhenStatusError: true,
    ),
  );

  void _addAuthInterceptor() {
    dio.interceptors.add(
      AuthInterceptor(
        dio: dio,
      ),
    );
  }

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }
}
