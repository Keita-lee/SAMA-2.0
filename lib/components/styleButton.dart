import 'dart:ui';

import 'package:flutter/material.dart';

class StyleButton extends StatefulWidget {
  String? description;
  double? height;
  double? width;
  double? fontSize;
  final Function()? onTap;
  Color? buttonColor;
  Color? buttonTextColor;
  StyleButton(
      {super.key,
      required this.description,
      this.buttonTextColor,
      required this.height,
      required this.width,
      required this.onTap,
      this.fontSize,
      this.buttonColor});

  @override
  State<StyleButton> createState() => _StyleButtonState();
}

class _StyleButtonState extends State<StyleButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap!();
      },
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            //elevation: 10,
            minimumSize:
                Size(widget.width!, widget.height!), // Size(width, height)
            backgroundColor: widget.buttonColor != null
                ? widget.buttonColor
                : Color.fromARGB(255, 8, 55, 145),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        child: Text(
          widget.description!,
          style: TextStyle(
            color: widget.buttonTextColor == null
                ? Color.fromARGB(255, 255, 255, 255)
                : widget.buttonTextColor,
            fontSize: widget.fontSize == null ? 16 : widget.fontSize,
          ),
        ),
        onPressed: widget.onTap,
      ),
    );
  }
}
