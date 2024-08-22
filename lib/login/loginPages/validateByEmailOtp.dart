import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/Login/popups/validateDialog.dart';
import 'package:sama/components/email/sendSAMANumber.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';

import 'package:sama/components/utility.dart';

class ValidateByEmailOtp extends StatefulWidget {
  String? email;
  Function(int) changePage;
  String? emailChangeType;

  ValidateByEmailOtp(
      {super.key,
      required this.email,
      required this.changePage,
      required this.emailChangeType});

  @override
  State<ValidateByEmailOtp> createState() => _ValidateByEmailOtpState();
}

class _ValidateByEmailOtpState extends State<ValidateByEmailOtp> {
  // Text controllers
  final otp = TextEditingController();
  String correctOtp = "";
  String samaNumber = "";
  String messageText = "";

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
  //Dialog for wrong otp
  Future openValidateDialog() => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: ValidateDialog(
                description: "Incorrect Otp",
                closeDialog: () => Navigator.pop(dialogContext!)));
      });

// take email and get user details from, firebase
  getUserData() async {
    //Check if email exists and continue
    final validationList =
        await FirebaseFirestore.instance.collection('validateEmailOtp').get();

    for (var i = 0; i < validationList.docs.length; i++) {
      if (validationList.docs[i]['email'] == ((widget.email!).toLowerCase())) {
        setState(() {
          print(validationList.docs[i]['email']);
          correctOtp = validationList.docs[i]['otpCode'];
        });
      }
    }
  }

//retrive sama number from db
  getSamaNumber() async {
    //Check if email exists and continue
    final userList = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: ((widget.email!).toLowerCase()))
        .get();

    //If user exist get data
    if (userList.docs.length >= 1) {
      setState(() {
        print("sama");
        print(userList.docs[0]['practiceNumber']);
        samaNumber = userList.docs[0]['practiceNumber'];
      });
    }
  }

//Validate otp and continue to reset password
  validate() {
    if (correctOtp == otp.text) {
//success
      if (widget.emailChangeType == "passwordResetPage") {
        widget.changePage(5); // reset password
      } else if (widget.emailChangeType == "usernamePage") {
        sendSamaNumber(
            samaNumber: samaNumber, email: ((widget.email!).toLowerCase()));
        setState(() {
          messageText = "Please check your email for SAMA number";
        });
      } else if (widget.emailChangeType == 'registerPage') {
        widget.changePage(10); // new password
      }
    } else {
      openValidateDialog();
    }
  }

  @override
  void initState() {
    // sendSmsForOtp();
    getUserData();
    if (widget.emailChangeType == "usernamePage") {
      getSamaNumber();
    }
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
                "Validate your email address",
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
              Text.rich(
                TextSpan(
                  text: "A ",
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.5,
                  ),
                  children: [
                    TextSpan(
                      text: "one time pin",
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: -0.5,
                      ),
                    ),
                    TextSpan(
                      text:
                          " has been sent sent to your email address, please enter it here ",
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
                height: 5,
              ),
              Row(
                children: [
                  ProfileTextField(
                      customSize: MyUtility(context).width * 0.3,
                      textFieldType: 'intType',
                      textfieldController: otp),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: StyleButton(
                      fontSize: 12,
                      buttonColor: Color.fromRGBO(24, 69, 126, 1),
                      description: "VALIDATE",
                      height: 55,
                      width: 100,
                      onTap: () {
                        validate();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                messageText,
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
              Text('Did not get an OTP?',
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: -0.5,
                  )),
              SizedBox(
                height: 5,
              ),
              Text(
                'Please allow a few minutes for this to be sent',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                ),
              ),
              Row(
                children: [
                  Text(
                    'if no OTP received after a few minutes ',
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      OpenContructionPopup();
                    },
                    child: Text(
                      "click to retry",
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: const Color.fromRGBO(0, 159, 158, 1),
                        decoration: TextDecoration.underline,
                        decorationThickness: 2.0,
                        decorationColor: Color.fromRGBO(0, 159, 158, 1),
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
             /* GestureDetector(
                onTap: () {
                  widget.changePage(0);
                },
                child: Text(
                  "Return to login",
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: const Color.fromRGBO(0, 159, 158, 1),
                    decoration: TextDecoration.underline,
                    decorationThickness: 2.0,
                    decorationColor: Color.fromRGBO(0, 159, 158, 1),
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  OpenContructionPopup();
                },
                child: Text(
                  "Need help? CONTACT SAMA",
                  style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 8, 55, 145)),
                ),
              ),*/
            ]));
  }
}
