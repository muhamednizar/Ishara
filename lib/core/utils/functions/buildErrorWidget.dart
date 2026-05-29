import 'package:flutter/material.dart';

/// عرض خطأ للمستخدم (اسم الملف مثل bookly: `buildErrorWidget.dart`).
void buildErrorBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));
}
