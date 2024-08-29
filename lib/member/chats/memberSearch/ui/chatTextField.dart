import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../components/myutility.dart';

class ChatTextField extends StatefulWidget {
  String hintText;
  final TextEditingController textfieldController;
  ChatTextField(
      {super.key, required this.hintText, required this.textfieldController});

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
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
                  color: const Color.fromARGB(255, 212, 212, 212),
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: TextFormField(
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
                  fontSize: 20,
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
