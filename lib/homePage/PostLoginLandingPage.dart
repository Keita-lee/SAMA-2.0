import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/nominationsSetup.dart';
import 'package:sama/admin/Events/AdminEvents/Event.dart';
import 'package:sama/admin/centerOfExcellence/centerOfExcellnceList.dart';
import 'package:sama/admin/communities/comunitiesAdmin.dart';
import 'package:sama/admin/media/adminMedia.dart';
import 'package:sama/admin/memberBenefits/memberBenifitsList.dart';
import 'package:sama/admin/memberManagement/memberManagementMainCon.dart';
import 'package:sama/admin/products/products.dart';
import 'package:sama/admin/transactions/transactionsAdmin.dart';
import 'package:sama/homePage/dashboard/ui/SamaTopTabBar.dart';
import 'package:sama/homePage/dashboard/ui/onHoverButtons.dart';
import 'package:sama/homePage/dashboard/ui/popups/notificationList.dart';
import 'package:sama/login/loginPages.dart';
import 'package:sama/member/Events/MemberEvents/MemberEvents.dart';
import 'package:sama/member/centerOfExcellence/CenterOfExcellence.dart';
import 'package:sama/member/centerOfExcellence/CenterofExcellenceArticle.dart';
import 'package:sama/member/election/memberElection.dart';
import 'package:sama/member/media/memberMedia.dart';
import 'package:sama/member/memberBenifits/MemberBenifits.dart';
import 'package:sama/homePage/dashboard/dashboardMain.dart';
import 'package:sama/homePage/dashboard/menu/PostLoginLeft.dart';

import 'package:sama/components/myutility.dart';
import 'package:sama/member/productDisplay/ProductListDisplay.dart';
import 'package:sama/member/productDisplay/cart/cartPage.dart';
import 'package:sama/member/professionalDevelopment/professionalDevelopmentMainCon.dart';
import 'package:sama/profile/logoutPopup.dart';
import 'package:sama/profile/profile.dart';

import '../BugReport/bugReport.dart';
import '../BugReport/reportList/bugReportList.dart';
import '../admin/profesionalDevelopment/profesionalDevAdmin.dart';
import '../member/communities/memberCommunities.dart';

class PostLoginLandingPage extends StatefulWidget {
  String userId;
  int? pageIndex;
  int activeIndex;
  PostLoginLandingPage(
      {super.key,
      required this.userId,
      this.pageIndex,
      required this.activeIndex});

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

  String userType = "";
  double menuSize = 6.5;
  //get data of signed in user
  getUserData() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (data.exists && widget.userId != "") {
      setState(() {
        userType = data.get('userType');
        profileUrl = data.get('profilePic');
      });
    } else {
      setState(() {
        userType = "NonMember";
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

  //popup for notification
  Future openReportPopup() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: BugReport(
          closeDialog: () => Navigator.pop(context),
        ));
      });

