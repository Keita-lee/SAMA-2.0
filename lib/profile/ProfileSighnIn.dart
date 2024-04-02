import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/userState.dart';
import 'package:sama/profile/EditProfile.dart';
import 'package:sama/profile/MyPreferences.dart';
import 'package:sama/profile/Notifications.dart';
import 'package:sama/profile/Security.dart';
import 'package:sama/components/TextField3.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/textfield2.dart';

class ProfileSighnIn extends StatefulWidget {
  const ProfileSighnIn({super.key});

  @override
  State<ProfileSighnIn> createState() => _ProfileSighnInState();
}

class _ProfileSighnInState extends State<ProfileSighnIn> {
  var pageIndex = 0;
  String title = "";
  String email = "";
  String mobileNo = "";
  String fullName = "";

  getUserData() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (data.exists) {
      setState(() {
        title = data.get('title');
        email = data.get('email');
        fullName = data.get('firstName') + " " + data.get('lastName');
        mobileNo = data.get('mobileNo');
      });
    }
  }

// logUserOut
  logOut() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserState()),
    );
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Change pageIndex value
    changePage(value) {
      setState(() {
        pageIndex = value;
      });
    }

    var pages = [
      EditProfile(),
      Notifications(),
      MyPreferences(),
      Security(changePage: changePage)
    ];

    return Column(
      children: [
        SizedBox(
          height: MyUtility(context).height * 0.2,
          child: SizedBox(
            width: MyUtility(context).width / 1.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 62.5,
                      backgroundImage: AssetImage('images/coffee.jpg'),
                    ),
                  ],
                ),
                SizedBox(
                  width: MyUtility(context).width * 0.01,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: MyUtility(context).height * 0.15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${title}. ${fullName}',
                            style: TextStyle(
                                fontSize: 24,
                                color: Color(0xFF174486),
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            'Email: ${email}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF6A6A6A),
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            'Contact no: ${mobileNo}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF6A6A6A),
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MyUtility(context).width * 0.25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Your profile is Public',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF6A6A6A),
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      'Member since 2018 (good standing)',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF6A6A6A),
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      'Private Practice Medical Practitioners',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF6A6A6A),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: MyUtility(context).width / 1.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Everyone can see your picture Change',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF6A6A6A),
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: MyUtility(context).height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Container(
                              color: Color(0xFFEFEFEF),
                              width: MyUtility(context).width * 0.1,
                              height: MyUtility(context).height * 0.05,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Icon(Icons.fiber_manual_record,
                                        size: 8),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      changePage(0);
                                    },
                                    child: Text(
                                      'Edit Profile',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Container(
                              color: Color(0xFFEFEFEF),
                              width: MyUtility(context).width * 0.1,
                              height: MyUtility(context).height * 0.05,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Icon(Icons.fiber_manual_record,
                                        size: 8),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      changePage(1);
                                    },
                                    child: Text(
                                      'Notifications',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Container(
                              color: Color(0xFFEFEFEF),
                              width: MyUtility(context).width * 0.1,
                              height: MyUtility(context).height * 0.05,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Icon(Icons.fiber_manual_record,
                                        size: 8),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      changePage(2);
                                    },
                                    child: Text(
                                      'My Preferences',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Container(
                              color: Color(0xFFEFEFEF),
                              width: MyUtility(context).width * 0.1,
                              height: MyUtility(context).height * 0.05,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Icon(Icons.fiber_manual_record,
                                        size: 8),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      changePage(3);
                                    },
                                    child: Text(
                                      'Security',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Container(
                              color: Color(0xFFEFEFEF),
                              width: MyUtility(context).width * 0.1,
                              height: MyUtility(context).height * 0.05,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Icon(Icons.fiber_manual_record,
                                        size: 8),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      logOut();
                                    },
                                    child: Text(
                                      'Logout',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MyUtility(context).width * 0.015,
                      ),
                      Center(
                        child: pages[pageIndex],
                      )
                      //*Notifications()*/
                      /*MyPreferences()*/
                      /*Security()*/
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
