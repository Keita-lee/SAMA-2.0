import 'package:flutter/material.dart';

class StyleButton extends StatefulWidget {
  String? description;
  double? height;
  double? width;
  final Function()? onTap;
  StyleButton(
      {super.key,
      required this.description,
      required this.height,
      required this.width,
      required this.onTap});

  @override
  State<StyleButton> createState() => _StyleButtonState();
}

class _StyleButtonState extends State<StyleButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 8, 55, 145),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Center(
          child: Text(
            widget.description!,
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 16,
              //  fontWeight: FontWeight.w900,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }
}
