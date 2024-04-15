import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/PostLoginLandingPage.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/components/userState.dart';
import 'package:sama/components/utility.dart';
import 'package:sama/login/popups/validateDialog.dart';

class LoginWithPassword extends StatefulWidget {
  Function(int) changePage;
  String? email;
  LoginWithPassword({super.key, required this.changePage, required this.email});

  @override
  State<LoginWithPassword> createState() => _LoginWithPasswordState();
}

class _LoginWithPasswordState extends State<LoginWithPassword> {
  // Text controllers
  final password = TextEditingController();

  BuildContext? dialogContext;

  //Dialog for password Validate
  Future openValidateDialog(description) => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: ValidateDialog(
                description: description,
                closeDialog: () => Navigator.pop(dialogContext!)));
      });

//Sign in witp password and email
  login() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: widget.email!.toString(),
        password: password.text.trim(),
      );
      if (userCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Material(
                    child: Material(
                        child: PostLoginLandingPage(
                            userId: userCredential.user!.uid)),
                  )),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        openValidateDialog('No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        openValidateDialog('Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      } else {
        openValidateDialog('No user found');
      }
    }

/*

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: widget.email!.toString(),
      password: password.text.trim(),
    );

    if (userCredential.user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Material(
                  child: Material(
                      child: PostLoginLandingPage(
                          userId: userCredential.user!.uid)),
                )),
      );
    }*/
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
            "Login",
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Please enter your password to continue",
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          TextFieldStyling(
            hintText: 'Password',
            textfieldController: password,
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              widget.changePage(2);
            },
            child: Text(
              "Forgot Password? Help me",
              style: TextStyle(
                  fontSize: 16, color: const Color.fromARGB(255, 8, 55, 145)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          StyleButton(
            description: "Login",
            height: 55,
            width: 85,
            onTap: () {
              login();
            },
          )
        ],
      ),
    );
  }
}
