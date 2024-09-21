import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sama/components/mobile/components/Themes/custom_colors.dart';
import 'package:sama/components/mobile/Navbar/login_button.dart';
import 'package:sama/components/mobile/Navbar/register_button.dart';
import 'package:sama/login/loginPages.dart';
import 'package:sama/profile/logoutPopup.dart';
import '../../../homePage/PostLoginLandingPage.dart';

class Navbar extends StatefulWidget {
  final bool visible;
  final String userType;
  final Function(String) onButton1Pressed;
  final Function(String) onButton2Pressed;
  final Function(String?) onDropdownChanged;

  const Navbar({
    super.key,
    required this.visible,
    required this.userType,
    required this.onButton1Pressed,
    required this.onButton2Pressed,
    required this.onDropdownChanged,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  navigateToPage(
    index,
    pageIndex,
  ) {
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
                )));
  }

  // Dialog for logout
  Future openLogoutDialog() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: LogoutPopup(closeDialog: () => Navigator.pop(context)));
      });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'images/sama_logo.png',
                  height: height / 9,
                  width: width / 6,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Member Portal \n(beta)',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF174486),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Login Button
                // Visibility(
                //   visible: widget.userType == "NonMember",
                //   child: Padding(
                //     padding: const EdgeInsets.only(bottom: 10.0, top: 32.0),
                //     child: LoginButton(
                //         onPressed: () => {
                //               Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                       builder: (context) => Material(
                //                             child: LoginPages(
                //                               pageIndex: 0,
                //                             ),
                //                           )))
                //             }),
                //   ),
                // ),
                // // Register Button
                // Visibility(
                //   visible: widget.userType == "NonMember",
                //   child: RegisterButton(
                //       onPressed: () => {
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => Material(
                //                           child: LoginPages(
                //                             pageIndex: 9,
                //                           ),
                //                         )))
                //           }),
                // ),
                const SizedBox(height: 8),
                // Popup Menu
                Visibility(
                  visible: widget.visible,
                  child: PopupMenuButton<String>(
                    icon: const Icon(Icons.menu),
                    onSelected: (value) {
                      switch (value) {
                        case "Dashboard":
                          navigateToPage(0, 0);
                          break;
                        case "Centre of Excellence":
                          navigateToPage(1, 1);
                          break;
                        case "Media & Webinars":
                          navigateToPage(2, 9);
                          break;
                        case "Professional Development":
                          navigateToPage(19, 19);
                          break;
                        case "E-Store":
                          navigateToPage(6, 14);
                          break;
                        case "Events":
                          navigateToPage(7, 10);
                          break;
                        case "Communities":
                          navigateToPage(8, 16);
                          break;
                        case "Member Benefits":
                          navigateToPage(9, 2);
                          break;
                        case "Branch Voting":
                          navigateToPage(10, 12);
                          break;
                        case "View Profile":
                          navigateToPage(3, 3);
                          break;
                        case "Register":
                          // Navigate to the registration page
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Material(
                                        child: LoginPages(
                                          pageIndex: 9,
                                        ),
                                      )));
                          break;
                        case "Login":
                          // Navigate to the login page
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Material(
                                        child: LoginPages(
                                          pageIndex: 0,
                                        ),
                                      )));
                          break;
                        case "logout":
                          openLogoutDialog();
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      List<PopupMenuEntry<String>> menuItems = [
                        {
                          'image': 'images/icon_dashboard.svg',
                          'text': 'Dashboard'
                        },
                        {
                          'image': 'images/icon_centre_of.svg',
                          'text': 'Centre of Excellence'
                        },
                        {
                          'image': 'images/icon_media.svg',
                          'text': 'Media & Webinars'
                        },
                        {
                          'image': 'images/icon_prof_dev.svg',
                          'text': 'Professional Development'
                        },
                        {'image': 'images/icon_estore.svg', 'text': 'E-Store'},
                        {'image': 'images/icon_events.svg', 'text': 'Events'},
                        {
                          'image': 'images/icon_categories.svg',
                          'text': 'Communities'
                        },
                        {
                          'image': 'images/icon_benefits.svg',
                          'text': 'Member Benefits'
                        },
                        {
                          'image': 'images/icon_voting.svg',
                          'text': 'Branch Voting'
                        },
                      ].map((item) {
                        return PopupMenuItem<String>(
                          value: item['text'] as String,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                item['image'] as String,
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(item['text'] as String),
                            ],
                          ),
                        );
                      }).toList();

                      // Add Register/View Profile button based on userType
                      menuItems.add(
                        PopupMenuItem<String>(
                          value: widget.userType == "NonMember"
                              ? 'Register'
                              : 'View Profile',
                          child: Container(
                            width: double.infinity,
                            color: CustomColors.yellow,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Text(
                                widget.userType == "NonMember"
                                    ? 'REGISTER'
                                    : 'VIEW PROFILE',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      );

                      // Add Login/Logout button based on userType
                      menuItems.add(
                        PopupMenuItem<String>(
                          value: widget.userType == "NonMember"
                              ? 'Login'
                              : 'logout',
                          child: Container(
                            width: double.infinity,
                            color: CustomColors.blue,
                            // Adjust color for logout if needed
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Text(
                                widget.userType == "NonMember"
                                    ? 'LOGIN'
                                    : 'LOGOUT',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );

                      return menuItems;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
