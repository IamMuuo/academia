import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor({required this.dio}) {
    GetIt.instance.registerSingletonIfAbsent<String>(() => "",
        instanceName: "accessToken");
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Add your API key & other stuff to the headers.
    final token = GetIt.instance.get<String>(instanceName: "accessToken");
    options.headers.addAll(
      {"Authorization": "Bearer $token"},
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.headers.value("Authorization") != null) {
      GetIt.instance.unregister<String>(instanceName: "accessToken");
      GetIt.instance.registerSingleton<String>(
        response.headers.value("Authorization")!.split(" ").last,
        instanceName: "accessToken",
      );
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // TODO: erick Add automatic token refreshing and code retrial
    // if (err.response?.statusCode == 401) {
    //   print("Some really bad error");
    //   
    //   return handler
    //       .resolve(await dio.fetch(err.requestOptions)); // Repeat the request.
    // }

    return handler.reject(DioException(
      requestOptions: err.requestOptions,
      error: err.response,
    ));
  }
}
