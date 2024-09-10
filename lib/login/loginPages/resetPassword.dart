import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/Login/popups/validateDialog.dart';
import 'package:sama/components/email/sendOtp.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/components/utility.dart';
import 'package:sama/login/loginPages.dart';
import 'package:sama/utils/oracleDbManager.dart';

enum SingingCharacter { email, mobile }

class ResetPassword extends StatefulWidget {
  Function(int) changePage;
  Function(String) getEmail;
  Function(String) getEmailChangeType;

  ResetPassword({
    super.key,
    required this.getEmail,
    required this.changePage,
    required this.getEmailChangeType,
  });

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  // Text controllers
  final email = TextEditingController();
  bool isLoading = false;
  //var

  SingingCharacter? _character = SingingCharacter.email;

  BuildContext? dialogContext;
  //Dialog for contruction popup
  Future OpenContructionPopup() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: ValidateDialog(
                description: "Under Construction",
                closeDialog: () => Navigator.pop(context!)));
      });
  //Dialog for product form
  Future openValidateDialog() => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: ValidateDialog(
                description: "User does not exist",
                closeDialog: () => Navigator.pop(dialogContext!)));
      });

  //Check if email exists and continue
  checkEmail() async {
    try {
      setState(() {
        isLoading = true;
      });
      final OracleDbManager oracleDbManager = OracleDbManager();
      final memberData = await oracleDbManager.checkSamaNo(email.text);
      final _auth = FirebaseAuth.instance;
      if (memberData['items'].isNotEmpty) {
        widget.getEmailChangeType("passwordResetPage");
        final oracelEmail = memberData['items'][0]['email_sama'];

        widget.getEmail(oracelEmail);
        final user = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: oracelEmail)
            .get();

        if (user.docs.isNotEmpty) {
          if (_character == SingingCharacter.mobile) {
            //Mobile OTP send
            widget.changePage(3);
          } else {
            String randomOtp =
                Random().nextInt(999999).toString().padLeft(6, '0');
            await sendOtp(
                otp: randomOtp, email: memberData['items'][0]['email_sama']);
            widget.changePage(14);
          }
          setState(() {
            isLoading = false;
          });
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Material(
                child: LoginPages(
                  pageIndex: 19,
                ),
              ),
            ),
          );
        }

        // final users = await FirebaseFirestore.instance
        //     .collection('users')
        //     .where('practiceNumber', isEqualTo: email.text.toLowerCase())
        //     .get();

        //If user exist send link
        // if (users.docs.length >= 1) {
        //   //Update email variable
        //   widget.getEmail(users.docs[0].get("email"));
        //   //Mobile OTP send
        //   if (_character == SingingCharacter.mobile) {
        //     widget.changePage(3);
        //   } else {
        //     String randomOtp = Random().nextInt(999999).toString().padLeft(6, '0');
        //     await sendOtp(otp: randomOtp, email: users.docs[0].get("email"));
        //     widget.changePage(14);
        //   }
        // } else {
        //   openValidateDialog();
        // }
      } else {
        setState(() {
          isLoading = false;
        });
        openValidateDialog();
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('error validation $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width / 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Password Reset",
            style: GoogleFonts.openSans(
              fontSize: 22,
              color: Color.fromRGBO(0, 159, 158, 1),
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text.rich(
            TextSpan(
              text: "Enter your ",
              style: GoogleFonts.openSans(
                fontSize: 16,
                color: Colors.grey[600],
                letterSpacing: -0.5,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: "SAMA number",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: -0.5,
                  ),
                ),
                TextSpan(
                  text: " to receive a one time pin ",
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: Colors.grey[600],
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(
                width: MyUtility(context).width * 0.3,
                child: TextFieldStyling(
                  hintText: 'Enter here',
                  textfieldController: email,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: StyleButton(
                  waiting: isLoading,
                  description: "SEND OTP",
                  height: 55,
                  width: 145,
                  onTap: () {
                    checkEmail();
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Send One Time Pin To:",
            style: GoogleFonts.openSans(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Radio<SingingCharacter>(
                activeColor: Color.fromRGBO(0, 159, 158, 1),
                value: SingingCharacter.email,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              Text(
                "To my Email Address",
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  color: Color.fromRGBO(0, 159, 158, 1),
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio<SingingCharacter>(
                activeColor: Color.fromRGBO(0, 159, 158, 1),
                value: SingingCharacter.mobile,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              Text(
                "To my mobile no",
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  color: Color.fromRGBO(0, 159, 158, 1),
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          /*StyleButton(
            description: "Reset Password",
            height: 55,
            width: 145,
            onTap: () {
              checkEmail();
            },
          ),*/
          Text(
            "Need help?",
            style: GoogleFonts.openSans(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () {
              OpenContructionPopup();
            },
            child: Text(
              "Help me retrieve my SAMA number",
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
        ],
      ),
    );
  }
}
