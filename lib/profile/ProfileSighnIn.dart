import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/profile/EditProfile.dart';
import 'package:sama/profile/MyPreferences.dart';
import 'package:sama/profile/Notifications.dart';
import 'package:sama/profile/Security.dart';

import 'package:sama/components/myutility.dart';

import 'package:sama/profile/logoutPopup.dart';
import 'package:sama/profile/profileHome.dart';
import 'package:sama/profile/ui/profile_button.dart';
import 'package:uuid/uuid.dart';

import 'bio.dart';

class ProfileSighnIn extends StatefulWidget {
  String profileImage;
  ProfileSighnIn({super.key, required this.profileImage});

  @override
  State<ProfileSighnIn> createState() => _ProfileSighnInState();
}

class _ProfileSighnInState extends State<ProfileSighnIn> {
  String imageUrl = '';
  var pageIndex = 0;
  String title = "";
  String email = "";
  String mobileNo = "";
  String fullName = "";
  String profileUrl = "";
  String profileView = "";
  String profilePicView = "";
  String membership = "";
  String status = "";

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
        imageUrl = data.get('profilePic');
        profileView = data.get('profileView');
        profilePicView = data.get('profilePicView');
        membership = data.get('prodCatCde');
        status = data.get('status');
        print(data.get('profilePic'));
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
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;

    //Change pageIndex value
    changePage(value) {
      setState(() {
        pageIndex = value;
      });
    }

    var pages = [
      ProfileHome(),
      EditProfile(),
      Bio(),
      // Notifications(),
      // MyPreferences(profilePicView: profilePicView, profileView: profileView),
      Security(changePage: changePage)
    ];

    Uint8List webImage = Uint8List(8);

    UploadFile(fileType) async {
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
        imageUrl = "";
      });
      if (kIsWeb) {
        final ImagePicker _picker = ImagePicker();
        XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          var f = await image.readAsBytes();
          setState(() {
            webImage = f;
            UploadFile(image.mimeType);
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

    if (isMobile) {
      return Container(
        color: Colors.white,
        height: MyUtility(context).height / 1.15,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Your Profile",
                  style: GoogleFonts.openSans(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(0, 159, 158, 1),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(0.0),
                              child: imageUrl != ""
                                  ? ImageNetwork(
                                      image: imageUrl!,
                                      height: 110,
                                      width: 110,
                                    )
                                  : Container(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            _pickImageGallery();
                          },
                          child: Text(
                            ' Edit',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 163, 163, 163),
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' ${title}. ${fullName}',
                          style: TextStyle(
                              fontSize: 20,
                              color: const Color.fromARGB(255, 116, 116, 116),
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          'Membership : ${membership}',
                          style: TextStyle(
                              fontSize: 18,
                              color: const Color.fromARGB(255, 116, 116, 116),
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          'Status : ${status}',
                          style: TextStyle(
                              fontSize: 18,
                              color: const Color.fromARGB(255, 116, 116, 116),
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProfileDropdownButton(
                  onOptionSelected: (String) {},
                  changePageIndex: changePage,
                ),
              ),
              Container(
                child: pages[pageIndex],
              )
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 50, top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 35,
            ),
            Container(
              width: MyUtility(context).width / 1.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                      color: Color.fromARGB(255, 212, 210, 210), width: 1.5)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: imageUrl != ""
                                ? ImageNetwork(
                                    image: imageUrl!,
                                    height: 110,
                                    width: 110,
                                  )
                                : Container(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          _pickImageGallery();
                        },
                        child: Text(
                          ' Edit',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 163, 163, 163),
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' ${title}. ${fullName}',
                        style: TextStyle(
                            fontSize: 20,
                            color: const Color.fromARGB(255, 116, 116, 116),
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        'Membership : ${membership}',
                        style: TextStyle(
                            fontSize: 18,
                            color: const Color.fromARGB(255, 116, 116, 116),
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        'Status : ${status}',
                        style: TextStyle(
                            fontSize: 18,
                            color: const Color.fromARGB(255, 116, 116, 116),
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StyleButton(
                    description: "PROFILE HOME",
                    height: 35,
                    width: 85,
                    onTap: () {
                      changePage(0);
                    }),
                SizedBox(
                  width: 15,
                ),
                StyleButton(
                    description: "MY DETAILS",
                    height: 35,
                    width: 85,
                    onTap: () {
                      changePage(1);
                    }),
                SizedBox(
                  width: 15,
                ),
                StyleButton(
                    description: "MY BIOGRAPHY",
                    height: 35,
                    width: 85,
                    onTap: () {
                      changePage(2);
                    }),
                SizedBox(
                  width: 15,
                ),
                StyleButton(
                    description: "SECURITY",
                    height: 35,
                    width: 85,
                    onTap: () {
                      changePage(3);
                    })
              ],
            ),
            /*     SizedBox(
            height: MyUtility(context).height * 0.2,
            child: SizedBox(
              width: MyUtility(context).width / 1.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: imageUrl != ""
                                ? ImageNetwork(
                                    image: imageUrl!,
                                    height: 110,
                                    width: 110,
                                  )
                                : Container(),
                          ),
                        ),
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
       */
            SizedBox(
              width: MyUtility(context).width / 1.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*     Row(
                      children: [
                        Text(
                          'Your image is visible to the public',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF6A6A6A),
                              fontWeight: FontWeight.normal),
                        ),
                        GestureDetector(
                          onTap: () {
                            _pickImageGallery();
                          },
                          child: Text(
                            ' Change',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF174486),
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),*/
                      SizedBox(
                        height: MyUtility(context).height * 0.02,
                      ),
                      Container(
                        child: pages[pageIndex],
                      )

                      /*   Row(
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
                                        height:
                                            MyUtility(context).height * 0.05,
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
                                        'Build Bio',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    Spacer(),
                                    Visibility(
                                      visible: pageIndex == 1 ? true : false,
                                      child: Container(
                                        width: 4,
                                        height:
                                            MyUtility(context).height * 0.05,
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
                                        'Notifications',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    Spacer(),
                                    Visibility(
                                      visible: pageIndex == 2 ? true : false,
                                      child: Container(
                                        width: 4,
                                        height:
                                            MyUtility(context).height * 0.05,
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
                                        'My Preferences',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    Spacer(),
                                    Visibility(
                                      visible: pageIndex == 3 ? true : false,
                                      child: Container(
                                        width: 4,
                                        height:
                                            MyUtility(context).height * 0.05,
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
                                        changePage(4);
                                      },
                                      child: Text(
                                        'Security',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    Spacer(),
                                    Visibility(
                                      visible: pageIndex == 4 ? true : false,
                                      child: Container(
                                        width: 4,
                                        height:
                                            MyUtility(context).height * 0.05,
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
                       
                        //*Notifications()*/
                        /*MyPreferences()*/
                        /*Security()*/
                      ],
                    ),*/
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
