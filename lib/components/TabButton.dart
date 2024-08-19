import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final Color? activeColor;
  final Color? inactiveColor;

  const TabButton({
    Key? key,
    required this.title,
    required this.isActive,
    required this.onTap,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color1 = activeColor ?? Color.fromARGB(255, 23, 68, 134);
    final color2 = inactiveColor ?? Color.fromARGB(255, 200, 200, 200);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 40.0),
        decoration: BoxDecoration(
          color: isActive ? color1 : color2, // Active/Inactive color
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white, // Active/Inactive text color
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
