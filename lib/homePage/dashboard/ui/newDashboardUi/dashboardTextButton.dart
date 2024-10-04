import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/commonColors/SamaColors.dart';
import 'package:sama/components/mobile/components/Themes/font_text.dart';
import 'package:sama/components/myutility.dart';

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
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return InkWell(
      onTap: widget.onTap,
      child: Text(widget.text, style: FontText(context).mediumlinksBlue),
    );
  }
}
