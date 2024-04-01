import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class GreyButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const GreyButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: MyUtility(context).height * 0.035,
          color: Colors.grey.shade300,
          padding: EdgeInsets.only(left: 8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            buttonText,
            style: TextStyle(
                color: Colors.grey.shade600,
                letterSpacing: -0.05,
                fontWeight: FontWeight.bold,
                fontSize: 12.5),
          ),
        ),
      ),
    );
  }
}
