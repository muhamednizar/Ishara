import 'package:flutter/material.dart';

abstract class TextStyles {
  static const TextStyle regular16 = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 16,
  );
  static const TextStyle regular24 = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 24,
  );
  static const TextStyle medium16 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static const TextStyle medium24 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 24,
  );
  static const TextStyle semiBold16 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static const TextStyle semiBold24 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );
  static const TextStyle bold16 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  static const TextStyle bold24 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );
}
