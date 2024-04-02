import 'package:flutter/material.dart';
import 'package:sama/CenterOfExcellence.dart';
import 'package:sama/CenterofExcellenceArticle.dart';
import 'package:sama/MemberBenifits.dart';
import 'package:sama/PostLoginCenter.dart';
import 'package:sama/PostLoginLeft.dart';
import 'package:sama/ProfileSighnIn.dart';
import 'package:sama/components/myutility.dart';

class PostLoginLandingPage extends StatefulWidget {
  const PostLoginLandingPage({super.key});

  @override
  State<PostLoginLandingPage> createState() => _PostLoginLandingPageState();
}

class _PostLoginLandingPageState extends State<PostLoginLandingPage> {
  @override
  Widget build(BuildContext context) {
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
                    'Meember Portal',
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
                    onPressed: () {},
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
                    PostLoginLeft(),
                    SizedBox(
                      width: MyUtility(context).width * 0.025,
                      child: Icon(
                        Icons.arrow_circle_left,
                        size: 30,
                      ),
                    ),
                    /*ProfileSighnIn()*/
                    /*PostLoginCenter()*/
                    /*CenterOfExcellence()*/
                    /*CenterOfExcellenceArticle()*/
                    MemberBenifits()
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
