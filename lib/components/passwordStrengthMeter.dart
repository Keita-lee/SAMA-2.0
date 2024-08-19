import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import 'package:zxcvbn/zxcvbn.dart';

enum CustomPassStrength implements PasswordStrengthItem {
  weak,
  medium,
  strong,
  veryStrong;

  @override
  Color get statusColor {
    switch (this) {
      case CustomPassStrength.weak:
        return Colors.red;
      case CustomPassStrength.medium:
        return Colors.orange;
      case CustomPassStrength.strong:
        return Colors.lightGreen;
      case CustomPassStrength.veryStrong:
        return Colors.green;
    }
  }

  @override
  Widget? get statusWidget {
    switch (this) {
      case CustomPassStrength.weak:
        return const Text('Weak');
      case CustomPassStrength.medium:
        return const Text('Medium');
      case CustomPassStrength.strong:
        return const Text('Strong');
      case CustomPassStrength.veryStrong:
        return const Text('Very Strong');
      default:
        return null;
    }
  }

  @override
  double get widthPerc {
    switch (this) {
      case CustomPassStrength.weak:
        return 0.15;
      case CustomPassStrength.medium:
        return 0.4;
      case CustomPassStrength.strong:
        return 0.75;
      case CustomPassStrength.veryStrong:
        return 1.0;
      default:
        return 0.0;
    }
  }

  static CustomPassStrength? calculate({required String text}) {
    if (text.isEmpty) {
      return null;
    }

    // Enforce at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(text)) {
      return CustomPassStrength.weak;
    }

    // Enforce at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(text)) {
      return CustomPassStrength.weak;
    }

    // Enforce at least one special character
    if (!RegExp(r'[!@#\$&*~]').hasMatch(text)) {
      return CustomPassStrength.weak;
    }

    // password strength using zxcvbn
    final zxcvbn = Zxcvbn();
    final result = zxcvbn.evaluate(text);

    switch (result.score) {
      case 0:
      case 1:
        return CustomPassStrength.weak;
      case 2:
        return CustomPassStrength.medium;
      case 3:
        return CustomPassStrength.strong;
      case 4:
        return CustomPassStrength.veryStrong;
      default:
        return CustomPassStrength.weak;
    }
  }
}
