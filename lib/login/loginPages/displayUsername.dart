import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';

class DisplayUsername extends StatefulWidget {
  Function(int) changePage;
  DisplayUsername({super.key, required this.changePage});

  @override
  State<DisplayUsername> createState() => _DisplayUsernameState();
}

class _DisplayUsernameState extends State<DisplayUsername> {
  // Text controllers
  final username = TextEditingController();

  getUserName() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    print(_auth.currentUser!.uid);
    final user = await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();

    if (user != null) {
      setState(() {
        username.text = user.get("practiceNumber");
      });
    }
  }

  @override
  void initState() {
    getUserName();
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
                "SAMA Number Retrieved ",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Your SAMA Number:",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                username.text,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),

              /*  TextFieldStyling(
                hintText: 'SAMA Number',
                textfieldController: username,
              ),*/
              SizedBox(
                height: 15,
              ),
              Text(
                "Please save your SAMA number for future use",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(
                height: 15,
              ),
              StyleButton(
                  description: "Back to Login",
                  height: 55,
                  width: 175,
                  onTap: () {
                    widget.changePage(0);
                  }),
            ]));
  }
}
