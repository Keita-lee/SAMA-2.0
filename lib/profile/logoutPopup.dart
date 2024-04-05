import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/userState.dart';
import 'package:sama/login/loginPages.dart';

class LogoutPopup extends StatefulWidget {
  Function? closeDialog;
  LogoutPopup({super.key, required this.closeDialog});

  @override
  State<LogoutPopup> createState() => _LogoutPopupState();
}

class _LogoutPopupState extends State<LogoutPopup> {
// logUserOut
  logOut() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Material(
                child: LoginPages(),
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 315,
      height: 185,
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () {
                  widget.closeDialog!();
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "X",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Are you sure you want to logout?",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StyleButton(
                  description: "Yes",
                  height: 45,
                  width: 125,
                  onTap: () {
                    logOut();
                  }),
              SizedBox(
                width: 8,
              ),
              StyleButton(
                  description: "No",
                  height: 45,
                  width: 125,
                  onTap: () {
                    widget.closeDialog!();
                  })
            ],
          )
        ],
      ),
    );
  }
}
