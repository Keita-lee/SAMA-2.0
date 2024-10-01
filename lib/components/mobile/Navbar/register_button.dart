import 'package:flutter/material.dart';
import 'package:sama/components/mobile/components/Themes/custom_colors.dart';
import 'package:sama/components/utility.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RegisterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.yellow,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        'REGISTER',
        style: TextStyle(
          color: Colors.black,
          fontSize: MyUtility(context).width < 400 ? 12 : 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
