import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:ishara/core/errors/exceptions.dart';
import 'package:ishara/core/services/local_session_service.dart';
import 'package:ishara/features/auth/data/models/user_model.dart';

/// تسجيل وتسجيل دخول محلي (SharedPreferences) — بدون Firebase.
///
/// كلمات المرور مخزنة كنص عادي للتجربة فقط؛ لا تستخدم ذلك في إنتاج حقيقي.
class LocalAuthService {
  static const _kUsersJson = 'local_registered_users_json';

  Future<List<Map<String, dynamic>>> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kUsersJson);
    if (raw == null || raw.isEmpty) return [];
    final decoded = jsonDecode(raw);
    if (decoded is! List) return [];
    return decoded.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  Future<void> _saveUsers(List<Map<String, dynamic>> users) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kUsersJson, jsonEncode(users));
  }

  Future<UserModel> signUpWithNameEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    final users = await _loadUsers();
    final normalizedEmail = email.trim().toLowerCase();
    if (users.any(
        (u) => (u['email'] as String).toLowerCase() == normalizedEmail)) {
      throw CustomException(message: 'This email is already registered');
    }
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    users.add({
      'id': id,
      'name': name.trim(),
      'email': email.trim(),
      'password': password,
    });
    await _saveUsers(users);
    final model = UserModel(id: id, name: name.trim(), email: email.trim());
    await LocalSessionService.instance.saveSession(
      LocalUserSession(
        id: model.id,
        name: model.name,
        email: model.email,
      ),
    );
    return model;
  }

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final users = await _loadUsers();
    final normalizedEmail = email.trim().toLowerCase();
    Map<String, dynamic>? match;
    for (final u in users) {
      if ((u['email'] as String).toLowerCase() == normalizedEmail &&
          u['password'] == password) {
        match = u;
        break;
      }
    }
    if (match == null) {
      throw CustomException(message: 'Invalid email or password');
    }
    final model = UserModel(
      id: match['id'] as String,
      name: match['name'] as String? ?? '',
      email: match['email'] as String? ?? email.trim(),
    );
    await LocalSessionService.instance.saveSession(
      LocalUserSession(
        id: model.id,
        name: model.name,
        email: model.email,
      ),
    );
    return model;
  }

  Future<void> signOut() async {
    await LocalSessionService.instance.clearSession();
  }
}
