import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../components/myutility.dart';

class Applicationcontainerstyle extends StatefulWidget {
  Function(int) onpress;
  int index;
  int value;
  String description;
  Function(String) applicationTypeSelected;
  Applicationcontainerstyle(
      {super.key,
      required this.onpress,
      required this.index,
      required this.value,
      required this.description,
      required this.applicationTypeSelected});

  @override
  State<Applicationcontainerstyle> createState() =>
      _ApplicationcontainerstyleState();
}

class _ApplicationcontainerstyleState extends State<Applicationcontainerstyle> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onpress(widget.value);
        widget.applicationTypeSelected(widget.description);
      },
      child: Container(
        height: 50,
        width: MyUtility(context).width / 1.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: widget.value != widget.index
                    ? Color.fromARGB(255, 25, 86, 199)
                    : Color.fromARGB(255, 8, 55, 145)),
            color: widget.value != widget.index
                ? Color.fromARGB(255, 255, 255, 255)
                : Color.fromARGB(255, 8, 55, 145)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            widget.description,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