  @override
  void initState() {
    if (widget.userId == "") {
      setState(() {
        userType = "NonMember";
      });
    } else {
      getUserData();
    }

    getUserNotificationList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pageIndex = widget.pageIndex != null ? widget.pageIndex : 0;
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
      DashboardMain(
        userNotification: userNotification,
        userType: userType,
      ),
      CenterOfExcellence(
        getArticleId: getArticleId,
        changePage: changePage,
      ),
      MemberBenifits(),
      Profile(),
      CenterOfExcellenceList(),
      MemberBenefitsList(),
      CenterOfExcellenceArticle(
        articleId: articleId,
        changePage: changePage,
        articleImage: articleImage,
        userType: userType,
      ),
      AdminMedia(),
      AdminEvents(),
      MemberMedia(),
      MemberEvents(),
      NominationSetup(),
      MemberElection(
        userType: userType,
      ),
      Products(),
      ProductListDisplay(
        userType: userType,
      ),
      CommunitiesAdmin(),
      MemberCommunities(
        userType: userType,
      ),
      TransactionsAdmin(),
      ProductListDisplay(
        userType: userType,
        pageIndex: 2,
      ),
      professionalDevelopmentMainCon(
        userType: userType,
      ),
      MemberManagementMainCon(),
      /*NominationAcceptance()*/
      /*ElectionsManageEvent(),*/

      /*BranchMembers(),*/
      /*AdminEventDetails(),*/
      /*AdminEvents(),*/
      /*MemberEvents()*/
      /*MemberEventDetails()*/

      ProfessionalDevAdmin(),
      BugReportList(),
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

    //var heightDevice = MediaQuery.of(context).size.height;
    var heightDevice = MediaQuery.of(context).size.height;

    var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFFF8FAFF),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 65,
                    width: widthDevice,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 1.5,
                            color: Color.fromRGBO(211, 230, 250, 1)),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('images/sama_logo.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Visibility(
                              visible: menuSize == 6.5 ? true : false,
                              child: Text(
                                userType == "Admin"
                                    ? 'Admin Portal'
                                    : userType == "NonMember"
                                        ? "SAMA Portal"
                                        : 'Member Portal',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF174486),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: menuSize == 6.5 ? 30 : 10),
                            Visibility(
                              visible: menuSize == 6.5 ? true : false,
                              child: GestureDetector(
                                onTap: () {
                                  changeSideMenuSize();
                                },
                                child: SizedBox(
                                  width: MyUtility(context).width * 0.025,
                                  child: Icon(
                                    Icons.menu,
                                    color: Color.fromRGBO(174, 204, 236, 1),
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
                                    Icons.menu,
                                    size: 30,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Visibility(
                              visible: userType != 'Admin' &&
                                  userType != "NonMember",
                              child: Transform.scale(
                                scale: 0.8,
                                child: Container(
                                  width: 220,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                        color:
                                            Color.fromRGBO(170, 170, 170, 1.0)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                    ),
                                    child: Center(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: TextField(
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(bottom: 10),
                                                hintText: 'Search',
                                                border: InputBorder.none,
                                                hintStyle: TextStyle(
                                                    color: Color.fromRGBO(
                                                        170, 170, 170, 1.0)),
                                              ),
                                            ),
                                          ),
                                          Icon(Icons.search,
                                              color: Colors.grey),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: widthDevice / 10,
                            ),
                            Visibility(
                                visible: userType != 'Admin' &&
                                    userType != "NonMember",
                                child: SamaTopTabBar()),
                            Spacer(),
                            Visibility(
                                visible: userType == 'NonMember',
                                child: Row(
                                  children: [
                                    OnHoverButtons(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Material(
                                                      child: LoginPages(),
                                                    )),
                                          );
                                        },
                                        height: 35,
                                        width: 60,
                                        baseColor:
                                            Color.fromRGBO(237, 157, 4, 1),
                                        hoverColor:
                                            Color.fromRGBO(19, 43, 81, 1),
                                        description: 'LOGIN'),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    OnHoverButtons(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Material(
                                                      child: LoginPages(
                                                        pageIndex: 9,
                                                      ),
                                                    )),
                                          );
                                        },
                                        height: 35,
                                        width: 60,
                                        baseColor: Color(0xFF174486),
                                        hoverColor:
                                            Color.fromRGBO(19, 43, 81, 1),
                                        description: 'REGISTER')
                                  ],
                                )),
                            SizedBox(width: 20),
                            Visibility(
                              visible: userType != 'Admin' &&
                                  userType != "NonMember",
                              child: Stack(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        changePage(18);
                                      },
                                      icon: SvgPicture.string(
                                        '''
                                          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1109 1024">
                                            <path fill="currentColor" d="M1012.920568 469.559268c-15.332419 43.758169-43.523597 85.298574-85.298574 85.298574L294.493327 554.857842 309.207331 661.48106c3.326644 23.542406 19.085556 42.649287 42.649287 42.649287l618.414663 0 0 42.649287L330.531975 746.779634c-35.334934 0-57.960381-27.956608-63.973931-63.973931L181.25947 43.066397 10.662322 43.066397 10.662322 0.41711c0 0 131.317155-0.938284 170.597148 0 27.977932 0.661064 42.649287 42.649287 42.649287 42.649287l11.771203 85.298574L1012.920568 128.364971c59.090587 0 86.620702 24.864534 85.298574 85.298574L1012.920568 469.559268zM1012.920568 171.014258 351.856618 171.014258l-85.298574 0-24.992482 0 47.042164 341.194297L309.207331 512.208555l0 0 597.090019 0c36.550439 0 51.904182-10.79027 63.973931-42.649287l85.298574-234.571079C1063.438649 190.270411 1043.308185 171.014258 1012.920568 171.014258zM426.492871 789.428921c64.784267 0 117.285539 52.501272 117.285539 117.285539S491.277138 1024 426.492871 1024 309.207331 971.498728 309.207331 906.714461 361.708604 789.428921 426.492871 789.428921zM426.492871 981.350713c41.220536 0 74.636252-33.394392 74.636252-74.636252S467.713407 832.078208 426.492871 832.078208 351.856618 865.4726 351.856618 906.714461 385.272335 981.350713 426.492871 981.350713zM874.310385 789.428921c64.784267 0 117.285539 52.501272 117.285539 117.285539S939.094652 1024 874.310385 1024 757.024846 971.498728 757.024846 906.714461 809.526118 789.428921 874.310385 789.428921zM874.310385 981.350713c41.241861 0 74.636252-33.394392 74.636252-74.636252S915.552246 832.078208 874.310385 832.078208 799.674133 865.4726 799.674133 906.714461 833.068525 981.350713 874.310385 981.350713z" />
                                          </svg>
                                        ''',
                                        width: 20.0,
                                        height: 20.0,
                                        color: Color.fromRGBO(23, 68, 134, 1),
                                      )),
                                  // Positioned(
                                  //   right: 0,
                                  //   top: 0,
                                  //   child: Container(
                                  //     padding: EdgeInsets.all(2),
                                  //     decoration: BoxDecoration(
                                  //       color: Color.fromRGBO(73, 91, 155, 1),
                                  //       borderRadius: BorderRadius.circular(12),
                                  //     ),
                                  //     constraints: BoxConstraints(
                                  //       minWidth: 20,
                                  //       minHeight: 20,
                                  //     ),
                                  //     child: Text(
                                  //       '3', // Replace '3' with your dynamic cart item count
                                  //       style: TextStyle(
                                  //         color: Colors.white,
                                  //         fontSize: 12,
                                  //         fontWeight: FontWeight.bold,
                                  //       ),
                                  //       textAlign: TextAlign.center,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: userType != "NonMember",
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      openNotificationList();
                                    },
                                    icon: SvgPicture.asset(
                                      'images/icon_bell.svg',
                                      width: 20,
                                      height: 20,
                                      color: Color.fromRGBO(73, 91, 155, 1),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      openReportPopup();
                                    },
                                    icon: SvgPicture.asset(
                                      'images/icon_gear.svg',
                                      width: 20,
                                      height: 20,
                                      color: Color.fromRGBO(73, 91, 155, 1),
                                    ),
                                  ),
                                  PopupMenuButton(
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
                                          borderRadius:
                                              BorderRadius.circular(100),
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
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MyUtility(context).width * 0.04,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          PostLoginLeft(
                            changePage: changePage,
                            menuSize: menuSize,
                            activeIndex: widget.activeIndex,
                          ),
                          Container(
                            child: pages[pageIndex!],
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
