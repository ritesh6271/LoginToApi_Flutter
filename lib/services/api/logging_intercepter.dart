
import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method == 'POST')
      print(
          'REQUEST[${options.method}] => PATH: ${options.baseUrl}${options.path} => DATA: ${options.data.toString()} => HEADER: ${options.headers}');
    else
      print(
          'REQUEST[${options.method}] => PATH: ${options.baseUrl}${options.path} => QUERY: ${options.queryParameters}  => HEADER: ${options.headers}');

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path} => DATA: ${response.data}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}=> DATA: ${err.error}',
    );
    return super.onError(err, handler);
  }
}