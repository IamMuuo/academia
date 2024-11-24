import 'package:academia/database/database.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final UserCredentialData creds;
  final AppDatabase database;

  AuthInterceptor(
      {required this.dio, required this.creds, required this.database});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Add your API key & other stuff to the headers.
    options.headers.addAll({"Authorization": "Bearer ${creds.accessToken!}"});
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // [TODO] Add automatic token refreshing
    if (err.response?.statusCode == 401) {
      return handler
          .resolve(await dio.fetch(err.requestOptions)); // Repeat the request.
    }

    return handler.reject(DioException(
      requestOptions: err.requestOptions,
      error: err.response,
    ));
  }
}
