import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/greybutton.dart';
import 'package:sama/components/myutility.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HoverItem extends StatefulWidget {
  String description;
  String iconPath;
  final VoidCallback onPressed;
  HoverItem(
      {super.key,
      required this.description,
      required this.iconPath,
      required this.onPressed});

  @override
  State<HoverItem> createState() => _HoverItemState();
}

class _HoverItemState extends State<HoverItem> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered))
              return Color.fromARGB(255, 8, 55, 145);
            return Color(0xFF6A6A6A);
          }),
        ),
        onPressed: widget.onPressed,
        child: Row(
          children: [
            Container(
              width: 35,
              height: 25,
              child: SvgPicture.asset(
                widget.iconPath,
                color: Color.fromARGB(255, 8, 55, 145),
                width: 25,
                height: 25,
              ),
            ),
            Text(
              widget.description,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}

class PostLoginLeft extends StatefulWidget {
  Function(int) changePage;
  PostLoginLeft({super.key, required this.changePage});

  @override
  State<PostLoginLeft> createState() => _PostLoginLeftState();
}

class _PostLoginLeftState extends State<PostLoginLeft> {
  var pages = [];
  String userType = "";

  getUserData() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (data.exists) {
      setState(() {
        userType = data.get('userType');
      });
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width / 6.5,
      height: MyUtility(context).height / 1.2,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xFFD1D1D1),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
                visible: userType == "Admin" ? true : false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HoverItem(
                      description: 'Centre of Excellence',
                      iconPath: "images/student.svg",
                      onPressed: () {
                        widget.changePage(1);
                      },
                    ),
                    HoverItem(
                      description: 'Member Benefits',
                      iconPath: "images/star.svg",
                      onPressed: () {
                        widget.changePage(2);
                      },
                    ),
                    /*         TextButton.icon(
                      onPressed: () {
                        widget.changePage(2);
                      },
                      icon: Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 8, 55, 145),
                      ),
                      label: SizedBox(
                        width: MyUtility(context).width / 6.5,
                        child: Text(
                          'Centre of Excellence',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6A6A6A),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        widget.changePage(2);
                      },
                      icon: Icon(
                        Icons.school,
                        color: Color.fromARGB(255, 8, 55, 145),
                      ),
                      label: SizedBox(
                        width: MyUtility(context).width / 6.5,
                        child: Text(
                          'Member Benifits',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6A6A6A),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
               */
                  ],
                )),
            Visibility(
              visible: userType != "Admin" ? true : false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MyUtility(context).height * 0.025,
                  ),
                  HoverItem(
                    description: "Dashboard",
                    iconPath: "",
                    onPressed: () {
                      widget.changePage(0);
                    },
                  ),
                  HoverItem(
                    description: "Announcements",
                    iconPath: "",
                    onPressed: () {},
                  ),
                  HoverItem(
                    description: 'News Feed',
                    iconPath: "",
                    onPressed: () {},
                  ),
                  HoverItem(
                    description: "Chat",
                    iconPath: "",
                    onPressed: () {},
                  ),
                  HoverItem(
                    description: "Events",
                    iconPath: "",
                    onPressed: () {},
                  ),
                  HoverItem(
                    description: "Centre of Excellence",
                    iconPath: "images/student.svg",
                    onPressed: () {
                      widget.changePage(1);
                    },
                  ),
                  HoverItem(
                    description: "Publications",
                    iconPath: "",
                    onPressed: () {
                      widget.changePage(1);
                    },
                  ),
                  HoverItem(
                    description: "Podcast",
                    iconPath: "",
                    onPressed: () {},
                  ),
                  HoverItem(
                    description: """Professional Development
and Membership""",
                    iconPath: "",
                    onPressed: () {},
                  ),
                  HoverItem(
                    description: "E-Store",
                    iconPath: "",
                    onPressed: () {},
                  ),
                  HoverItem(
                    description: "Member Benefits",
                    iconPath: "images/star.svg",
                    onPressed: () {
                      widget.changePage(2);
                    },
                  ),
                  HoverItem(
                    description: "Coding Academy",
                    iconPath: "",
                    onPressed: () {},
                  ),
                  HoverItem(
                    description: "Industry Development",
                    iconPath: "",
                    onPressed: () {},
                  ),
                  HoverItem(
                    description: "Community Highlights",
                    iconPath: "",
                    onPressed: () {},
                  ),
                  HoverItem(
                    description: "MemberShip Category",
                    iconPath: "",
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: MyUtility(context).height * 0.025,
                  ),
                  SizedBox(
                    height: MyUtility(context).height * 0.05,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: userType == "Admin"
                  ? MyUtility(context).height / 2
                  : MyUtility(context).height / 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SizedBox(
                width: MyUtility(context).width * 0.13,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFBC82D),
                      ),
                      child: ClipOval(
                        child: Transform.scale(
                          scale: 0.6, // Adjust the scale factor as needed
                          child: SvgPicture.asset(
                            'images/lifebuoy.svg',
                            color: Color(0xFF174486),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MyUtility(context).height * 0.01,
                    ),
                    Text(
                      'Need Help?',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF174486),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MyUtility(context).height * 0.01,
                    ),
                    Text(
                      'Our friendly SAMA Bot Assistant is ready to assist you right now.',
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          letterSpacing: -0.05,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.5),
                    ),
                    SizedBox(
                      height: MyUtility(context).height * 0.01,
                    ),
                    Text(
                      "If you don't get what you are looking for, your query will be routed to someone who can help you.",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          letterSpacing: -0.05,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.5),
                    ),
                    SizedBox(
                      height: MyUtility(context).height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {},
                      behavior: HitTestBehavior.translucent,
                      child: Text(
                        "Chat Now",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          letterSpacing: -0.05,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.5,
                          decoration:
                              TextDecoration.underline, // Underline text
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
