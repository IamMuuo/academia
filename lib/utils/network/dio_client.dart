import 'package:academia/database/database.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import './auth_interceptor.dart';

class DioClient {
  final UserCredentialData creds;
  final AppDatabase database;
  static const String _baseUrl = "http://192.168.2.115:8000/v2";
  // static const String _baseUrl = "http://192.168.26.183:8000/v2";

  DioClient({
    required this.creds,
    required this.database,
  }) {
    dio.interceptors.add(LogInterceptor(
      error: true,
      responseBody: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
      logPrint: (o) => debugPrint(o.toString()),
    ));
  }

  final Dio dio = Dio(
    BaseOptions(baseUrl: _baseUrl),
  );

  void addAuthInterceptor() {
    dio.interceptors.add(
      AuthInterceptor(
        dio: dio,
        creds: creds,
        database: database,
      ),
    );
  }

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }
}
