import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sama/components/userState.dart';
import 'package:sama/profile/EditProfile.dart';
import 'package:sama/profile/MyPreferences.dart';
import 'package:sama/profile/Notifications.dart';
import 'package:sama/profile/Security.dart';

import 'package:sama/components/myutility.dart';

import 'package:sama/profile/logoutPopup.dart';
import 'package:uuid/uuid.dart';

class ProfileSighnIn extends StatefulWidget {
  String profileImage;
  ProfileSighnIn({super.key, required this.profileImage});

  @override
  State<ProfileSighnIn> createState() => _ProfileSighnInState();
}

class _ProfileSighnInState extends State<ProfileSighnIn> {
  var pageIndex = 0;
  String title = "";
  String email = "";
  String mobileNo = "";
  String fullName = "";
  String profileUrl = "";
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
        profileUrl = data.get('profilePic');
      });
    }
  }

  BuildContext? dialogContext;
  //Dialog for logout
  Future openLogoutDialog() => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child:
                LogoutPopup(closeDialog: () => Navigator.pop(dialogContext!)));
      });

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

    changeProfilePic() {}

    Uint8List webImage = Uint8List(8);
    String imageUrl = '';
    UploadFile() async {
      var uuid = Uuid();
      final ref = FirebaseStorage.instance
          .ref()
          .child('images')
          .child("${uuid.v1()}.png");
      await ref.putData(webImage);
      imageUrl = await ref.getDownloadURL();
      final String newImage = imageUrl.toString();
      // widget.setUrl(newImage);
      setState(() {
        imageUrl = newImage;
        profileUrl = newImage;

        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({"profilePic": newImage});
      });
    }

    Future<void> _pickImageGallery() async {
      setState(() {
        // widget.networkImageUrl = "";
      });
      if (kIsWeb) {
        final ImagePicker _picker = ImagePicker();
        XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          var f = await image.readAsBytes();
          setState(() {
            webImage = f;
            UploadFile();
            print('web Img success');
          });
        } else {
          print('no Image has been picked');
        }
      } else {
        print('Something went wrong');
      }
      //Navigator.pop(context);
    }

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
                      //  backgroundImage: "",
                    ), /*AssetImage('images/coffee.jpg')*/
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
                        //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${title}. ${fullName}',
                            style: TextStyle(
                                fontSize: 24,
                                color: Color(0xFF174486),
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Email: ${email}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF6A6A6A),
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 10,
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
                  width: MyUtility(context).width * 0.3,
                ),
                Column(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Your profile is Public',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF6A6A6A),
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Member since 2018 (good standing)',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF6A6A6A),
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
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
                  GestureDetector(
                    onTap: () {
                      _pickImageGallery();
                    },
                    child: Text(
                      'Everyone can see your picture Change',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF6A6A6A),
                          fontWeight: FontWeight.normal),
                    ),
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
                                  TextButton(
                                    onPressed: () {
                                      changePage(0);
                                    },
                                    child: Text(
                                      'Edit Profile',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Spacer(),
                                  Visibility(
                                    visible: pageIndex == 0 ? true : false,
                                    child: Container(
                                      width: 4,
                                      height: MyUtility(context).height * 0.05,
                                      color: Colors.amber,
                                    ),
                                  )
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
                                  TextButton(
                                    onPressed: () {
                                      changePage(1);
                                    },
                                    child: Text(
                                      'Notifications',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Spacer(),
                                  Visibility(
                                    visible: pageIndex == 1 ? true : false,
                                    child: Container(
                                      width: 4,
                                      height: MyUtility(context).height * 0.05,
                                      color: Colors.amber,
                                    ),
                                  )
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
                                  TextButton(
                                    onPressed: () {
                                      changePage(2);
                                    },
                                    child: Text(
                                      'My Preferences',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Spacer(),
                                  Visibility(
                                    visible: pageIndex == 2 ? true : false,
                                    child: Container(
                                      width: 4,
                                      height: MyUtility(context).height * 0.05,
                                      color: Colors.amber,
                                    ),
                                  )
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
                                  TextButton(
                                    onPressed: () {
                                      changePage(3);
                                    },
                                    child: Text(
                                      'Security',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Spacer(),
                                  Visibility(
                                    visible: pageIndex == 3 ? true : false,
                                    child: Container(
                                      width: 4,
                                      height: MyUtility(context).height * 0.05,
                                      color: Colors.amber,
                                    ),
                                  )
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
                                  TextButton(
                                    onPressed: () {
                                      openLogoutDialog();
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
