import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import 'package:sama/Login/popups/validateDialog.dart';
import 'package:sama/components/passwordStrengthMeter.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/components/utility.dart';

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

  //Dialog for password change
  Future openConfirmPasswordChangeDialog() => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: ValidateDialog(
                description: "Passwords Updated",
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
      print(widget.email);
      //Check if email exists and continue
      final users = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: widget.email)
          .get();

//If user exist send link
      if (users.docs.length >= 1) {
        print(users.docs[0].get('password'));
        final userCredential = await _auth.signInWithEmailAndPassword(
            email: widget.email!, password: users.docs[0].get('password'));

        if (userCredential.user != null) {
          userCredential.user!
              .updatePassword(password.text)
              .whenComplete(() => setState(() {
                    changeEffect = "true";
                  }))
              .catchError((e) {
            print(e);
          });
          FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .update({
            'password': password.text,
          }).then((value) => openConfirmPasswordChangeDialog());
        }
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
            "Reset Password",
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Thank you, validation succesful.",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Please enter your new password",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(
            height: 30,
          ),
          /* TextFieldStyling(
            hintText: 'Password',
            textfieldController: password,
          ),*/
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
            height: 15,
          ),
          TextFieldStyling(
            hintText: 'Confirm Password',
            textfieldController: passwordCheck,
          ),
          SizedBox(
            height: 15,
          ),
          PasswordStrengthChecker(
            strength: passNotifier,
          ),
          SizedBox(
            height: 50,
          ),
          StyleButton(
            description: "Reset",
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
