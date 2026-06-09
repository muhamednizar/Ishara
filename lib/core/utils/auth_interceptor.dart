import 'package:dio/dio.dart';
import 'local_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final LocalStorageService _storageService;

  AuthInterceptor(this._storageService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // بنجيب التوكن من المخزن
    final token = await _storageService.getToken();

    // لو التوكن موجود، بنحطه في الهيدر بتاع الطلب
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options); // كمل الطلب عادي
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // لو السيرفر رد بـ 401 (التوكن انتهى)، ممكن تعمل Logout هنا أوتوماتيك
    if (err.response?.statusCode == 401) {
      // TODO: مكن تنفذ Logout logic هنا
    }
    return handler.next(err);
  }
}