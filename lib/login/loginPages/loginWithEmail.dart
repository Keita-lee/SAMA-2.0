import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/Login/popups/validateDialog.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/components/utility.dart';

enum SingingCharacter { memberNumber, email }

class LoginWithEmail extends StatefulWidget {
  Function(int) changePage;
  Function(String) getEmail;
  LoginWithEmail({super.key, required this.changePage, required this.getEmail});

  @override
  State<LoginWithEmail> createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends State<LoginWithEmail> {
  // Text controllers
  final email = TextEditingController();

  BuildContext? dialogContext;

  //Dialog for product form
  Future openValidateDialog() => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: ValidateDialog(
                description: "User does not exist",
                closeDialog: () => Navigator.pop(dialogContext!)));
      });

//Check if email exists and continue
  checkEmail() async {
    widget.getEmail(email.text);
    final users = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email.text)
        .get();

    if (users.docs.length >= 1) {
      for (int i = 0; i < users.docs.length; i++) {}
      widget.changePage(1);
    } else {
      openValidateDialog();
    }
  }

  SingingCharacter? _character = SingingCharacter.memberNumber;
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
          Row(
            children: [
              Radio<SingingCharacter>(
                activeColor: Color.fromARGB(255, 8, 55, 145),
                value: SingingCharacter.memberNumber,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "SAMA member no",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
              SizedBox(
                width: 10,
              ),
              Radio<SingingCharacter>(
                activeColor: Color.fromARGB(255, 8, 55, 145),
                value: SingingCharacter.email,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Email Address",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          TextFieldStyling(
            hintText: 'Enter here',
            textfieldController: email,
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
          GestureDetector(
            onTap: () {
              widget.changePage(9);
            },
            child: Text(
              "Register",
              style: TextStyle(
                  fontSize: 16, color: const Color.fromARGB(255, 8, 55, 145)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          StyleButton(
            description: "Continue",
            height: 55,
            width: 100,
            onTap: () {
              checkEmail();
            },
          )
        ],
      ),
    );
  }
}
