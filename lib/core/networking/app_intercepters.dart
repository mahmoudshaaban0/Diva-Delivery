import 'package:dio/dio.dart';
import 'package:limitless_code_template/core/constants/app_constants.dart';

class AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[AppConstants.accept] = AppConstants.applicationJson;
    options.headers[AppConstants.contentType] = AppConstants.applicationJson;
    super.onRequest(options, handler);
  }

  @override
  dynamic onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    super.onResponse(response, handler);
  }
}
