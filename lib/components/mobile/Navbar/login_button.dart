import 'package:flutter/material.dart';
import 'package:sama/components/mobile/components/Themes/custom_colors.dart';
import 'package:sama/components/utility.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        'LOGIN',
        style: TextStyle(
          color: Colors.white,
          fontSize: MyUtility(context).width < 400 ? 12 : 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
