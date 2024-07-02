import 'package:flutter/material.dart';

class MyProductButtons extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color borderColor;
  final Function()? onTap;
  final Color textColor;

  MyProductButtons(
      {super.key,
      required this.buttonText,
      required this.buttonColor,
      required this.borderColor,
      this.onTap,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: buttonColor,
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
            child: Text(
              buttonText,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  letterSpacing: 1.1),
            ),
          ),
        ),
      ),
    );
  }
}
