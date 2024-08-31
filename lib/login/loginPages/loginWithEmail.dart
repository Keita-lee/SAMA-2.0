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
    final TokenStorage storage = TokenStorage();
    // Ensure the token is valid or refresh it if needed
    await tokenManager.refreshTokenIfNeeded();
    // Get the valid token
    String? token = await storage.getToken();

    if (token == null || token == '') {
      print('error getting token');
      return false;
    }

    http.Response response = await http.get(
        Uri.parse(
            'http://41.217.246.121:8080/ords/ordssama/web-clients/clients/?q={"email_sama":$email}&limit=1'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
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
    final TokenStorage storage = TokenStorage();
    // Ensure the token is valid or refresh it if needed
    await tokenManager.refreshTokenIfNeeded();
    // Get the valid token
    String? token = await storage.getToken();

    if (token == null || token == '') {
      print('error getting token');
    }

    print("token: $token");
    http.Response response = await http.get(
        Uri.parse(
            'http://41.217.246.121:8080/ords/ordssama/web-clients/clients/$samaNo'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
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

    bool foundOnOracleDb = await checkOracleDb((email.text).toLowerCase());
    bool foundInFirebase = users.docs.isNotEmpty;

    // user is in firebase and is sama member
    if (foundInFirebase && email.text != "" && foundOnOracleDb) {
      // update member type
      firestore
          .collection('users')
          .doc(users.docs.first.id)
          .set({'memberType': 'SAMA Member'});

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
      firestore
          .collection('users')
          .doc(users.docs.first.id)
          .set({'memberType': 'SAMA Non Member'});

      if (users.docs.first.data()['status'] == 'Active') {
        widget.changePage(1);
      } else {
        updateStateText(
            "Your account is pending approval. You will receive an email once approved");
      }
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
    print(member);
    List data = member['items'];
    updateStateText("");
    if (data.isNotEmpty && data[0]['membership_paid'] == 'Y') {
      List data = member['items'];
      if (data.isNotEmpty) widget.changePage(1);
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
                    child: Material(
                        child: PostLoginLandingPage(
                      userId: uid,
                      activeIndex: 0,
                    )),
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
      width: MyUtility(context).width / 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Login",
            style: GoogleFonts.openSans(
              textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              color: Color.fromRGBO(0, 159, 158, 1),
            ),
          ),
          SizedBox(
            height: 10,
          ),
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

          /*InkWell(
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
          ), */
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
          /*StyleButton(
            description: "Continue",
            height: 55,
            width: 100,
            onTap: () {
              if (email.text.contains("@")) {
                checkEmail();
              } else {
                checkMemberNumber();s
              }
            },
          ),*/
          // SizedBox(
          //   height: 150,
          // ),
          /*Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "SAMA Beta Version 1.1.0",
              style: TextStyle(fontSize: 13, color: Colors.black),
            ),
          ),*/
        ],
      ),
    );
  }
}
