import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/centerOfExcellence/CenterOfExcellenceDialog.dart';
import 'package:sama/components/CheckCircle.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/login/popups/validateDialog.dart';

enum SingingCharacter { everyone, member, private }

class MyPreferences extends StatefulWidget {
  String profilePicView;
  String profileView;
  MyPreferences(
      {super.key, required this.profilePicView, required this.profileView});

  @override
  State<MyPreferences> createState() => _MyPreferencesState();
}

class _MyPreferencesState extends State<MyPreferences> {
  String profilePicView = "";
  String profileView = "";

  SingingCharacter? _characterProfile = SingingCharacter.everyone;
  SingingCharacter? _characterProfilePic = SingingCharacter.everyone;

  BuildContext? dialogContext;
  //Dialog for profile Save
  Future openUserCheckDialog() => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: ValidateDialog(
                description: "User Data Saved",
                closeDialog: () => Navigator.pop(dialogContext!)));
      });

  updateProfile() {
    if (_characterProfile == SingingCharacter.everyone) {
      setState(() {
        profileView = "Everyone";
      });
    } else if (_characterProfile == SingingCharacter.member) {
      setState(() {
        profileView = "Member";
      });
    } else if (_characterProfile == SingingCharacter.private) {
      setState(() {
        profileView = "Private";
      });
    }

    if (_characterProfilePic == SingingCharacter.everyone) {
      setState(() {
        profilePicView = "Everyone";
      });
    } else if (_characterProfilePic == SingingCharacter.member) {
      setState(() {
        profilePicView = "Member";
      });
    } else if (_characterProfilePic == SingingCharacter.private) {
      setState(() {
        profilePicView = "Private";
      });
    }
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "profilePicView": profilePicView,
      "profileView": profileView
    }).whenComplete(() => openUserCheckDialog());
  }

  @override
  void initState() {
    //TODO code beter
    if (widget.profilePicView == "Everyone") {
      _characterProfile = SingingCharacter.everyone;
    } else if (widget.profilePicView == "Member") {
      _characterProfile = SingingCharacter.member;
    } else if (widget.profilePicView == "Private") {
      _characterProfile = SingingCharacter.private;
    }

    if (widget.profileView == "Everyone") {
      _characterProfilePic = SingingCharacter.everyone;
    } else if (widget.profileView == "Member") {
      _characterProfilePic = SingingCharacter.member;
    } else if (widget.profileView == "Private") {
      _characterProfilePic = SingingCharacter.private;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Preferences',
          style: TextStyle(
              fontSize: 26,
              color: Color(0xFF174486),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: MyUtility(context).height * 0.05,
        ),
        Text(
          'Your Profile',
          style: TextStyle(
              fontSize: 22,
              color: Color(0xFF174486),
              fontWeight: FontWeight.normal),
        ),
        SizedBox(
          height: MyUtility(context).height * 0.05,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'Who can see your profile?',
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF6A6A6A),
                fontWeight: FontWeight.normal),
          ),
        ),
        Row(
          children: [
            Radio<SingingCharacter>(
              activeColor: Color.fromARGB(255, 8, 55, 145),
              value: SingingCharacter.everyone,
              groupValue: _characterProfile,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _characterProfile = value;
                });
              },
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Everyone (Public)",
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ],
        ),
        Row(
          children: [
            Radio<SingingCharacter>(
              activeColor: Color.fromARGB(255, 8, 55, 145),
              value: SingingCharacter.member,
              groupValue: _characterProfile,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _characterProfile = value;
                });
              },
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Members Only",
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ],
        ),
        Row(
          children: [
            Radio<SingingCharacter>(
              activeColor: Color.fromARGB(255, 8, 55, 145),
              value: SingingCharacter.private,
              groupValue: _characterProfile,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _characterProfile = value;
                });
              },
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Private",
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ],
        ),
        /* CheckCircle(name: "Everyone (Public)"),
        CheckCircle(name: "Members Only"),
        CheckCircle(name: "Private"),*/
        SizedBox(
          height: MyUtility(context).height * 0.05,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'Who can see your profile picture?',
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF6A6A6A),
                fontWeight: FontWeight.normal),
          ),
        ),
        Row(
          children: [
            Radio<SingingCharacter>(
              activeColor: Color.fromARGB(255, 8, 55, 145),
              value: SingingCharacter.everyone,
              groupValue: _characterProfilePic,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _characterProfilePic = value;
                });
              },
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Everyone (Public)",
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ],
        ),
        Row(
          children: [
            Radio<SingingCharacter>(
              activeColor: Color.fromARGB(255, 8, 55, 145),
              value: SingingCharacter.member,
              groupValue: _characterProfilePic,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _characterProfilePic = value;
                });
              },
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Members Only",
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ],
        ),
        Row(
          children: [
            Radio<SingingCharacter>(
              activeColor: Color.fromARGB(255, 8, 55, 145),
              value: SingingCharacter.private,
              groupValue: _characterProfilePic,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _characterProfilePic = value;
                });
              },
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Private",
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ],
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
                onPressed: () {
                  updateProfile();
                },
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
