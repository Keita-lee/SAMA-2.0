import 'package:flutter/material.dart';

class ElectionTabStyle extends StatefulWidget {
  VoidCallback changePage;
  int pageIndex;
  int tabIndexNumber;
  String description;
  double customWidth;
  Color customColor1;
  Color customColor2;
  ElectionTabStyle({
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
  State<ElectionTabStyle> createState() => _ElectionTabStyleState();
}

class _ElectionTabStyleState extends State<ElectionTabStyle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          widget.changePage();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: widget.pageIndex == widget.tabIndexNumber
                ? widget.customColor2
                : widget.customColor1,
          ),
          height: 65,
          width: widget.customWidth!,
          child: Center(
            child: Text(
              widget.description,
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
