import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/Login/loginPages/register.dart';
import 'package:sama/Login/popups/validateDialog.dart';

import 'package:sama/components/email/sendOtp.dart';
import 'package:sama/components/passwordStrengthMeter.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';

import 'package:sama/components/utility.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import 'package:sama/homePage/PostLoginLandingPage.dart';
import 'package:sama/login/loginPages.dart';
import 'package:sama/utils/tokenManager.dart';
import 'package:http/http.dart' as http;

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
  bool showNonMemberBorder = false;

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

  Future<bool> checkOracleDb(String email) async {
    final TokenManager tokenManager = TokenManager();
    // final TokenStorage storage = TokenStorage();
    // // Ensure the token is valid or refresh it if needed
    // await tokenManager.refreshTokenIfNeeded();
    // // Get the valid token
    // String? token = await storage.getToken();

    // if (token == null || token == '') {
    //   print('error getting token');
    //   return false;
    // }

    String basicAuth = tokenManager.basicAuth();

    http.Response response = await http.get(
        Uri.parse(
            'https://sama-api.onrender.com/get-clients?email_sama=$email'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List items = data['items'];
      if (items.isNotEmpty) {
        print(items[0]);
        return true;
      } else {
        return false;
      }
    }

    return false;
  }

  Future<Map<String, dynamic>> checkSamaNo(String samaNo) async {
    final TokenManager tokenManager = TokenManager();
    // final TokenStorage storage = TokenStorage();
    // // Ensure the token is valid or refresh it if needed
    // await tokenManager.refreshTokenIfNeeded();
    // // Get the valid token
    // String? token = await storage.getToken();

    // if (token == null || token == '') {
    //   print('error getting token');
    // }

    // print("token: $token");
    String basicAuth = tokenManager.basicAuth();

    http.Response response = await http.get(
        Uri.parse('https://sama-api.onrender.com/get-client/$samaNo'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return {};
  }

//Check if email exists and continue
  checkEmail() async {
    final firestore = FirebaseFirestore.instance;
    widget.getEmail((email.text).toLowerCase());
    final users = await firestore
        .collection('users')
        .where('email', isEqualTo: (email.text).toLowerCase())
        .get();

    updateStateText("");

    //If admin by pass all validators
    if (users.docs[0]['userType'] == "Admin") {
      return await widget.changePage(1);
    }
    bool foundOnOracleDb = await checkOracleDb((email.text).toLowerCase());
    bool foundInFirebase = users.docs.isNotEmpty;
    print(users.docs.first.id);
    // user is in firebase and is sama member
    if (foundInFirebase && email.text != "" && foundOnOracleDb) {
      // update member type
      firestore
          .collection('users')
          .doc(users.docs.first.id)
          .set({'userType': 'SAMA Member'});

      if (users.docs.first.data()['status'] == 'Active') {
        widget.changePage(1);
      } else {
        updateStateText(
            "Your account is pending approval. You will receive an email once approved");
      }
    }
    //user is in firebase and is not sama member - treated as non-member
    else if (foundInFirebase && !foundOnOracleDb) {
      // update member type
      // firestore
      //     .collection('users')
      //     .doc(users.docs.first.id)
      //     .set({'userType': 'SAMA Non Member'});

      // if (users.docs.first.data()['status'] == 'Active') {
      //   widget.changePage(1);
      // } else {
      //   updateStateText(
      //       "Your account is pending approval. You will receive an email once approved");
      // }
      updateStateText(
          'You are not a SAMA member yet. Please use non member portal.');
    }
    // user is in not firebase but is a sama member - needs to create an account
    else if (!foundInFirebase && foundOnOracleDb ||
        // user is in not firebase and is not sama member - needs to create an account
        !foundInFirebase && !foundOnOracleDb) {
      updateStateText("You don't have an account yet. Please register.");
    } else {
      updateStateText(
          "Error: Unknown email address. Check again or try using your SAMA member number.");
      // openValidateDialog();
    }
  }

  //Check if member exists and continue
  checkMemberNumber() async {
    Map<String, dynamic> member = await checkSamaNo(email.text);
    List data = member['items'];
    final users = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: (data[0]['email_sama']).toLowerCase())
        .get();
    updateStateText("");
    if (data.isNotEmpty &&
        users.docs.isNotEmpty &&
        users.docs.first['status'] == 'Active') {
      widget.changePage(1);
    } else {
      updateStateText(
          "Error: The SAMA member number ${email.text} is not registered on this site. If you are unsure of your SAMA member number, try your email address instead.");
      //openValidateDialog();
    }
  }

  getUserDetails() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (doc.exists) {
      if (doc.get('hpcsaNumber') != null && doc.get('status') == "Active") {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Material(
                        child: Material(
                            child: PostLoginLandingPage(
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          activeIndex: 0,
                        )),
                      )));
        });
      } else {
        FirebaseAuth.instance.signOut();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Material(
                      child: Material(child: LoginPages()),
                    )));
      }
    }
  }

//Check firebase if user valid
  checkUserState() async {
    getUserDetails();
  }

  @override
  void initState() {
    checkUserState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width / 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: "Login using your ",
              style: GoogleFonts.openSans(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
                letterSpacing: -0.5,
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
                  text: " or ",
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.5,
                  ),
                ),
                TextSpan(
                  text: "Email address",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Focus(
              onKeyEvent: (node, event) {
                if (event.logicalKey == LogicalKeyboardKey.enter) {
                  if (email.text.contains("@")) {
                    return checkEmail();
                  } else {
                    return checkMemberNumber();
                  }
                } else {
                  return KeyEventResult.ignored;
                }
              },
              child: Row(
                children: [
                  SizedBox(
                    width: MyUtility(context).width * 0.3,
                    child: TextFieldStyling(
                      hintText: 'Please add SAMA number or email Address',
                      textfieldController: email,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: StyleButton(
                      description: "PROCEED",
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
                  ),
                ],
              ),
            ),
          ),
          Text(
            validateText,
            style: TextStyle(
              fontSize: 14,
              color: Colors.red,
            ),
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
          SizedBox(
            height: 5,
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
              "Help me retrieve my SAMA Number",
              style: GoogleFonts.openSans(
                decoration: showForgotSamaBorder == true
                    ? TextDecoration.underline
                    : TextDecoration.none,
                decorationColor: Color.fromRGBO(0, 159, 158, 1),
                decorationThickness: 2,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.5,
                fontSize: 16,
                color: const Color.fromRGBO(0, 159, 158, 1),
              ),
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
                fontWeight: FontWeight.w500,
                letterSpacing: -0.5,
                fontSize: 16,
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
                  widget.changePage(9);
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
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: const Color.fromRGBO(0, 159, 158, 1),
                  ),
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
        ],
      ),
    );
  }
}
