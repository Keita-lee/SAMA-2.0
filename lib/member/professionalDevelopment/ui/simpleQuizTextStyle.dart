import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleQuizTextStyle extends StatelessWidget {
  final String text;
  const SimpleQuizTextStyle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(fontWeight: FontWeight.normal, fontSize: 15),
    );
  }
}
