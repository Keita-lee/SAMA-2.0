import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/admin/ElectionsAdmin/NominationAcceptance/NominationAcceptance.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/nominationsSetup.dart';
import 'package:sama/admin/Events/AdminEvents/Event.dart';
import 'package:sama/admin/Events/EventDetails/EventDetails.dart';
import 'package:sama/admin/Events/EventDetails/Ui/EventMemberList.dart';
import 'package:sama/admin/Events/NewEvent/NewEvent.dart';
import 'package:sama/admin/centerOfExcellence/centerOfExcellnceList.dart';
import 'package:sama/admin/media/adminMedia.dart';
import 'package:sama/admin/memberBenefits/memberBenifitsList.dart';
import 'package:sama/homePage/dashboard/ui/popups/notificationList.dart';
import 'package:sama/login/loginPages.dart';
import 'package:sama/member/Events/MemberEventDetails/MemberEventDetails.dart';
import 'package:sama/member/Events/MemberEvents/MemberEvents.dart';
import 'package:sama/member/centerOfExcellence/CenterOfExcellence.dart';
import 'package:sama/member/centerOfExcellence/CenterofExcellenceArticle.dart';
import 'package:sama/member/election/memberElection.dart';
import 'package:sama/member/media/memberMedia.dart';
import 'package:sama/member/memberBenifits/MemberBenifits.dart';
import 'package:sama/homePage/dashboard/PostLoginCenter.dart';
import 'package:sama/homePage/dashboard/menu/PostLoginLeft.dart';

import 'package:sama/components/myutility.dart';
import 'package:sama/profile/logoutPopup.dart';
import 'package:sama/profile/profile.dart';

class PostLoginLandingPage extends StatefulWidget {
  String userId;
  PostLoginLandingPage({super.key, required this.userId});

  @override
  State<PostLoginLandingPage> createState() => _PostLoginLandingPageState();
}

class _PostLoginLandingPageState extends State<PostLoginLandingPage> {
  //var
  List userNotification = [];
  var notificationsRead = false;
  final GlobalKey _menuKey = GlobalKey();
  String articleId = "";
  String articleImage = "";
  String profileUrl = "";
  var pageIndex = 0;
  String userType = "";
  double menuSize = 6.5;
  //get data of signed in user
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

//get User Notification list
  getUserNotificationList() async {
    final doc = await FirebaseFirestore.instance
        .collection('notifications')
        .where("userWhoNotify",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      userNotification.addAll(doc.docs);
    });

    var notificationIndex =
        (doc.docs).indexWhere((item) => item["read"] == false);

    if (notificationIndex != -1) {
      setState(() {
        notificationsRead = true;
      });
    }
  }

//popup for notification
  Future openNotificationList() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: NotificationList(
          closeDialog: () => Navigator.pop(context),
          notificationsList: userNotification,
        ));
      });

  @override
  void initState() {
    getUserData();
    getUserNotificationList();
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
      AdminEvents(),
      MemberMedia(),
      MemberEvents(),
      NominationSetup(),
      MemberElection(),
      /*NominationAcceptance()*/
      /*ElectionsManageEvent(),*/

      /*BranchMembers(),*/
      /*AdminEventDetails(),*/
      /*AdminEvents(),*/
      /*MemberEvents()*/
      /*MemberEventDetails()*/
    ];

    //Dialog for logout
    Future openLogoutDialog() => showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: LogoutPopup(closeDialog: () => Navigator.pop(context!)));
        });
// logUserOut
    logOut() {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      _auth.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Material(
                  child: LoginPages(),
                )),
      );
    }

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform.scale(
                          scale: 0.8,
                          child: Container(
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
                        ),
                        SizedBox(width: 10),
                        Text(
                          userType == "Admin"
                              ? 'Admin Portal'
                              : 'Member Portal',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF174486),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: MyUtility(context).width * 0.037),
                        Transform.scale(
                          scale: 0.8,
                          child: Container(
                            width: 180,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.search, color: Colors.grey),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Search SAMA',
                                        border: InputBorder.none,
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
                        ),
                        Spacer(),
                        SizedBox(width: 20),
                        Transform.scale(
                          scale: 0.8,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.mail),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: IconButton(
                            onPressed: () {
                              openNotificationList();
                            },
                            icon: Icon(
                              Icons.notifications,
                              color: notificationsRead
                                  ? Color(0xFF174486)
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        Transform.scale(
                            scale: 0.8,
                            child: PopupMenuButton(
                              key: _menuKey,
                              onSelected: (value) {
                                if (value == "viewProfile") {
                                  changePage(3);
                                } else if (value == "logout") {
                                  openLogoutDialog();
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry>[
                                PopupMenuItem(
                                  height: 22,
                                  value: "viewProfile",
                                  child: const Text(
                                    'View Profile',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF174486),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                PopupMenuItem(
                                  height: 22,
                                  value: "logout",
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF174486),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                              child: ClipRRect(
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
                                              dynamic state =
                                                  _menuKey.currentState;
                                              state.showButtonMenu();
                                            },
                                            image: profileUrl!,
                                            height: 55,
                                            width: 55,
                                          )
                                        : Container(),
                                  ),
                                ),
                              ),
                            )),
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
                          Transform.scale(
                            scale: 0.8,
                            child: PostLoginLeft(
                                changePage: changePage, menuSize: menuSize),
                          ),
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
                          Transform.scale(
                            scale: 0.8,
                            child: Center(
                              child: pages[pageIndex],
                            ),
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
