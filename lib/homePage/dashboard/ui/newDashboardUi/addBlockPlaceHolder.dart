import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddBlockPlaceHolder extends StatelessWidget {
  const AddBlockPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 180,
          width: 465,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 226, 226, 226),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color.fromARGB(255, 190, 190, 190),
            ),
          ),
          child: Center(
            child: Text(
              'Advertise here',
              style:
                  GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 20,),
        Container(
          height: 180,
          width: 465,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 226, 226, 226),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color.fromARGB(255, 190, 190, 190),
            ),
          ),
          child: Center(
            child: Text(
              'Advertise here',
              style:
                  GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
