import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/Login/popups/validateDialog.dart';
import 'package:sama/components/email/sendOtp.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/components/utility.dart';
import 'package:sama/login/loginPages.dart';
import 'package:sama/utils/oracleDbManager.dart';

import 'package:sama/components/mobile/components/Themes/font_text.dart';
import '../../components/mobile/Navbar/footer.dart';
import '../../components/mobile/Navbar/navbar.dart';

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
      // check if user exist in firebase and is Admin
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email.text)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        if (userSnapshot.docs.first['userType'] == 'Admin') {
          //Mobile OTP send
          if (_character == SingingCharacter.mobile) {
            // redirect to ValidateByMobileOtp screen to validate otp
            widget.changePage(3);
          } else {
            widget.getEmail(email.text);
            String randomOtp =
                Random().nextInt(999999).toString().padLeft(6, '0');
            await sendOtp(otp: randomOtp, email: email.text);
            // redirect to ValidateByEmailOtp screen to validate otp
            widget.changePage(14);
          }
          setState(() {
            isLoading = false;
          });
        }
        return;
      }

      final OracleDbManager oracleDbManager = OracleDbManager();

      // check if sama number is on oracle db
      Map<String, dynamic> memberData =
          await oracleDbManager.checkSamaNo(email.text);
      final data = memberData['items'].first;
      // sama number found on oracle db
      if (memberData.isNotEmpty) {
        widget.getEmailChangeType("passwordResetPage");
        final oracelEmail = data['email_sama'];
        widget.getEmail(oracelEmail);

        // check if user exist
        final user = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: oracelEmail)
            .get();

        if (user.docs.isNotEmpty) {
          //Mobile OTP send
          if (_character == SingingCharacter.mobile) {
            // redirect to ValidateByMobileOtp screen to validate otp
            widget.changePage(3);
          } else {
            String randomOtp =
                Random().nextInt(999999).toString().padLeft(6, '0');
            await sendOtp(
                otp: randomOtp, email: memberData['items'][0]['email_sama']);
            // redirect to ValidateByEmailOtp screen to validate otp
            widget.changePage(14);
          }
          setState(() {
            isLoading = false;
          });
        } else {
          // redirect to create sama account screen
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
      }
      // sama number not found on oracle db
      else {
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
                    'Password Reset',
                    style: FontText(context).mediumBlue,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MyUtility(context).width - 10,
                    child: TextFieldStyling(
                      hintText:
                          'Enter your SAMA number to receive a one time pin',
                      textfieldController: email,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
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
                    ],
                  ),
                  const SizedBox(height: 20),
                  StyleButton(
                    waiting: isLoading,
                    description: "SEND OTP",
                    height: 55,
                    width: 145,
                    onTap: () {
                      checkEmail();
                    },
                  ),
                  const SizedBox(height: 30),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Need help?\n\n',
                          style: FontText(context).bodyMediumBlack,
                        ),
                        TextSpan(
                          text: 'Help me retrieve my SAMA password\n\n',
                          style: FontText(context).linksBlue.copyWith(
                                fontSize: MyUtility(context).width / 25,
                              ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              widget.changePage(11);
                            },
                        ),
                        TextSpan(
                          text: 'Return to login\n\n',
                          style: FontText(context).linksBlue.copyWith(
                                fontSize: MyUtility(context).width / 25,
                              ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              widget.changePage(0);
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Footer(),
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
}
