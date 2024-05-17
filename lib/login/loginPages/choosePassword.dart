import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import 'package:sama/Login/popups/validateDialog.dart';
import 'package:sama/components/passwordStrengthMeter.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/components/utility.dart';
import 'package:sama/login/membershipCategory/memberCategory.dart';

class ChoosePassword extends StatefulWidget {
  Function(int) changePage;

  ChoosePassword({super.key, required this.changePage});

  @override
  State<ChoosePassword> createState() => _ChoosePasswordState();
}

class _ChoosePasswordState extends State<ChoosePassword> {
  // Text controllers
  final password = TextEditingController();
  final passwordCheck = TextEditingController();
  final passNotifier = ValueNotifier<CustomPassStrength?>(null);

//var
  String passwordMatch = "";

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

      if (_auth.currentUser != null) {
        _auth.currentUser!
            .updatePassword(password.text)
            .whenComplete(() => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Material(
                            child: MemberCategory(),
                          )),
                ))
            .catchError((e) {
          print(e);
        });
        FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({
          'password': password.text,
        });
      }
    }
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
            "Confirm Password",
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Password",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: MyUtility(context).width,
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
                hintText: "Enter Here",
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
          TextFieldStyling(
            hintText: 'Confirm Password',
            textfieldController: passwordCheck,
          ),
          SizedBox(height: 20),
          PasswordStrengthChecker(
            strength: passNotifier,
          ),
          SizedBox(
            height: 15,
          ),
          StyleButton(
              description: "Submit & Login",
              height: 55,
              width: 125,
              onTap: () {
                updatePassword();
              }),
          SizedBox(
            height: 15,
          ),
          /*   GestureDetector(
            onTap: () {
              widget.changePage(0);
            },
            child: Text(
              "Back to Login",
              style: TextStyle(
                  fontSize: 16, color: const Color.fromARGB(255, 8, 55, 145)),
            ),
          ),
     */
        ],
      ),
    );
  }
}
