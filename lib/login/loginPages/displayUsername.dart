import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';

class DisplayUsername extends StatefulWidget {
  Function(int) changePage;
  String? mobileNumber;
  DisplayUsername(
      {super.key, required this.changePage, required this.mobileNumber});

  @override
  State<DisplayUsername> createState() => _DisplayUsernameState();
}

class _DisplayUsernameState extends State<DisplayUsername> {
  // Text controllers
  final username = TextEditingController();

  getUserName() async {
    if (widget.mobileNumber != "") {
      final users = await FirebaseFirestore.instance
          .collection('users')
          .where('mobileNo', isEqualTo: widget.mobileNumber)
          .get();

//If user change page
      if (users.docs.length >= 1) {
        setState(() {
          username.text = users.docs[0].get("practiceNumber");
        });
      }
    } else {
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
  }

  @override
  void initState() {
    getUserName();
    super.initState();
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
                "Retrieved my SAMA Number ",
                style: GoogleFonts.openSans(
                  fontSize: 22,
                  color: Color.fromRGBO(0, 159, 158, 1),
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Thank you, Your SAMA number has been sent to your email address.",
                style: GoogleFonts.openSans(
                  fontSize: 17,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              /*Text(
                username.text,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),*/

              /*  TextFieldStyling(
                hintText: 'SAMA Number',
                textfieldController: username,
              ),
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
                  }),*/
              InkWell(
                onTap: () {
                  widget.changePage(0);
                },
                child: Text(
                  "Return to Login",
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: const Color.fromRGBO(0, 159, 158, 1),
                    decoration: TextDecoration.underline,
                    decorationColor: Color.fromRGBO(0, 159, 158, 1),
                    decorationThickness: 2.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ]));
  }
}
