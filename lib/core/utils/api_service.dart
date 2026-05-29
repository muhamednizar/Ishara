import 'package:dio/dio.dart';
import 'package:ishara/core/config/api_config.dart';
import 'package:ishara/core/utils/auth_interceptor.dart';
import 'package:ishara/core/utils/local_storage_service.dart';

class ApiService {
  final Dio _dio;
  final String baseUrl = ApiConfig.baseUrl;

  ApiService(this._dio, LocalStorageService localStorageService) {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers.addAll(ApiConfig.extraHeaders);
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.interceptors.add(AuthInterceptor(localStorageService));
  }

  // دالة يوتيوب (تستخدم Dio جديد تماماً لتجنب الـ 401)
  Future<dynamic> getCustomUrl(String fullUrl) async {
    try {
      var response = await Dio().get(fullUrl); 
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> get({required String endpoint}) async {
    try {
      var response = await _dio.get(endpoint);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post({required String endpoint, required Map<String, dynamic> data, bool returnErrorData = false}) async {
    try {
      var response = await _dio.post(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      if (e.response != null && returnErrorData) {
        return {
          '_isError': true,
          '_statusCode': e.response!.statusCode,
          'data': e.response!.data,
        };
      }
      if (e.response != null) rethrow;
      rethrow;
    }
  }

  Future<dynamic> postForm({required String endpoint, required FormData data}) async {
    try {
      var response = await _dio.post(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) return e.response!.data;
      rethrow;
    }
  }
}