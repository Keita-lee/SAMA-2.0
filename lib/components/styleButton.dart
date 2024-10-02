import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sama/components/mobile/components/Themes/font_text.dart';

class StyleButton extends StatefulWidget {
  String? description;
  double? height;
  double? width;
  double? fontSize;
  final Function()? onTap;
  Color? buttonColor;
  Color? buttonTextColor;
  bool? waiting;
  StyleButton(
      {super.key,
      required this.description,
      this.buttonTextColor,
      required this.height, // Adjust this value
      required this.width, // Adjust this value
      required this.onTap,
      this.fontSize,
      this.buttonColor,
      this.waiting});

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
                Size(widget.width! * 0.8, widget.height! * 0.8), // Reduced size
            backgroundColor: widget.buttonColor != null
                ? widget.buttonColor
                : Color.fromARGB(255, 8, 55, 145),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        child: widget.waiting != null && widget.waiting == true
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: Colors.white,
                ),
              )
            : Text(widget.description!, style: FontText(context).regularWhite),
        onPressed: widget.onTap,
      ),
    );
  }
}
