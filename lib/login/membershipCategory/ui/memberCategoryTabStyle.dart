import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberCategoryTabStyle extends StatefulWidget {
  Function(int) onpress;
  int index;
  int value;
  String description;
  MemberCategoryTabStyle(
      {super.key,
      required this.onpress,
      required this.index,
      required this.value,
      required this.description});

  @override
  State<MemberCategoryTabStyle> createState() => _MemberCategoryTabStyleState();
}

class _MemberCategoryTabStyleState extends State<MemberCategoryTabStyle> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //widget.onpress(widget.value);
      },
      child: Container(
        height: 35,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: widget.value != widget.index
                    ? Color.fromARGB(255, 25, 86, 199)
                    : Color.fromARGB(255, 8, 55, 145)),
            color: widget.value != widget.index
                ? Color.fromARGB(255, 255, 255, 255)
                : Color.fromARGB(255, 8, 55, 145)),
        child: Center(
          child: Text(
            widget.description,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              color: widget.value != widget.index
                  ? Color.fromARGB(255, 25, 86, 199)
                  : Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ),
    );
  }
}
