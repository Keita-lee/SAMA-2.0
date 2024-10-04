import 'package:flutter/material.dart';
import 'package:sama/components/mobile/components/Themes/font_text.dart';
import 'package:sama/components/utility.dart';

class MyProductTextField extends StatefulWidget {
  final double textFieldWidth;
  String hintText;
  final TextEditingController textfieldController;
  int? lines;
  double topPadding;
  final String header;

  MyProductTextField(
      {super.key,
      required this.hintText,
      required this.textfieldController,
      required this.textFieldWidth,
      this.lines,
      required this.topPadding,
      required this.header});

  @override
  State<MyProductTextField> createState() => _MyProductTextFieldState();
}

class _MyProductTextFieldState extends State<MyProductTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.header,
            style: FontText(context).bodyMediumBlack,
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
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
                controller: widget.textfieldController,
                style: FontText(context).bodyMediumBlack,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 10, top: widget.topPadding),
                  border: InputBorder.none,
                  hintText: " ${widget.hintText}",
                  hintStyle: FontText(context).bodySmallGrey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
