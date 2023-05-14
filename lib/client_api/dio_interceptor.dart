import 'package:dio/dio.dart';
import 'package:sportique/client_api/token_hepler.dart';

class DioInterceptor extends Interceptor {
  TokenHelper tokenHelper = TokenHelper();
  String? token;

  void getToken() async {
    token = await tokenHelper.getUserToken();
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    getToken();
    if (token != null && token!.isNotEmpty) {
      options.headers['Authorization'] = token;
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }
}
