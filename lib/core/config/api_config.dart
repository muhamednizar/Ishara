/// عنوان الـ API — يتغيّر عند التشغيل أو البناء بدون تعديل الكود.
///
/// محلي (نفس الـ Wi‑Fi):
/// `flutter run --dart-define=API_BASE_URL=http://192.168.1.104:8000/api/`
///
/// لزملاء على شبكات مختلفة (ngrok بعد `ngrok http 8000`):
/// `flutter run --dart-define=API_BASE_URL=https://xxxx.ngrok-free.app/api/`
///
/// `flutter build apk --dart-define=API_BASE_URL=https://xxxx.ngrok-free.app/api/`
class ApiConfig {
  ApiConfig._();

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://192.168.1.104:8000/api/',
  );

  static bool get usesNgrok => baseUrl.contains('ngrok');

  static Map<String, String> get extraHeaders {
    if (!usesNgrok) return {};
    return {'ngrok-skip-browser-warning': 'true'};
  }
}
