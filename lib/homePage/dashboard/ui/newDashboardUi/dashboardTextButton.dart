import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/commonColors/SamaColors.dart';

class DashboardTextButton extends StatefulWidget {
  final String text;
  final Function() onTap;
  final Color? decorationColor;
  final Color? textColor;
  const DashboardTextButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.decorationColor,
      this.textColor});

  @override
  State<DashboardTextButton> createState() => _DashboardTextButtonState();
}

class _DashboardTextButtonState extends State<DashboardTextButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Text(
        widget.text,
        style: GoogleFonts.openSans(
          color: widget.textColor ?? SamaColors().teal,
          fontSize: 12,
          decoration: TextDecoration.underline,
          decorationColor: widget.decorationColor ?? SamaColors().teal,
          decorationThickness: 4,
        ),
      ),
    );
  }
}
