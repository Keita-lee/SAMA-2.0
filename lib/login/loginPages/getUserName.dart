import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/Login/popups/validateDialog.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/components/utility.dart';

enum SingingCharacter { email, mobile }

class GetUsername extends StatefulWidget {
  Function(int) changePage;
  Function(String) getEmail;
  Function(String) getMobileNumber;
  GetUsername(
      {super.key,
      required this.getEmail,
      required this.changePage,
      required this.getMobileNumber});

  @override
  State<GetUsername> createState() => _GetUsernameState();
}

class _GetUsernameState extends State<GetUsername> {
  String? retrieveType = "email";
  String checkEmailsText = "";

  // Text controllers
  final email = TextEditingController();

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
    final users = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email.text)
        .get();

//If user exist send link
    if (users.docs.length >= 1) {
      //Update email variable
      widget.getEmail(email.text);

      final FirebaseAuth _auth = FirebaseAuth.instance;

      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email.text!, password: users.docs[0].get('password'));

      userCredential.user!.sendEmailVerification().then((value) => {
            setState(
              () {
                checkEmailsText =
                    "Please check your email for verification link and click Retrieve SAMA Number button";
              },
            )
          });
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
      width: MyUtility(context).width / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Retrieve SAMA Number",
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Enter your ${retrieveType}",
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
            "Send Email Verification link to:",
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
                    retrieveType = "email";
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
          SizedBox(
            height: 8,
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
                value: SingingCharacter.mobile,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    retrieveType = "mobile number";
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
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            checkEmailsText,
            style: TextStyle(
                fontSize: 18, color: Colors.red, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 15,
          ),
          Visibility(
            visible: checkEmailsText == "" ? false : true,
            child: StyleButton(
                description: "Retrieve SAMA Number",
                height: 55,
                width: 200,
                onTap: () {
                  widget.changePage(13);
                }),
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
