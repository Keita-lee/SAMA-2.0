import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/Login/popups/validateDialog.dart';
import 'package:sama/components/email/sendOtp.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/components/utility.dart';

enum SingingCharacter { email, mobile }

class ResetPassword extends StatefulWidget {
  Function(int) changePage;
  Function(String) getEmail;
  Function(String) getEmailChangeType;
  ResetPassword(
      {super.key,
      required this.getEmail,
      required this.changePage,
      required this.getEmailChangeType});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  // Text controllers
  final email = TextEditingController();

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
    widget.getEmailChangeType("passwordResetPage");
    final users = await FirebaseFirestore.instance
        .collection('users')
        .where('practiceNumber', isEqualTo: email.text.toLowerCase())
        .get();

//If user exist send link
    if (users.docs.length >= 1) {
      //Update email variable
      widget.getEmail(users.docs[0].get("email"));
      //Mobile OTP send
      if (_character == SingingCharacter.mobile) {
        widget.changePage(3);
      } else {
        String randomOtp = Random().nextInt(999999).toString().padLeft(6, '0');
        await sendOtp(otp: randomOtp, email: users.docs[0].get("email"));
        widget.changePage(14);
      }
    } else {
      openValidateDialog();
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
            style: TextStyle(
                fontSize: 22,
                color: Color.fromRGBO(0, 159, 158, 1),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Text.rich(
            TextSpan(
              text: "Enter your ",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              children: [
                TextSpan(
                  text: "SAMA number",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextSpan(
                  text: " to receive a one time pin ",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
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
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
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
                style: TextStyle(
                    fontSize: 16, color: Color.fromRGBO(0, 159, 158, 1)),
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
                style: TextStyle(
                    fontSize: 16, color: Color.fromRGBO(0, 159, 158, 1)),
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
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
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
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromRGBO(0, 159, 158, 1),
                decoration: TextDecoration.underline,
                decorationColor: Color.fromRGBO(0, 159, 158, 1),
                decorationThickness: 2.0,
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
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromRGBO(0, 159, 158, 1),
                decoration: TextDecoration.underline,
                decorationColor: Color.fromRGBO(0, 159, 158, 1),
                decorationThickness: 2.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
