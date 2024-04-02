import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/CheckCircle.dart';
import 'package:sama/components/myutility.dart';

class Security extends StatefulWidget {
  Function(int) changePage;
  Security({super.key, required this.changePage});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  @override
  Widget build(BuildContext context) {
    // Text controllers
    final password = TextEditingController();

    // take email and get user details from, firebase
    updatePassword() async {
      final FirebaseAuth _auth = FirebaseAuth.instance;

      _auth.currentUser!
          .updatePassword(password.text)
          .whenComplete(() => widget.changePage(0))
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Update Password',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
        ),
        SizedBox(
          height: MyUtility(context).height * 0.05,
        ),
        Container(
          width: MyUtility(context).width * 0.15,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: TextField(
            controller: password,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ),
        SizedBox(
          height: MyUtility(context).height * 0.05,
        ),
        SizedBox(
          width: MyUtility(context).width / 1.62,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: MyUtility(context).width * 0.05,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF174486),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: MyUtility(context).height * 0.1,
        )
      ],
    );
  }
}
