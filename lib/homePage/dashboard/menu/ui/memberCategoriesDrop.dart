import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberCategoriesDrop extends StatelessWidget {
  final String buttonText;
  Function() onTap;
  MemberCategoriesDrop(
      {super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 130,
          child: Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: ShapeDecoration(
                  shape: CircleBorder(
                    side: BorderSide(
                      width: 1.5,
                      color: Color.fromRGBO(174, 204, 236, 1),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                buttonText,
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
