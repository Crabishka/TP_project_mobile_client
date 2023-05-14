import 'package:dio/dio.dart';
import 'package:sportique/client_api/dio_interceptor.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient(){
    _dio.interceptors.add(DioInterceptor());
  }



  Dio get dio => _dio;
}
