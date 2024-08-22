import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/myutility.dart';

class MembershipSignUp extends StatefulWidget {
  Function(int) changePage;
  MembershipSignUp({super.key, required this.changePage});

  @override
  State<MembershipSignUp> createState() => _MembershipSignUpState();
}

class _MembershipSignUpState extends State<MembershipSignUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MyUtility(context).width / 1.5,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Membership Sign Up",
                style: GoogleFonts.openSans(
                  fontSize: 22,
                  color: Color.fromRGBO(0, 159, 158, 1),
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Thank you for signing up for membership!",
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Your application is currently pending approval, and you\'ll be notified by email once it\'s confirmed. In the meantime, feel free to continue browsing the portal with",
                style: GoogleFonts.openSans(
                  fontSize: 17,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  widget.changePage(0);
                },
                child: Text(
                  "Return to Login",
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: const Color.fromRGBO(0, 159, 158, 1),
                    decoration: TextDecoration.underline,
                    decorationColor: Color.fromRGBO(0, 159, 158, 1),
                    decorationThickness: 2.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ]));
  }
}
