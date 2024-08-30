import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';

import 'package:sama/components/utility.dart';
import 'package:sama/homePage/PostLoginLandingPage.dart';
import 'package:sama/login/popups/validateDialog.dart';

class LoginWithPassword extends StatefulWidget {
  Function(int) changePage;
  String? email;
  LoginWithPassword({super.key, required this.changePage, required this.email});

  @override
  State<LoginWithPassword> createState() => _LoginWithPasswordState();
}

class _LoginWithPasswordState extends State<LoginWithPassword> {
  bool showNonMemberBorder = false;
  bool showForgotPasswordBorder = false;
  // Text controllers
  final password = TextEditingController(text: ''); //REMOVE AFTER TEST

  BuildContext? dialogContext;

  //Dialog for password Validate
  Future openValidateDialog(description) => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: ValidateDialog(
                description: description,
                closeDialog: () => Navigator.pop(dialogContext!)));
      });

//Sign in witp password and email
  login() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: widget.email!.toString(),
        password: password.text.trim(),
      );
      if (userCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Material(
                    child: Material(
                        child: PostLoginLandingPage(
                      userId: userCredential.user!.uid,
                      activeIndex: 0,
                    )),
                  )),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        openValidateDialog('No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        openValidateDialog('Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      } else {
        openValidateDialog('No user found');
      }
    }

/*

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: widget.email!.toString(),
      password: password.text.trim(),
    );

    if (userCredential.user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Material(
                  child: Material(
                      child: PostLoginLandingPage(
                          userId: userCredential.user!.uid)),
                )),
      );
    }*/
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
            "Login",
            style: GoogleFonts.openSans(
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
              style: GoogleFonts.openSans(
                fontSize: 16,
                color: Colors.grey[600],
                letterSpacing: -0.5,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: "password ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: -0.5,
                  ),
                ),
                TextSpan(
                  text: "to continue",
                  style: TextStyle(
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
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: MyUtility(context).width * 0.3,
                child: TextFieldStyling(
                  obscure: true,
                  hintText: 'Password',
                  textfieldController: password,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: StyleButton(
                  description: "LOGIN",
                  height: 55,
                  width: 85,
                  onTap: () {
                    login();
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Need help?",
            style: GoogleFonts.openSans(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
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
              "Reset my password",
              style: GoogleFonts.openSans(
                decoration: showForgotPasswordBorder == true
                    ? TextDecoration.underline
                    : TextDecoration.none,
                decorationColor: Color.fromRGBO(0, 159, 158, 1),
                decorationThickness: 2,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.5,
                color: const Color.fromRGBO(0, 159, 158, 1),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                'Dont have a profile? ',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Material(
                                child: Material(
                                    child: PostLoginLandingPage(
                                  userId: "",
                                  activeIndex: 0,
                                )),
                              )));
                },
                onHover: (hovered) {
                  setState(() {
                    showNonMemberBorder = hovered;
                  });
                },
                child: Text(
                  "Register here",
                  style: GoogleFonts.openSans(
                      decoration: showNonMemberBorder == true
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      decorationColor: Color.fromRGBO(0, 159, 158, 1),
                      decorationThickness: 2,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                      fontSize: 16,
                      color: const Color.fromRGBO(0, 159, 158, 1)),
                ),
              ),
              Text(
                ' as a member or create a free account',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  color: Colors.grey[600],
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
            description: "Login",
            height: 55,
            width: 85,
            onTap: () {
              login();
            },
          )*/
        ],
      ),
    );
  }
}
