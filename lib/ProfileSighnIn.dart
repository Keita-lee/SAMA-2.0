import 'package:flutter/material.dart';
import 'package:sama/EditProfile.dart';
import 'package:sama/MyPreferences.dart';
import 'package:sama/Notifications.dart';
import 'package:sama/Security.dart';
import 'package:sama/components/TextField3.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/textfield2.dart';

class ProfileSighnIn extends StatefulWidget {
  const ProfileSighnIn({super.key});

  @override
  State<ProfileSighnIn> createState() => _ProfileSighnInState();
}

class _ProfileSighnInState extends State<ProfileSighnIn> {
  @override
  Widget build(BuildContext context) {
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
                            'Dr. Robbert Naidoo',
                            style: TextStyle(
                                fontSize: 24,
                                color: Color(0xFF174486),
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            'Email: r.naidoo_fake@gmail.com',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF6A6A6A),
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            'Contact no: 082 123-4567',
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
                                    onPressed: () {},
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
                                    onPressed: () {},
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
                                    onPressed: () {},
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
                                    onPressed: () {},
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
                                    onPressed: () {},
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
                      EditProfile()
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
