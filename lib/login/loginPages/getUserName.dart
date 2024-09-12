import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/Login/popups/validateDialog.dart';
import 'package:sama/components/email/sendOtp.dart';
import 'package:sama/components/mobile/components/Themes/font_text.dart';
import 'package:sama/components/mobile/Navbar/footer.dart';
import 'package:sama/components/mobile/Navbar/navbar.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/components/utility.dart';
import 'package:sama/utils/oracleDbManager.dart';

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
    final OracleDbManager oracleDbManager = OracleDbManager();
    widget.getEmailChangeType("usernamePage");
    print('Email: ${email.text}');
    // final users = await FirebaseFirestore.instance
    //     .collection('users')
    //     .where('email', isEqualTo: email.text)
    //     .get();

    Map<String, dynamic> user = await oracleDbManager.checkOracleDb(email.text);

    //If user exist send link
    if (user.isNotEmpty) {
      //Update email variable
      widget.getEmail(email.text);
      String randomOtp = Random().nextInt(999999).toString().padLeft(6, '0');
      await sendOtp(otp: randomOtp, email: user['email_sama']);
      widget.changePage(14);
    } else {
      openValidateDialog();
    }
  }

  String formatMobileNumber() {
    String formattedString = email.text;
    // Check if the number starts with +27
    if (formattedString.startsWith('+27')) {
      // Remove +27
      formattedString = formattedString.substring(4);
    }
    print(formattedString);
    // Check if the number starts with 0
    if (!formattedString.startsWith('0')) {
      // Add 0 to the start of the number
      formattedString = '0' + formattedString;
    }

    return formattedString;
  }

  checkMobileNumber() async {
    widget.getMobileNumber(formatMobileNumber());
    print('Mobile Number: ${formatMobileNumber()}');

    final users = await FirebaseFirestore.instance
        .collection('users')
        .where('mobileNo', whereIn: [
      formatMobileNumber(),
      '+27${formatMobileNumber().substring(1)}',
      '+27 ${formatMobileNumber().substring(1)}'
    ]).get();

    //If user change page
    if (users.docs.length >= 1) {
      widget.changePage(12);
    } else {
      openValidateDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (MyUtility(context).width < 600) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Navbar(
              userType: "",
              onButton1Pressed: (value) {},
              onButton2Pressed: (value) {},
              onDropdownChanged: (value) {},
              visible: false,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Retrieve my SAMA number',
                    style: FontText(context).mediumBlue,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MyUtility(context).width - 10,
                    child: TextFieldStyling(
                      hintText:
                          'Enter your email address to receive a one time pin',
                      textfieldController: email,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Send one time pin to:',
                        style: FontText(context).bodyMediumGrey.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(height: 10),
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
                                retrieveType = "mobile number";
                                _character = value;
                                email.text = "+27 ";
                              });
                            },
                          ),
                          Text(
                            "My cell phone number",
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              color: Color.fromRGBO(0, 159, 158, 1),
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  StyleButton(
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
                  const SizedBox(height: 30),
                  Text(
                    'Return to login\n\n',
                    style: FontText(context).linksBlue.copyWith(
                          fontSize: MyUtility(context).width / 25,
                        ),
                  ),
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      );
    } else {
      return Container(
        width: MyUtility(context).width / 1.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Retrieve my SAMA Number",
              style: GoogleFonts.openSans(
                fontSize: 20,
                color: Color.fromRGBO(0, 159, 158, 1),
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
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
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                ),
                children: [
                  TextSpan(
                    text: "email address",
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
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
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
              style: GoogleFonts.openSans(
                fontSize: 16,
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
                      retrieveType = "email";
                      _character = value;
                      email.text = "";
                    });
                  },
                ),
                Text(
                  "My email address",
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
                      retrieveType = "mobile number";
                      _character = value;
                      email.text = "+27 ";
                    });
                  },
                ),
                Text(
                  "My cell phone number",
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
                style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: const Color.fromRGBO(0, 159, 158, 1),
                    decoration: TextDecoration.underline,
                    decorationThickness: 2.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.5,
                    decorationColor: Color.fromRGBO(0, 159, 158, 1)),
              ),
            ),
          ],
        ),
      );
    }
  }
}
