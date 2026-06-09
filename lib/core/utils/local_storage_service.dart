import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageService {
  final FlutterSecureStorage _storage;

  LocalStorageService(this._storage);

  // حفظ التوكن
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  // جلب التوكن
  Future<String?> getToken() async {
    return await _storage.read(key: 'access_token');
  }

  // مسح التوكن (عند تسجيل الخروج)
  Future<void> deleteToken() async {
    await _storage.delete(key: 'access_token');
  }

  // حفظ وضع المظهر (Dark/Light Mode)
  Future<void> saveThemeMode(bool isDarkMode) async {
    await _storage.write(key: 'theme_mode', value: isDarkMode.toString());
  }

  // جلب وضع المظهر
  Future<bool?> getThemeMode() async {
    final value = await _storage.read(key: 'theme_mode');
    return value != null ? value == 'true' : null;
  }

  // مسح وضع المظهر
  Future<void> deleteThemeMode() async {
    await _storage.delete(key: 'theme_mode');
  }
}