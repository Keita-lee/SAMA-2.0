import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/admin/centerOfExcellence/centerOfExcellnceList.dart';
import 'package:sama/admin/media/adminMedia.dart';
import 'package:sama/admin/memberBenefits/memberBenifitsList.dart';
import 'package:sama/member/centerOfExcellence/CenterOfExcellence.dart';
import 'package:sama/member/centerOfExcellence/CenterofExcellenceArticle.dart';
import 'package:sama/member/media/memberMedia.dart';
import 'package:sama/member/memberBenifits/MemberBenifits.dart';
import 'package:sama/homePage/dashboard/PostLoginCenter.dart';
import 'package:sama/homePage/dashboard/menu/PostLoginLeft.dart';

import 'package:sama/components/myutility.dart';
import 'package:sama/profile/profile.dart';

class PostLoginLandingPage extends StatefulWidget {
  String userId;
  PostLoginLandingPage({super.key, required this.userId});

  @override
  State<PostLoginLandingPage> createState() => _PostLoginLandingPageState();
}

class _PostLoginLandingPageState extends State<PostLoginLandingPage> {
  String articleId = "";
  String articleImage = "";
  String profileUrl = "";
  var pageIndex = 0;
  String userType = "";
  double menuSize = 6.5;
  getUserData() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (data.exists) {
      setState(() {
        userType = data.get('userType');
        profileUrl = data.get('profilePic');
      });
    }
  }

  getArticleId(value, image) {
    setState(() {
      articleId = value;
      articleImage = image;
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    changeSideMenuSize() {
      setState(() {
        if (menuSize == 18) {
          menuSize = 6.5;
        } else {
          menuSize = 18;
        }
      });
    }

    changePage(value) {
      setState(() {
        pageIndex = value;
      });
    }

    var pages = [
      PostLoginCenter(),
      CenterOfExcellence(getArticleId: getArticleId, changePage: changePage),
      MemberBenifits(),
      Profile(),
      CenterOfExcellenceList(),
      MemberBenefitsList(),
      CenterOfExcellenceArticle(
          articleId: articleId,
          changePage: changePage,
          articleImage: articleImage),
      AdminMedia(),
      MemberMedia(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFFF8FAFF),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('images/sama_logo.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          userType == "Admin"
                              ? 'Admin Portal'
                              : 'Member Portal',
                          style: TextStyle(
                              fontSize: 22,
                              color: Color(0xFF174486),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: MyUtility(context).width * 0.037),
                        Container(
                          width: 175,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                                color: Color.fromRGBO(170, 170, 170, 1.0)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Icon(Icons.search, color: Colors.grey),
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Search SAMA', // Example text
                                      border: InputBorder
                                          .none, // Hide the default border
                                      hintStyle: TextStyle(
                                          color: Color.fromRGBO(
                                              170, 170, 170, 1.0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        SizedBox(width: 20),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.mail),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.notifications),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(0.0),
                              child: profileUrl != ""
                                  ? ImageNetwork(
                                      onTap: () {
                                        changePage(3);
                                      },
                                      image: profileUrl!,
                                      height: 55,
                                      width: 55,
                                    )
                                  : Container(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MyUtility(context).width * 0.04,
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PostLoginLeft(
                              changePage: changePage, menuSize: menuSize),
                          Visibility(
                            visible: menuSize == 6.5 ? true : false,
                            child: GestureDetector(
                              onTap: () {
                                changeSideMenuSize();
                              },
                              child: SizedBox(
                                width: MyUtility(context).width * 0.025,
                                child: Icon(
                                  Icons.arrow_circle_left,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: menuSize != 6.5 ? true : false,
                            child: GestureDetector(
                              onTap: () {
                                changeSideMenuSize();
                              },
                              child: SizedBox(
                                width: MyUtility(context).width * 0.025,
                                child: Icon(
                                  Icons.arrow_circle_right,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: pages[pageIndex],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
