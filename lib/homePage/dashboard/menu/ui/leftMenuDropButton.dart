import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LeftMenuDropButton extends StatefulWidget {
  double menuSize;
  String description;
  String iconPath;
  final VoidCallback onPressed;
  bool isActive;
  final bool isOpen;
  final List <Widget> dropDownContent;
  LeftMenuDropButton(
      {super.key,
      required this.isActive,
      required this.menuSize,
      required this.description,
      required this.iconPath,
      required this.onPressed,
      required this.isOpen,
      required this.dropDownContent});

  @override
  State<LeftMenuDropButton> createState() => _LeftMenuDropButtonState();
}

class _LeftMenuDropButtonState extends State<LeftMenuDropButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.menuSize == 6.5) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: widget.isActive
                      ? Color.fromRGBO(174, 204, 236, 1)
                      : Color.fromRGBO(248, 250, 255, 1)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered))
                        return Color.fromRGBO(24, 68, 126, 1);
                      return Colors.black;
                    }),
                  ),
                  onPressed: widget.onPressed,
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        child: SvgPicture.asset(
                          widget.iconPath,
                          color: Color.fromARGB(255, 8, 55, 145),
                          width: 20,
                          height: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.description,
                        style: GoogleFonts.openSans(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (widget.isOpen)
            Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: widget.dropDownContent,)
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: widget.isActive
                  ? Color.fromRGBO(174, 204, 236, 1)
                  : Color.fromRGBO(248, 250, 255, 1)),
          child: TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered))
                  return Color.fromARGB(255, 8, 55, 145);
                return Color(0xFF6A6A6A);
              }),
            ),
            onPressed: widget.onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset(
                      widget.iconPath,
                      color: Color.fromARGB(255, 8, 55, 145),
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
