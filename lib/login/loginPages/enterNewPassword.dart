import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  // take email and get user details from, firebase
  updatePassword() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    //Check if email exists and continue
    final users = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: widget.email)
        .get();
    print(widget.email!);
    print(users.docs[0].get('password'));

//If user exist send link
    if (users.docs.length >= 1) {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: widget.email!, password: users.docs[0].get('password'));

      if (userCredential.user != null) {
        userCredential.user!
            .updatePassword(password.text)
            .whenComplete(() => widget.changePage(0))
            .catchError((e) {
          print(e);
        });
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
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
          TextFieldStyling(
            hintText: 'Password',
            textfieldController: password,
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
          Text(
            "Forgot Password? Help me",
            style: TextStyle(
                fontSize: 16, color: const Color.fromARGB(255, 8, 55, 145)),
          ),
        ],
      ),
    );
  }
}
