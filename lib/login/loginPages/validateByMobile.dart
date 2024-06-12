import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    FirebaseAuth auth = FirebaseAuth.instance;

    confirmationResult = await auth.signInWithPhoneNumber(number);
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
      sendSmsForOtp(users.docs[0]['mobileNo']);
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
        width: MyUtility(context).width / 3,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Validate by Mobile",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              SizedBox(
                height: 30,
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
                height: 30,
              ),
              TextFieldStyling(
                hintText: 'Add OTP',
                textfieldController: otp,
              ),
              /*  SizedBox(
                height: 15,
              ),
              Text(
                "Your OTP has expired, please request a new OTP",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),*/
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
