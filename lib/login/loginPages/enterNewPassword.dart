import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import 'package:sama/Login/popups/validateDialog.dart';
import 'package:sama/components/passwordStrengthMeter.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/components/utility.dart';
import 'package:http/http.dart' as http;
import 'package:sama/login/loginPages.dart';
import 'package:sama/utils/tokenManager.dart';

class EnterNewPassword extends StatefulWidget {
  String? email;
  Function(int) changePage;
  EnterNewPassword({super.key, required this.email, required this.changePage});

  @override
  State<EnterNewPassword> createState() => _EnterNewPasswordState();
}

class _EnterNewPasswordState extends State<EnterNewPassword> {
  // Text controllers
  final password = TextEditingController();
  final passwordCheck = TextEditingController();
  final passNotifier = ValueNotifier<CustomPassStrength?>(null);
  String changeEffect = "";

  BuildContext? dialogContext;
  //Dialog for password Validate
  Future openValidateDialog() => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: ValidateDialog(
                description: "Password not Strong Enough",
                closeDialog: () => Navigator.pop(dialogContext!)));
      });

  Future openErrorDialog() => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: ValidateDialog(
                description: "Error reseting password. Please try again.",
                closeDialog: () => Navigator.pop(dialogContext!)));
      });

  //Dialog for password change
  Future openConfirmPasswordChangeDialog() => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
          child: ValidateDialog(
            description: "Passwords Updated",
            closeDialog: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Material(
                    child: LoginPages(
                      pageIndex: 0,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      });

  //Dialog for password match check
  Future openValidatePasswordMatchDialog() => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: ValidateDialog(
                description: "Passwords do not match",
                closeDialog: () => Navigator.pop(dialogContext!)));
      });

  // take email and get user details from, firebase
  updatePassword() async {
    if (password.text != passwordCheck.text) {
      return openValidatePasswordMatchDialog();
    }

    if (passNotifier.value == CustomPassStrength.weak) {
      openValidateDialog();
    } else {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      print(widget.email);
      //Check if email exists and continue
      final users = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: widget.email)
          .get();

      //If user exist send link
      if (users.docs.isNotEmpty) {
        final TokenManager tokenManager = TokenManager();
        String basicAuth = tokenManager.basicAuth();
        // Define the URL of your API
        final url = Uri.parse('https://sama-api.onrender.com/reset-password');
        // Prepare the body fields
        final body = jsonEncode({
          "uid": users.docs.first.data()['id'],
          "newPassword": password.text
        });

        var response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': basicAuth,
          },
          body: body,
        );

        if (response.statusCode == 200) {
          openConfirmPasswordChangeDialog();
        } else {
          openErrorDialog();
        }
        // final userCredential = await _auth.signInWithEmailAndPassword(
        //     email: widget.email!, password: users.docs[0].get('password'));

        // if (userCredential.user != null) {
        //   userCredential.user!
        //       .updatePassword(password.text)
        //       .whenComplete(() => setState(() {
        //             changeEffect = "true";
        //           }))
        //       .catchError((e) {
        //     print(e);
        //   });
        //   FirebaseFirestore.instance
        //       .collection('users')
        //       .doc(userCredential.user!.uid)
        //       .update({
        //     'password': password.text,
        //   }).then((value) => openConfirmPasswordChangeDialog());
        // }
      } else {
        openErrorDialog();
      }
    }
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
            "Create New Password",
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
          Text(
            "Enter new password",
            style: TextStyle(
              fontSize: 16.5,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            "Your passsword should have a minimum of 8 characters, 1 uppercase letter and 1 special character",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          /* TextFieldStyling(
            hintText: 'Password',
            textfieldController: password,
          ),*/
          Container(
            width: MyUtility(context).width * 0.3,
            height: 45,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                border: Border.all(
                  color: const Color.fromARGB(255, 51, 51, 51),
                ),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: TextFormField(
              controller: password,
              style: TextStyle(
                color: Color.fromARGB(255, 153, 147, 147),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              onChanged: (value) {
                passNotifier.value = CustomPassStrength.calculate(text: value);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Password",
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 199, 199, 199),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: MyUtility(context).width * 0.3,
            child: PasswordStrengthChecker(
              strength: passNotifier,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Confirm password",
            style: GoogleFonts.openSans(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MyUtility(context).width * 0.3,
            child: TextFieldStyling(
              hintText: 'Confirm Password',
              textfieldController: passwordCheck,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          StyleButton(
            description: "RESET",
            height: 55,
            width: 85,
            onTap: () {
              updatePassword();
            },
          ),
          SizedBox(
            height: 15,
          ),
          Visibility(
            visible: changeEffect == "" ? false : true,
            child: StyleButton(
                description: "Back to Login",
                height: 55,
                width: 130,
                onTap: () {
                  widget.changePage(0);
                }),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
