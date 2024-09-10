import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/Login/popups/validateDialog.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';

import 'package:sama/components/utility.dart';

class ValidateByMobileOtp extends StatefulWidget {
  String? email;
  String? validationType;
  Function(int) changePage;
  ValidateByMobileOtp({
    super.key,
    required this.email,
    required this.changePage,
  });

  @override
  State<ValidateByMobileOtp> createState() => _ValidateByMobileOtpState();
}

class _ValidateByMobileOtpState extends State<ValidateByMobileOtp> {
  // Text controllers
  final otp = TextEditingController();
  //var
  late ConfirmationResult confirmationResult;
  late UserCredential userCredential;

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

//Send sms for otp
  sendSmsForOtp(number) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      confirmationResult = await auth.signInWithPhoneNumber(number);
    } catch (e) {
      print('error sending sms $e');
    }
  }

//Check if otp valid
  validate() async {
    await confirmationResult
        .confirm(otp.text)
        .then((value) => {
              widget.changePage(5),
            })
        .catchError((e) => {openValidateDialog()});
  }

// take email and get user details from, firebase
  getUserData() async {
    //Check if email exists and continue
    final users = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: ((widget.email!).toLowerCase()))
        .get();

    //If user exist send link
    if (users.docs.length >= 1) {
      final phoneNumber = users.docs[0]['mobileNo'];
      print('sending OTP... ${phoneNumber}');
      sendSmsForOtp(phoneNumber);
    }
  }

  @override
  void initState() {
    // sendSmsForOtp();
    getUserData();
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
                "Password Reset",
                style: GoogleFonts.openSans(
                  fontSize: 22,
                  color: Color.fromRGBO(0, 159, 158, 1),
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text.rich(
                TextSpan(
                  text: "Enter ",
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
                      text: " sent to your phone number ",
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
              /*     Text(
                "An OTP has been sent to 0821234567.",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
              Text(
                "Please add the OTP to continue.",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Wrong cellphone number? Re-enter",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),*/
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MyUtility(context).width * 0.3,
                    child: TextFieldStyling(
                      hintText: 'Add OTP',
                      textfieldController: otp,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: StyleButton(
                      description: "Validate",
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
                height: 10,
              ),
              Text('Did not get an OTP?',
                  style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: -0.5,
                      fontSize: 16)),
              SizedBox(
                height: 5,
              ),
              /*Text(
                "Your OTP has expired, please request a new OTP",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),*/

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
              GestureDetector(
                onTap: () {
                  widget.changePage(0);
                },
                child: Text(
                  "Return to login",
                  style: GoogleFonts.openSans(
                    decoration: TextDecoration.underline,
                    decorationThickness: 2.0,
                    decorationColor: Color.fromRGBO(0, 159, 158, 1),
                    fontSize: 16,
                    color: const Color.fromRGBO(0, 159, 158, 1),
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              /*InkWell(
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
