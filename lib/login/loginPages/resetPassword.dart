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
        .where('practiceNumber', isEqualTo: email.text)
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
      width: MyUtility(context).width / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reset Password",
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Enter your SAMA Number",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(
            height: 15,
          ),
          TextFieldStyling(
            hintText: 'Enter here',
            textfieldController: email,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Send OTP to:",
            style: TextStyle(fontSize: 17, color: Colors.black),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Radio<SingingCharacter>(
                activeColor: Color.fromARGB(255, 8, 55, 145),
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
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              Radio<SingingCharacter>(
                activeColor: Color.fromARGB(255, 8, 55, 145),
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
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          StyleButton(
            description: "Reset Password",
            height: 55,
            width: 145,
            onTap: () {
              checkEmail();
            },
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Need help? CONTACT SAMA",
            style: TextStyle(
                fontSize: 16, color: const Color.fromARGB(255, 8, 55, 145)),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              widget.changePage(0);
            },
            child: Text(
              "Back to Login",
              style: TextStyle(
                  fontSize: 16, color: const Color.fromARGB(255, 8, 55, 145)),
            ),
          ),
        ],
      ),
    );
  }
}
