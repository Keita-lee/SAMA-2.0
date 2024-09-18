import 'package:flutter/material.dart';
import 'package:sama/components/utility.dart';

class TextFieldStyling extends StatefulWidget {
  String hintText;
  bool? obscure;
  final TextEditingController textfieldController;

  TextFieldStyling(
      {super.key,
      required this.hintText,
      this.obscure,
      required this.textfieldController});

  @override
  State<TextFieldStyling> createState() => _TextFieldStylingState();
}

class _TextFieldStylingState extends State<TextFieldStyling> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: MyUtility(context).width,
            height: 45,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                border: Border.all(
                  color: const Color.fromARGB(255, 51, 51, 51),
                ),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: TextFormField(
              obscureText: widget.obscure != null ? true : false,
              controller: widget.textfieldController,
              style: TextStyle(
                color: Color.fromARGB(255, 153, 147, 147),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                border: InputBorder.none,
                hintText: " ${widget.hintText}",
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 199, 199, 199),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
