import 'package:flutter/material.dart';

class OnHoverButtons extends StatefulWidget {
  final double? height;
  final double? width;
  final String description;
  final Color hoverColor;
  final Color baseColor;
  final Function()? onTap;

  OnHoverButtons({
    super.key,
    this.height,
    this.width,
    required this.onTap,
    required this.baseColor,
    required this.hoverColor,
    required this.description,
  });

  @override
  State<OnHoverButtons> createState() => _OnHoverButtonsState();
}

class _OnHoverButtonsState extends State<OnHoverButtons> {
  bool isHoverd = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            isHoverd = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHoverd = false;
          });
        },
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(widget.width!, widget.height!),
            backgroundColor: isHoverd ? widget.hoverColor : widget.baseColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            widget.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          onPressed: widget.onTap,
        ),
      ),
    );
  }
}
