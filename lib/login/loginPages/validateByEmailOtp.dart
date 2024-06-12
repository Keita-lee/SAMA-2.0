import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/Login/popups/validateDialog.dart';
import 'package:sama/components/email/sendSAMANumber.dart';
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
        width: MyUtility(context).width / 3,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Validate by Email Otp",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Please check your email for an OTP pin",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(
                height: 30,
              ),
              TextFieldStyling(
                hintText: 'Add OTP',
                textfieldController: otp,
              ),
              SizedBox(
                height: 15,
              ),
              StyleButton(
                description: "Validate",
                height: 55,
                width: 100,
                onTap: () {
                  validate();
                },
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                messageText,
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
                  OpenContructionPopup();
                },
                child: Text(
                  "Need help? CONTACT SAMA",
                  style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 8, 55, 145)),
                ),
              ),
            ]));
  }
}
