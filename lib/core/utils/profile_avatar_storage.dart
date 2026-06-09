import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// نسخ صورة البروفايل لمجلد دائم — مسار الـ ImagePicker مؤقت وبيختفي بعد إغلاق التطبيق.
class ProfileAvatarStorage {
  ProfileAvatarStorage._();

  static const _fileName = 'profile_avatar.jpg';

  static Future<String> persistPickedImage(String sourcePath) async {
    final source = File(sourcePath);
    if (!await source.exists()) {
      throw Exception('Image file not found');
    }
    final dir = await getApplicationDocumentsDirectory();
    final destPath = '${dir.path}/$_fileName';
    await File(destPath).writeAsBytes(await source.readAsBytes(), flush: true);
    return destPath;
  }

  static Future<bool> fileExists(String? path) async {
    if (path == null || path.isEmpty) return false;
    return File(path).exists();
  }
}
