
import 'package:flutter/material.dart';

class LongTextField extends StatefulWidget {
  final double textFieldWidth;
  final TextEditingController textEditingController;
  int? lines;

  LongTextField({
    super.key,
    required this.textFieldWidth,
    required this.textEditingController,
    this.lines,
  });

  @override
  State<LongTextField> createState() => _LongTextFieldState();
}

class _LongTextFieldState extends State<LongTextField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.textFieldWidth,
        //height: 45,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          border: Border.all(
            color: const Color.fromARGB(255, 51, 51, 51),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: TextFormField(
          maxLines: widget.lines == null ? 1 : widget.lines,
          controller: widget.textEditingController,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10, top: 10),
            border: InputBorder.none,
            hintStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
