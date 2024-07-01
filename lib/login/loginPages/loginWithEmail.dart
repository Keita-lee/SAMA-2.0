import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/Login/popups/validateDialog.dart';

import 'package:sama/components/email/sendOtp.dart';
import 'package:sama/components/passwordStrengthMeter.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';

import 'package:sama/components/utility.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import 'package:sama/homePage/PostLoginLandingPage.dart';
import 'package:sama/login/loginPages.dart';

enum SingingCharacter { memberNumber, email }

class LoginWithEmail extends StatefulWidget {
  Function(int) changePage;
  Function(String) getEmail;
  LoginWithEmail({super.key, required this.changePage, required this.getEmail});

  @override
  State<LoginWithEmail> createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends State<LoginWithEmail> {
  // Text controllers
  final email = TextEditingController(text: '');

  String validateText = "";

  bool showRegisterBorder = false;
  bool showForgotPasswordBorder = false;
  bool showForgotSamaBorder = false;

  BuildContext? dialogContext;

//Update state of text
  updateStateText(value) {
    setState(() {
      validateText = value;
    });
  }

  //Dialog for validate  form
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
    widget.getEmail((email.text).toLowerCase());
    final users = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: (email.text).toLowerCase())
        .get();
    updateStateText("");
    if (users.docs.length >= 1 && email.text != "") {
      for (int i = 0; i < users.docs.length; i++) {}
      widget.changePage(1);
    } else {
      updateStateText(
          "Error: Unknown email address. Check again or try using your SAMA member number.");
      // openValidateDialog();
    }
  }

  //Check if member exists and continue
  checkMemberNumber() async {
    final users = await FirebaseFirestore.instance
        .collection('users')
        .where('practiceNumber', isEqualTo: email.text.toLowerCase())
        .get();
    updateStateText("");
    if (users.docs.length >= 1 && email.text.toLowerCase() != "") {
      for (int i = 0; i < users.docs.length; i++) {}
      widget.getEmail(users.docs[0].get("email"));
      widget.changePage(1);
    } else {
      updateStateText(
          "Error: The SAMA member number ${email.text}  is not registered on this site. If you are unsure of your SAMA member number, try your email address instead.");
      //openValidateDialog();
    }
  }

  checkUserState() async {
    var uid = await FirebaseAuth.instance.currentUser!.uid;
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Material(
                    child: Material(child: PostLoginLandingPage(userId: uid)),
                  )));
    });
    /**/ // var userId = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  void initState() {
    checkUserState();
    super.initState();
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
            "Login",
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Please enter your SAMA number or your Email address to continue",
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextFieldStyling(
              hintText:
                  'chrispotjnr@gmail.com (A) / chrispotgieter145@gmail.com (M)',
              textfieldController: email,
            ),
          ),
          Text(
            validateText,
            style: TextStyle(
              fontSize: 14,
              color: Colors.red,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              widget.changePage(2);
            },
            onHover: (hovered) {
              setState(() {
                showForgotPasswordBorder = hovered;
              });
            },
            child: Text(
              "Forgot Password? Help me",
              style: TextStyle(
                  decoration: showForgotPasswordBorder == true
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  decorationColor: Color.fromARGB(255, 8, 55, 145),
                  decorationThickness: 2,
                  fontSize: 16,
                  color: const Color.fromARGB(255, 8, 55, 145)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              widget.changePage(11);
            },
            onHover: (hovered) {
              setState(() {
                showForgotSamaBorder = hovered;
              });
            },
            child: Text(
              "Forgot SAMA Number? Help me",
              style: TextStyle(
                  decoration: showForgotSamaBorder == true
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  decorationColor: Color.fromARGB(255, 8, 55, 145),
                  decorationThickness: 2,
                  fontSize: 16,
                  color: const Color.fromARGB(255, 8, 55, 145)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              widget.changePage(9);
            },
            onHover: (hovered) {
              setState(() {
                showRegisterBorder = hovered;
              });
            },
            child: Text(
              "Not a member? Register Here.",
              style: TextStyle(
                  decoration: showRegisterBorder == true
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  decorationColor: Color.fromARGB(255, 8, 55, 145),
                  decorationThickness: 2,
                  fontSize: 16,
                  color: const Color.fromARGB(255, 8, 55, 145)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          StyleButton(
            description: "Continue",
            height: 55,
            width: 100,
            onTap: () {
              if (email.text.contains("@")) {
                checkEmail();
              } else {
                checkMemberNumber();
              }
            },
          ),
          // SizedBox(
          //   height: 150,
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "SAMA Beta Version 1.1.0",
              style: TextStyle(fontSize: 13, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
