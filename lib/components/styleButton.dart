import 'dart:ui';

import 'package:flutter/material.dart';

class StyleButton extends StatefulWidget {
  String? description;
  double? height;
  double? width;
  final Function()? onTap;
  Color? buttonColor;
  StyleButton(
      {super.key,
      required this.description,
      required this.height,
      required this.width,
      required this.onTap,
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
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 16,
          ),
        ),
        onPressed: widget.onTap,
      ),
    );
  }
}
