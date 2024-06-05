import 'package:flutter/material.dart';

class EventTxtField extends StatefulWidget {
  final String textSection;
  final TextEditingController controller;

  const EventTxtField(
      {Key? key, required this.controller, required this.textSection})
      : super(key: key);

  @override
  State<EventTxtField> createState() => _EventTxtFieldState();
}

class _EventTxtFieldState extends State<EventTxtField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.textSection,
            hintStyle: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.normal,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
