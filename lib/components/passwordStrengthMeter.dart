import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

enum CustomPassStrength implements PasswordStrengthItem {
  weak,
  medium,
  strong;

  @override
  Color get statusColor {
    switch (this) {
      case CustomPassStrength.weak:
        return Colors.red;
      case CustomPassStrength.medium:
        return Colors.orange;
      case CustomPassStrength.strong:
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
      default:
        return 0.0;
    }
  }

  static CustomPassStrength? calculate({required String text}) {
    // Implement your custom logic here
    if (text.isEmpty) {
      return null;
    }
    if (text.length < 8) {
      return CustomPassStrength.weak;
    } else if (text.length < 10) {
      return CustomPassStrength.medium;
    } else {
      return CustomPassStrength.strong;
    }
  }
}
