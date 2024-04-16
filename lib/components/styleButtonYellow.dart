import 'package:flutter/material.dart';

class StylrButtonYellow extends StatefulWidget {
  String? description;
  double? height;
  double? width;
  final Function()? onTap;
  StylrButtonYellow(
      {super.key,
      required this.description,
      required this.height,
      required this.width,
      required this.onTap});

  @override
  State<StylrButtonYellow> createState() => _StylrButtonYellowState();
}

class _StylrButtonYellowState extends State<StylrButtonYellow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 254, 203, 54),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Center(
          child: Text(
            widget.description!,
            style: TextStyle(
              color: Color.fromARGB(255, 8, 55, 145),
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }
}
