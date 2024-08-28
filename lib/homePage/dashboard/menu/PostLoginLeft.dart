import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/Login/popups/validateDialog.dart';
import 'package:sama/components/greybutton.dart';
import 'package:sama/components/myutility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sama/homePage/dashboard/menu/ui/leftMenuDropButton.dart';
import 'package:sama/homePage/dashboard/menu/ui/memberCategoriesDrop.dart';

import '../../PostLoginLandingPage.dart';

class HoverItem extends StatefulWidget {
  double menuSize;
  String description;
  String iconPath;
  final VoidCallback onPressed;
  bool isActive;
  HoverItem(
      {super.key,
      required this.isActive,
      required this.menuSize,
      required this.description,
      required this.iconPath,
      required this.onPressed});

  @override
  State<HoverItem> createState() => _HoverItemState();
}

class _HoverItemState extends State<HoverItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.menuSize == 6.5) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: widget.isActive
                  ? Color.fromRGBO(174, 204, 236, 1)
                  : Color.fromRGBO(248, 250, 255, 1)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return Color.fromRGBO(24, 68, 126, 1);
                    return Colors.black;
                  }),
                ),
                onPressed: widget.onPressed,
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      child: SvgPicture.asset(
                        widget.iconPath,
                        color: Color.fromARGB(255, 8, 55, 145),
                        width: 20,
                        height: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.description,
                      maxLines: null,
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.openSans(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                )),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: widget.isActive
                  ? Color.fromRGBO(174, 204, 236, 1)
                  : Color.fromRGBO(248, 250, 255, 1)),
          child: TextButton(
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: 20,
                      height: 20,
                      child: SvgPicture.asset(
                        widget.iconPath,
                        color: Color.fromARGB(255, 8, 55, 145),
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      );
    }
  }
}

int activeIndex = 0;

class PostLoginLeft extends StatefulWidget {
  double menuSize;

  Function(int) changePage;
  int activeIndex;
  PostLoginLeft(
      {super.key,
      required this.menuSize,
      required this.changePage,
      required this.activeIndex});

  @override
  State<PostLoginLeft> createState() => _PostLoginLeftState();
}

class _PostLoginLeftState extends State<PostLoginLeft> {
  var pages = [];
  String userType = "";

  int? currentOpenDropdown;

  void toggleDropdown(int index) {
    setState(() {
      if (currentOpenDropdown == index) {
        currentOpenDropdown = null;
      } else {
        currentOpenDropdown = index;
      }
    });
  }

