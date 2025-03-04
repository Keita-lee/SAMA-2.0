import 'package:flutter/material.dart';
import 'package:sama/components/mobile/components/Themes/custom_colors.dart';
import 'package:sama/components/myutility.dart';

// import 'package:google_fonts/google_fonts.dart';

class FontText {
  BuildContext context;
  FontText(this.context);
  double get width => MediaQuery.of(context).size.width;
  bool get isMobile => MediaQuery.of(context).size.width < 600 ? true : false;
  TextStyle get headingLarge => TextStyle(
        color: Colors.black,
        fontSize: isMobile ? width / 20 : 26,
        fontWeight: FontWeight.w600,
      );

  TextStyle get bodyMediumBlack => TextStyle(
        color: const Color.fromARGB(255, 53, 53, 53),
        fontSize: isMobile ? width / 25 : 16,
        fontWeight: FontWeight.bold,
      );

  TextStyle get bodySmallGrey => TextStyle(
        color: const Color.fromARGB(255, 139, 139, 139),
        fontSize: isMobile ? width / 30 : 14,
        fontWeight: FontWeight.normal,
      );

  TextStyle get bodyMediumGrey => TextStyle(
        color: const Color.fromARGB(255, 139, 139, 139),
        fontSize: isMobile ? width / 25 : 16,
        fontWeight: FontWeight.bold,
      );

  TextStyle get bodySmallBlack => TextStyle(
        color: Colors.black,
        fontSize: isMobile ? width / 30 : 14,
        fontWeight: FontWeight.normal,
      );

  TextStyle get bodyRegularBlack => TextStyle(
        color: Colors.black,
        fontSize: isMobile ? width / 27 : 16,
        fontWeight: FontWeight.normal,
      );

  TextStyle get regularWhite => TextStyle(
        color: Colors.white,
        fontSize: isMobile ? width / 27 : 16,
        fontWeight: FontWeight.normal,
      );

  TextStyle get footerSmallBlack => TextStyle(
        color: Colors.black,
        fontSize: width / 36,
        fontWeight: FontWeight.normal,
      );

  TextStyle get mediumBlue => TextStyle(
        color: CustomColors.lightBlue,
        fontSize: isMobile ? width / 20 : 24,
        fontWeight: FontWeight.w600,
      );

  TextStyle get mediumlinksBlue => TextStyle(
        color: CustomColors.lightBlue,
        fontSize: isMobile ? width / 27 : 14,
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.underline,
        decorationColor: CustomColors.lightBlue, // Add this line
      );

  TextStyle get linksBlue => TextStyle(
        color: CustomColors.lightBlue,
        fontSize: isMobile ? width / 34 : 14,
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.underline,
        decorationColor: CustomColors.lightBlue, // Add this line
      );

  static TextStyle defaultStyle({
    Color color = Colors.black,
    double fontSize = 10,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}
