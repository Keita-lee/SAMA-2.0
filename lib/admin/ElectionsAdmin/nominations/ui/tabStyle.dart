import 'package:flutter/material.dart';

class Tabstyle extends StatefulWidget {
  VoidCallback changePage;
  int pageIndex;
  int tabIndexNumber;
  String description;
  double customWidth;
  Tabstyle(
      {super.key,
      required this.changePage,
      required this.pageIndex,
      required this.tabIndexNumber,
      required this.description,
      required this.customWidth});

  @override
  State<Tabstyle> createState() => _TabstyleState();
}

class _TabstyleState extends State<Tabstyle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          widget.changePage();
        },
        child: Container(
          height: 50,
          width: widget.customWidth!,
          color: widget.pageIndex == widget.tabIndexNumber
              ? Color.fromARGB(255, 8, 55, 145)
              : Color.fromARGB(255, 83, 115, 175),
          child: Center(
            child: Text(
              widget.description,
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
