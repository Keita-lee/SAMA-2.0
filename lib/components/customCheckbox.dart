import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final double width;
  final double height;
  final ValueChanged<bool?> onChanged;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: value ? Colors.grey[300] : Colors.white,
          border: Border.all(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child:
            value ? Icon(Icons.check, size: 20.0, color: Colors.black) : null,
      ),
    );
  }
}
