import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/myutility.dart';

class CodingAcademy extends StatefulWidget {
  const CodingAcademy({super.key});

  @override
  State<CodingAcademy> createState() => _CodingAcademyState();
}

class _CodingAcademyState extends State<CodingAcademy> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Coming Soon !',
              style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  'To be a contributor, please contact ',
                  style: GoogleFonts.openSans(fontSize: 16),
                ),
                Text(
                  'online@samedical.org',
                  style: GoogleFonts.openSans(fontSize: 16, color: Colors.teal),
                ),
              ],
            )
          ],
        ));
  }
}
