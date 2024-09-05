import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import 'package:sama/Login/popups/validateDialog.dart';
import 'package:sama/components/passwordStrengthMeter.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/components/utility.dart';
import 'package:sama/login/membershipCategory/memberCategory.dart';
import 'package:sama/login/membershipCategory/membershipSignup.dart';

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
            .whenComplete(
              () => widget.changePage(15)

              /*  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Material(child: MembershipSignUp() //MemberCategory(),
                              ))*/
              ,
            )
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
            "Create a Password",
            style: GoogleFonts.openSans(
              textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              color: Color.fromRGBO(0, 159, 158, 1),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Enter password",
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 16,
              ),
              color: Colors.grey[600],
            ),
          ),
          SizedBox(
            width: 15,
          ),
          /*  ProfileTextField(
              isBold: false,
              fontSize: 13,
              description:
                  'Your password should have a minimum of 8 characters, 1 uppercase and 1 special character',
              customSize: MyUtility(context).width,
              textFieldType: 'IntType',
              textfieldController: password),*/
          Container(
            width: MyUtility(context).width,
            height: 45,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                border: Border.all(
                  color: Color.fromARGB(255, 153, 147, 147),
                ),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: TextFormField(
              obscureText: true,
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
                hintText: "",
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
          PasswordStrengthChecker(
            configuration: PasswordStrengthCheckerConfiguration(
              height: 28,
              borderWidth: 0.5,
              inactiveBorderColor: const Color.fromARGB(255, 126, 126, 126),
              externalBorderRadius: BorderRadius.circular(30),
            ),
            strength: passNotifier,
          ),
          SizedBox(height: 20),
          ProfileTextField(
              isPassword: true,
              isBold: false,
              description: 'Confirm Password',
              customSize: MyUtility(context).width,
              textFieldType: 'IntType',
              textfieldController: passwordCheck),
          SizedBox(
            height: 15,
          ),
          StyleButton(
              description: "Create",
              fontSize: 15,
              buttonColor: Color.fromRGBO(24, 69, 126, 1),
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
