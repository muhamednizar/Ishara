import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

/// بيانات المستخدم المحلي (بدون Firebase).
class LocalUserSession {
  const LocalUserSession({
    required this.id,
    required this.name,
    required this.email,
    this.photoPath,
  });

  final String id;
  final String name;
  final String email;
  final String? photoPath;
}

/// جلسة محلية + بث حالة تسجيل الدخول (بديل عن `authStateChanges`).
class LocalSessionService {
  LocalSessionService._();
  static final LocalSessionService instance = LocalSessionService._();

  static const _kId = 'local_session_user_id';
  static const _kName = 'local_session_user_name';
  static const _kEmail = 'local_session_user_email';
  static const _kPhotoPath = 'local_session_user_photo_path';

  final StreamController<bool> _authController =
      StreamController<bool>.broadcast();

  Stream<bool> authStateChanges() async* {
    yield await isLoggedIn();
    yield* _authController.stream;
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(_kId);
    return id != null && id.isNotEmpty;
  }

  Future<void> _notifyAuthChanged() async {
    if (!_authController.isClosed) {
      _authController.add(await isLoggedIn());
    }
  }

  Future<LocalUserSession?> readSession() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(_kId);
    if (id == null || id.isEmpty) return null;
    return LocalUserSession(
      id: id,
      name: prefs.getString(_kName) ?? '',
      email: prefs.getString(_kEmail) ?? '',
      photoPath: prefs.getString(_kPhotoPath),
    );
  }

  Future<void> saveSession(LocalUserSession session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kId, session.id);
    await prefs.setString(_kName, session.name);
    await prefs.setString(_kEmail, session.email);
    if (session.photoPath != null) {
      await prefs.setString(_kPhotoPath, session.photoPath!);
    }
    await _notifyAuthChanged();
  }

  Future<void> updateDisplayName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kName, name);
    await _notifyAuthChanged();
  }

  Future<void> updatePhotoPath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kPhotoPath, path);
    await _notifyAuthChanged();
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kId);
    await prefs.remove(_kName);
    await prefs.remove(_kEmail);
    await prefs.remove(_kPhotoPath);
    await _notifyAuthChanged();
  }
}
