// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:uep/services/local_db/local_db.dart';

class DioClient {
  final _dio = Dio();

  DioClient._private() {
    _dio.options
      ..connectTimeout = const Duration(milliseconds: 50)
      ..receiveTimeout = const Duration(seconds: 30)
      ..baseUrl = "http://millima.flutterwithakmaljon.uz";

    _dio.interceptors.add(DioInterceptor());
  }

  static final _singletonConstructor = DioClient._private();

  factory DioClient() {
    return _singletonConstructor;
  }

  Dio get dio => _dio;
}

class DioInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);

    print(response);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await LocalDb.getIdToken();

    options.headers = {
      "Authorization": "Bearer $token",
    };

    print(options.method);

    options.connectTimeout = const Duration(seconds: 5);

    super.onRequest(options, handler);

    print(options.connectTimeout);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);

    print(err);
  }
}
