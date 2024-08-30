import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/banner/samaBlueBanner.dart';
import 'package:sama/components/myutility.dart';

class CodingAcademy extends StatefulWidget {
  const CodingAcademy({super.key});

  @override
  State<CodingAcademy> createState() => _CodingAcademyState();
}

class _CodingAcademyState extends State<CodingAcademy> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SamaBlueBanner(pageName: 'CODING ACADEMY'),
          SizedBox(
            height: 30,
          ),
          Padding(
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
                ],
              ))
        ],
      )
    ]);
  }
}
