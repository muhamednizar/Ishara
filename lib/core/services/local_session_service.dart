import 'dart:async';

import 'package:ishara/core/utils/profile_avatar_storage.dart';
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

  /// تخصيصات البروفايل لكل مستخدم — تفضل بعد Sign out.
  static String _profileNameKey(String userId) => 'profile_custom_name_$userId';
  static String _profilePhotoKey(String userId) => 'profile_custom_photo_$userId';

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
    return _mergeWithSavedProfile(
      LocalUserSession(
        id: id,
        name: prefs.getString(_kName) ?? '',
        email: prefs.getString(_kEmail) ?? '',
        photoPath: prefs.getString(_kPhotoPath),
      ),
    );
  }

  Future<LocalUserSession> _mergeWithSavedProfile(LocalUserSession session) async {
    final prefs = await SharedPreferences.getInstance();
    final customName = prefs.getString(_profileNameKey(session.id));
    final customPhoto = prefs.getString(_profilePhotoKey(session.id));

    var name = session.name;
    if (customName != null && customName.isNotEmpty) {
      name = customName;
    }

    String? photoPath = session.photoPath;
    if (customPhoto != null &&
        customPhoto.isNotEmpty &&
        await ProfileAvatarStorage.fileExists(customPhoto)) {
      photoPath = customPhoto;
    }

    return LocalUserSession(
      id: session.id,
      name: name,
      email: session.email,
      photoPath: photoPath,
    );
  }

  Future<void> _persistProfileCustomization(
    String userId, {
    String? name,
    String? photoPath,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    if (name != null) {
      await prefs.setString(_profileNameKey(userId), name);
    }
    if (photoPath != null) {
      await prefs.setString(_profilePhotoKey(userId), photoPath);
    }
  }

  Future<void> saveSession(LocalUserSession session) async {
    final merged = await _mergeWithSavedProfile(session);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kId, merged.id);
    await prefs.setString(_kName, merged.name);
    await prefs.setString(_kEmail, merged.email);
    if (merged.photoPath != null && merged.photoPath!.isNotEmpty) {
      await prefs.setString(_kPhotoPath, merged.photoPath!);
    } else {
      await prefs.remove(_kPhotoPath);
    }
    await _notifyAuthChanged();
  }

  Future<void> updateDisplayName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kName, name);
    final id = prefs.getString(_kId);
    if (id != null && id.isNotEmpty) {
      await _persistProfileCustomization(id, name: name);
    }
    await _notifyAuthChanged();
  }

  Future<void> updatePhotoPath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kPhotoPath, path);
    final id = prefs.getString(_kId);
    if (id != null && id.isNotEmpty) {
      await _persistProfileCustomization(id, photoPath: path);
    }
    await _notifyAuthChanged();
  }

  /// تسجيل خروج — يمسح الجلسة النشطة فقط، مش تعديلات البروفايل المحفوظة.
  Future<void> signOut() async {
    await clearSession();
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kId);
    await prefs.remove(_kName);
    await prefs.remove(_kEmail);
    await prefs.remove(_kPhotoPath);
    await _notifyAuthChanged();
  }

  static const _kRememberMe = 'local_session_remember_me';

  Future<void> setRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kRememberMe, value);
  }

  Future<bool> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kRememberMe) ?? false;
  }

  static const _kIsFirstTime = 'is_first_time';

  Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kIsFirstTime) ?? true;
  }

  Future<void> setFirstTimeDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kIsFirstTime, false);
  }

  Future<bool> shouldRemember() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kRememberMe) ?? false;
  }
}
