import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/myutility.dart';
import '../../components/styleButton.dart';

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
              fontWeight: FontWeight.bold,
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
            "Your application is currently pending approval, and you\'ll be notified by email once it\'s confirmed. In the meantime, feel free to continue browsing the portal with limited access. We\'re exited to have you on board and look forward to supporting you in your professional journey!",
            style: GoogleFonts.openSans(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          StyleButton(
            fontSize: 14,
            description: "CONTINUE",
            height: 50,
            buttonColor: Color.fromRGBO(0, 159, 158, 1),
            width: 130,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
