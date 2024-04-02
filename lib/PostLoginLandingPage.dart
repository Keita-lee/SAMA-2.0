import 'package:flutter/material.dart';
import 'package:sama/admin/centerOfExcellence/centerOfExcellnceList.dart';
import 'package:sama/admin/memberBenefits/memberBenifitsList.dart';
import 'package:sama/centerOfExcellence/CenterOfExcellence.dart';
import 'package:sama/centerOfExcellence/CenterofExcellenceArticle.dart';
import 'package:sama/memberBenifits/MemberBenifits.dart';
import 'package:sama/dashboard/PostLoginCenter.dart';
import 'package:sama/dashboard/menu/PostLoginLeft.dart';
import 'package:sama/profile/EditProfile.dart';
import 'package:sama/profile/ProfileSighnIn.dart';
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
  var pageIndex = 0;
  getArticleId(value) {
    setState(() {
      articleId = value;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      CenterOfExcellenceArticle(articleId: articleId, changePage: changePage),
    ];

    return Container(
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
                    'Member Portal',
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
                      border:
                          Border.all(color: Color.fromRGBO(170, 170, 170, 1.0)),
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
                                border:
                                    InputBorder.none, // Hide the default border
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(170, 170, 170, 1.0)),
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
                    icon: Image.asset(
                      'images//dots.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'images/ukflag.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      changePage(3);
                    },
                    icon: CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
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
                    PostLoginLeft(changePage: changePage),
                    SizedBox(
                      width: MyUtility(context).width * 0.025,
                      child: Icon(
                        Icons.arrow_circle_left,
                        size: 30,
                      ),
                    ),
                    //   ProfileSighnIn()
                    // PostLoginCenter(),
                    Center(
                      child: pages[pageIndex],
                    )

                    //  CenterOfExcellence()
                    //CenterOfExcellenceArticle()
                    //  MemberBenifits()
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
