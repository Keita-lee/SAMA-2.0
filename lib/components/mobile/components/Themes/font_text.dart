import 'package:flutter/material.dart';
import 'package:sama/components/mobile/components/Themes/custom_colors.dart';

// import 'package:google_fonts/google_fonts.dart';

class FontText {
  BuildContext context;
  FontText(this.context);
  double get width => MediaQuery.of(context).size.width;
  TextStyle get headingLarge => TextStyle(
        color: Colors.black,
        fontSize: width / 20,
        fontWeight: FontWeight.w600,
      );

  TextStyle get bodyMediumBlack => TextStyle(
        color: const Color.fromARGB(255, 53, 53, 53),
        fontSize: width / 25,
        fontWeight: FontWeight.bold,
      );

  TextStyle get bodySmallGrey => TextStyle(
        color: const Color.fromARGB(255, 139, 139, 139),
        fontSize: width / 28,
        fontWeight: FontWeight.normal,
      );

  TextStyle get bodyMediumGrey => TextStyle(
        color: const Color.fromARGB(255, 139, 139, 139),
        fontSize: width / 25,
        fontWeight: FontWeight.bold,
      );

  TextStyle get bodySmallBlack => TextStyle(
        color: Colors.black,
        fontSize: width / 25,
        fontWeight: FontWeight.normal,
      );

  TextStyle get footerSmallBlack => TextStyle(
        color: Colors.black,
        fontSize: width / 36,
        fontWeight: FontWeight.normal,
      );

  TextStyle get mediumBlue => TextStyle(
        color: CustomColors.lightBlue,
        fontSize: width / 20,
        fontWeight: FontWeight.w600,
      );

  TextStyle get linksBlue => TextStyle(
        color: CustomColors.lightBlue,
        fontSize: width / 38,
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
