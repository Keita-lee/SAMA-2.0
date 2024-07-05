import 'package:flutter/material.dart';

class Tabstyle extends StatefulWidget {
  VoidCallback changePage;
  int pageIndex;
  int tabIndexNumber;
  String description;
  double customWidth;
  Color customColor1;
  Color customColor2;
  Tabstyle({
    super.key,
    required this.changePage,
    required this.pageIndex,
    required this.tabIndexNumber,
    required this.description,
    required this.customWidth,
    required this.customColor1,
    required this.customColor2,
  });

  @override
  State<Tabstyle> createState() => _TabstyleState();
}

class _TabstyleState extends State<Tabstyle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          widget.changePage();
        },
        child: Container(
          height: 50,
          width: widget.customWidth!,
          color: widget.pageIndex == widget.tabIndexNumber
              ? widget.customColor1
              : widget.customColor2,
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