  void _handleItemClick(int index, int pageIndex) async {
    setState(() {});
    if (pageIndex != -1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Material(
                    child: PostLoginLandingPage(
                        pageIndex: pageIndex,
                        userId: FirebaseAuth.instance.currentUser != null
                            ? FirebaseAuth.instance.currentUser!.uid
                            : "",
                        activeIndex: index),
                  ))).whenComplete(() {
        setState(() {
          print(index);
          print(index);
          print(index);
          print(index);
          activeIndex = index;
        });
      });
    }

    setState(() {
      activeIndex = index;
    });
  }

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

  //Dialog for contruction popup
  Future OpenContructionPopup() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: ValidateDialog(
                description: "Under Construction",
                closeDialog: () => Navigator.pop(context!)));
      });

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // Use the properties stored in the State class.
      width: MyUtility(context).width / widget.menuSize,
      height: MyUtility(context).height,
      decoration: BoxDecoration(
        color: Color(0xFFF8FAFF),
        border: Border(
          right: BorderSide(
            width: 1.5,
            color: Color.fromRGBO(211, 230, 250, 1),
          ),
        ),
      ),
      // Define how long the animation should take.
      duration: const Duration(seconds: 1),
      // Provide an optional curve to make the animation feel smoother.
      curve: Curves.fastOutSlowIn,

      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Visibility(
                visible: userType == "Admin" ? true : false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HoverItem(
                      isActive: activeIndex == 0,
                      menuSize: widget.menuSize,
                      description: "Dashboard",
                      iconPath: "images/icon_dashboard.svg",
                      onPressed: () {
                        _handleItemClick(0, 0);
                        widget.changePage(0);
                      },
                    ),
                    HoverItem(
                      isActive: activeIndex == 1,
                      menuSize: widget.menuSize,
                      description: 'Centre of Excellence',
                      iconPath: "images/icon_centre_of.svg",
                      onPressed: () {
                        _handleItemClick(1, 1);
                        widget.changePage(1);
                      },
                    ),
                    HoverItem(
                      isActive: activeIndex == 11,
                      menuSize: widget.menuSize,
                      description: 'Member Benefits',
                      iconPath: "images/icon_benefits.svg",
                      onPressed: () {
                        _handleItemClick(11, 11);
                        widget.changePage(2);
                      },
                    ),
                    HoverItem(
                      isActive: activeIndex == 2,
                      menuSize: widget.menuSize,
                      description: 'Media & Webinars',
                      iconPath: "images/icon_media.svg",
                      onPressed: () {
                        _handleItemClick(2, 7);
                        widget.changePage(7);
                      },
                    ),
                    HoverItem(
                      isActive: activeIndex == 20,
                      menuSize: widget.menuSize,
                      description: "Professional Development1",
                      iconPath: "images/icon_prof_dev.svg",
                      onPressed: () {
                        _handleItemClick(20, 20);
                      },
                    ),
                    HoverItem(
                      isActive: activeIndex == 3,
                      menuSize: widget.menuSize,
                      description: 'Events',
                      iconPath: "images/icon_events.svg",
                      onPressed: () {
                        _handleItemClick(3, 8);
                        widget.changePage(8);
                      },
                    ),
                    HoverItem(
                      isActive: activeIndex == 15,
                      menuSize: widget.menuSize,
                      description: "Communities",
                      iconPath: "images/icon_categories.svg",
                      onPressed: () {
                        _handleItemClick(15, 15);
                        widget.changePage(15);
                      },
                    ),
                    HoverItem(
                      isActive: activeIndex == 4,
                      menuSize: widget.menuSize,
                      description: 'Branch Voting',
                      iconPath: "images/icon_voting.svg",
                      onPressed: () {
                        _handleItemClick(4, 4);
                        widget.changePage(11);
                      },
                    ),
                    HoverItem(
                      isActive: activeIndex == 5,
                      menuSize: widget.menuSize,
                      description: 'E-Store',
                      iconPath: "images/icon_estore.svg",
                      onPressed: () {
                        _handleItemClick(5, 13);
                        widget.changePage(13);
                      },
                    ),
                    HoverItem(
<<<<<<< HEAD
                      isActive: activeIndex == 21,
                      menuSize: widget.menuSize,
                      description: 'Bug Report',
                      iconPath: "",
                      onPressed: () {
                        _handleItemClick(21, 21);
                        widget.changePage(21);
=======
                      isActive: activeIndex == 6,
                      menuSize: widget.menuSize,
                      description: "Member Management",
                      iconPath: "images/icon_voting.svg",
                      onPressed: () {
                        _handleItemClick(6, 20);
                        widget.changePage(20);
>>>>>>> ef4bd9eef1a5dc605e54c33e8fff7d3394559890
                      },
                    ),
                  ],
                )),
            Visibility(
              visible: userType != "Admin" ? true : false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  HoverItem(
                    isActive: activeIndex == 0,
                    menuSize: widget.menuSize,
                    description: "Dashboard",
                    iconPath: "images/icon_dashboard.svg",
                    onPressed: () {
                      _handleItemClick(0, 0);
                      widget.changePage(0);
                    },
                  ),
                  HoverItem(
                    isActive: activeIndex == 1,
                    menuSize: widget.menuSize,
                    description: "Centre of Excellence",
                    iconPath: "images/icon_centre_of.svg",
                    onPressed: () {
                      widget.changePage(1);
                      _handleItemClick(1, 1);
                    },
                  ),
                  HoverItem(
                    isActive: activeIndex == 2,
                    menuSize: widget.menuSize,
                    description: " Media & Webinars",
                    iconPath: "images/icon_media.svg",
                    onPressed: () {
                      widget.changePage(9);
                      _handleItemClick(2, 9);
                    },
                  ),
                  /*   HoverItem(
                    isActive: activeIndex == 3,
                    menuSize: widget.menuSize,
                    description: "Publications",
                    iconPath: "images/icon_publications.svg",
                    onPressed: () {
                      _handleItemClick(3);
                    },
                  ),*/
                  HoverItem(
                    isActive: activeIndex == 4,
                    menuSize: widget.menuSize,
                    description: "Coding Academy",
                    iconPath: "images/icons_coding.svg",
                    onPressed: () {
                      _handleItemClick(4, -1);
                    },
                  ),
                  HoverItem(
                    isActive: activeIndex == 19,
                    menuSize: widget.menuSize,
                    description: "Professional Development",
                    iconPath: "images/icon_prof_dev.svg",
                    onPressed: () {
                      _handleItemClick(19, 19);
                    },
                  ),
                  HoverItem(
                    isActive: activeIndex == 6,
                    menuSize: widget.menuSize,
                    description: "E-Store",
                    iconPath: "images/icon_estore.svg",
                    onPressed: () {
                      _handleItemClick(6, 14);
                      widget.changePage(14);
                    },
                  ),
                  HoverItem(
                    isActive: activeIndex == 7,
                    menuSize: widget.menuSize,
                    description: "Events",
                    iconPath: "images/icon_events.svg",
                    onPressed: () {
                      _handleItemClick(7, 10);
                      widget.changePage(10);
                    },
                  ),
                  HoverItem(
                    isActive: activeIndex == 8,
                    menuSize: widget.menuSize,
                    description: "Communities",
                    iconPath: "images/icon_categories.svg",
                    onPressed: () {
                      _handleItemClick(8, 16);
                      widget.changePage(16);
                    },
                  ),
                  /*     LeftMenuDropButton(
                      isActive: activeIndex == 8,
                      menuSize: widget.menuSize,
                      description: "Membership Category",
                      iconPath: "images/icon_categories.svg",
                      onPressed: () {
                        _handleItemClick(8);
                        toggleDropdown(0);
                      },
                      isOpen: currentOpenDropdown == 0,
                      dropDownContent: [
                        MemberCategoriesDrop(
                            buttonText: 'Student',
                            onTap: () {
                              //ADD PATH
                            }),
                        MemberCategoriesDrop(
                            buttonText: 'Public Sector',
                            onTap: () {
                              //ADD PATH
                            }),
                        MemberCategoriesDrop(
                            buttonText: 'Private Practice',
                            onTap: () {
                              //ADD PATH
                            }),
                        MemberCategoriesDrop(
                            buttonText: 'EDOPS',
                            onTap: () {
                              //ADD PATH
                            }),
                      ]),
                */
                  HoverItem(
                    isActive: activeIndex == 9,
                    menuSize: widget.menuSize,
                    description: "Member Benefits",
                    iconPath: "images/icon_benefits.svg",
                    onPressed: () {
                      _handleItemClick(9, 2);
                      widget.changePage(2);
                    },
                  ),
                  HoverItem(
                    isActive: activeIndex == 10,
                    menuSize: widget.menuSize,
                    description: "Branch Voting",
                    iconPath: "images/icon_voting.svg",
                    onPressed: () {
                      _handleItemClick(10, 12);
                      widget.changePage(12);
                    },
                  ),

                  // HoverItem(
                  //   isActive: activeIndex == 11,
                  //   menuSize: widget.menuSize,
                  //   description: "Transactions",
                  //   iconPath: "images/icon_estore.svg",
                  //   onPressed: () {
                  //     _handleItemClick(11);
                  //     widget.changePage(17);
                  //   },
                  // ),
                  /*HoverItem(
                    menuSize: widget.menuSize,
                    description: "Announcements",
                    iconPath: "",
                    onPressed: () {},
                  ),
                  HoverItem(
                    menuSize: widget.menuSize,
                    description: 'News Feed',
                    iconPath: "",
                    onPressed: () {},
                  ),
                  HoverItem(
                    menuSize: widget.menuSize,
                    description: "Chat",
                    iconPath: "",
                    onPressed: () {},
                  ),
                  
                  HoverItem(
                    menuSize: widget.menuSize,
                    description: "Industry Development",
                    iconPath: "",
                    onPressed: () {},
                  ),
                  HoverItem(
                    menuSize: widget.menuSize,
                    description: "Community Highlights",
                    iconPath: "",
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: MyUtility(context).height * 0.025,
                  ),
                  SizedBox(
                    height: MyUtility(context).height * 0.05,
                  ),*/
                ],
              ),
            ),
            SizedBox(
              height: userType == "Admin"
                  ? MyUtility(context).height / 2
                  : MyUtility(context).height / 20,
            ),
            /* SizedBox(
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
                  InkWell(
                    onTap: () {
                      OpenContructionPopup();
                    },
                    child: Text(
                      "Chat Now",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        letterSpacing: -0.05,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.5,
                        decoration: TextDecoration.underline, // Underline text
                      ),
                    ),
                  )
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
