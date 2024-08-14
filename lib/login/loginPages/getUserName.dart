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

class GetUsername extends StatefulWidget {
  Function(int) changePage;
  Function(String) getEmail;
  Function(String) getMobileNumber;
  Function(String) getEmailChangeType;
  GetUsername(
      {super.key,
      required this.getEmail,
      required this.changePage,
      required this.getMobileNumber,
      required this.getEmailChangeType});

  @override
  State<GetUsername> createState() => _GetUsernameState();
}

class _GetUsernameState extends State<GetUsername> {
  String? retrieveType = "email";

  // Text controllers
  final email = TextEditingController();

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

  //Dialog for product form
  Future openValidateSuccessDialog() => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: ValidateDialog(
                description: "Reset Password Link sent",
                closeDialog: () => Navigator.pop(dialogContext!)));
      });

  //Check if email exists and continue
  checkEmail() async {
    widget.getEmailChangeType("usernamePage");
    final users = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email.text)
        .get();

//If user exist send link
    if (users.docs.length >= 1) {
      //Update email variable
      widget.getEmail(email.text);
      String randomOtp = Random().nextInt(999999).toString().padLeft(6, '0');
      await sendOtp(otp: randomOtp, email: users.docs[0].get("email"));
      widget.changePage(14);
    } else {
      openValidateDialog();
    }
  }

  checkMobileNumber() async {
    widget.getMobileNumber(email.text);

    final users = await FirebaseFirestore.instance
        .collection('users')
        .where('mobileNo', isEqualTo: email.text)
        .get();

//If user change page
    if (users.docs.length >= 1) {
      widget.changePage(12);
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
            "Retrieve SAMA Number",
            style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(0, 159, 158, 1),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          /*Text(
            "Enter your ${retrieveType}",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),*/
          Text.rich(
            TextSpan(
              text: "Enter your ",
              style: TextStyle(fontSize: 15, color: Colors.black),
              children: [
                TextSpan(
                  text: "email address",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: " to receive a one time pin ",
                  style: TextStyle(fontSize: 15, color: Colors.black),
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
                  width: 130,
                  onTap: () {
                    if (_character == SingingCharacter.email) {
                      checkEmail();
                    } else {
                      checkMobileNumber();
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Send One Time Pin to:",
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
                    retrieveType = "email";
                    _character = value;
                    email.text = "";
                  });
                },
              ),
              Text(
                "My email address",
                style: TextStyle(
                    fontSize: 15, color: Color.fromRGBO(0, 159, 158, 1)),
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
                    retrieveType = "mobile number";
                    _character = value;
                    email.text = "+27 ";
                  });
                },
              ),
              Text(
                "My cell phone number",
                style: TextStyle(
                    fontSize: 15, color: Color.fromRGBO(0, 159, 158, 1)),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          /*StyleButton(
            description: "Send Verification",
            height: 55,
            width: 145,
            onTap: () {
              if (_character == SingingCharacter.email) {
                checkEmail();
              } else {
                checkMobileNumber();
              }
            },
          ),*/
          /*SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              OpenContructionPopup();
            },
            child: Text(
              "Need help? CONTACT SAMA",
              style: TextStyle(
                  fontSize: 16, color: const Color.fromARGB(255, 8, 55, 145)),
            ),
          ),
          SizedBox(
            height: 15,
          ),*/
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
                  decorationThickness: 2.0,
                  decorationColor: Color.fromRGBO(0, 159, 158, 1)),
            ),
          ),
        ],
      ),
    );
  }
}
