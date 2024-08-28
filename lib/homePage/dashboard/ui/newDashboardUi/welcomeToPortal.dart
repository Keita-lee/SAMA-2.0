import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeToPortal extends StatefulWidget {
  const WelcomeToPortal({super.key});

  @override
  State<WelcomeToPortal> createState() => _WelcomeToPortalState();
}

class _WelcomeToPortalState extends State<WelcomeToPortal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 628,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color.fromARGB(255, 190, 190, 190)),
      ),
      child: Row(
        children: [
          Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
              image: DecorationImage(
                  image: AssetImage('images/laptop.jpg'), fit: BoxFit.fill),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to the \nSAMA Member Potral',
                  style: GoogleFonts.openSans(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    style: GoogleFonts.openSans(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
