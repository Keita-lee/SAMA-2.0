import 'package:flutter/material.dart';
import 'package:sama/Login/forgotUserName.dart';
import 'package:sama/Login/loginPages/accesDenied.dart';
import 'package:sama/Login/loginPages/enterNewPassword.dart';
import 'package:sama/Login/loginPages/loginWithEmail.dart';
import 'package:sama/Login/loginPages/loginWithPassword.dart';
import 'package:sama/Login/loginPages/register.dart';
import 'package:sama/Login/loginPages/resetPassword.dart';
import 'package:sama/Login/loginPages/sendUsername.dart';
import 'package:sama/Login/loginPages/validateByEmail.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/homePage/PostLoginLandingPage.dart';
import 'package:sama/login/loginPages/choosePassword.dart';
import 'package:sama/login/loginPages/displayUsername.dart';
import 'package:sama/login/loginPages/getUserName.dart';
import 'package:sama/login/loginPages/tempView.dart';
import 'package:sama/login/loginPages/validateByEmailOtp.dart';
import 'package:sama/login/loginPages/validateByMobile.dart';
import 'package:sama/login/loginPages/validateByMobileGetUsername.dart';
import 'package:google_fonts/google_fonts.dart';

import 'membershipCategory/membershipSignup.dart';

class LoginPages extends StatefulWidget {
  final int? pageIndex;
  LoginPages({super.key, this.pageIndex});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  String? email;
  String? mobileNumber;
  String? emailChangeType;
  int pageIndex = 0;

//set email state
  getEmail(value) {
    setState(() {
      email = value;
    });
  }

//set mobilenumber state
  getMobileNumber(value) {
    setState(() {
      mobileNumber = value;
    });
  }

//set email change type
  getEmailChangeType(value) {
    setState(() {
      emailChangeType = value;
    });
  }

  // Change pages for login
  changePage(index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  void initState() {
    pageIndex = widget.pageIndex ?? 0;
    super.initState();
  }

  Widget build(BuildContext context) {
    bool showRegisterBorder = false;
    // pages to go to
    var pages = [
      LoginWithEmail(changePage: changePage, getEmail: getEmail),
      LoginWithPassword(
        changePage: changePage,
        email: email,
      ),
      ResetPassword(
        changePage: changePage,
        getEmail: getEmail,
        getEmailChangeType: getEmailChangeType,
      ),
      ValidateByMobileOtp(changePage: changePage, email: email),
      ForgotUserName(changePage: changePage),
      EnterNewPassword(changePage: changePage, email: email),
      SendUsername(changePage: changePage),
      ValidateByEmail(changePage: changePage),
      AccessDenied(changePage: changePage),
      Register(
          changePage: changePage,
          getEmailChangeType: getEmailChangeType,
          getEmail: getEmail),
      ChoosePassword(changePage: changePage),
      GetUsername(
          changePage: changePage,
          getEmail: getEmail,
          getMobileNumber: getMobileNumber,
          getEmailChangeType: getEmailChangeType),
      ValidateByMobileGetUsername(
        mobileNumber: mobileNumber,
        changePage: changePage,
      ),
      DisplayUsername(changePage: changePage, mobileNumber: mobileNumber),
      ValidateByEmailOtp(
          changePage: changePage,
          email: email,
          emailChangeType: emailChangeType),
      MembershipSignUp(),
      TempView(type: "Registration"),
      TempView(type: "Login"),
      MembershipSignUp(
        pageIndex: 3,
      ),
    ];

    return Container(
      color: Color(0xFFF8FAFF),
      width: MyUtility(context).width,
      height: MyUtility(context).height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MyUtility(context).height * 0.02,
            ),
            SizedBox(
              width: MyUtility(context).width / 1.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image(
                          width: MyUtility(context).width / 10,
                          height: MyUtility(context).height / 8.0,
                          image: AssetImage('images/sama_logo.png')),
                      Text(
                        "SAMA Member Portal",
                        style: GoogleFonts.openSans(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Material(
                                    child: Material(
                                        child: PostLoginLandingPage(
                                      userId: "",
                                      activeIndex: 0,
                                    )),
                                  )));
                    },
                    onHover: (hovered) {
                      setState(() {
                        showRegisterBorder = hovered;
                      });
                    },
                    child: Text(
                      "Visit the website",
                      style: TextStyle(
                          decoration: showRegisterBorder == true
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          decorationColor: Color.fromRGBO(0, 159, 158, 1),
                          decorationThickness: 2,
                          fontSize: 16,
                          color: const Color.fromRGBO(0, 159, 158, 1)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: MyUtility(context).width / 1.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: StyleButton(
                      description: pageIndex == 9 ? "LOGIN" : "REGISTER",
                      height: 50,
                      buttonColor: Color.fromRGBO(0, 159, 158, 1),
                      width: 130,
                      onTap: () {
                        if (pageIndex == 9) {
                          changePage(16);
                        } else {
                          changePage(17);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: MyUtility(context).width / 1.5,
                  //height: MyUtility(context).height / 1.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ), // Straighten the bottom corners
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1.0,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 35, bottom: 45),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MyUtility(context).width * 0.04,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MyUtility(context).width / 1.5 -
                                  MyUtility(context).width / 15,
                              // height: MyUtility(context).height / 1.8,
                              child: Center(
                                child: pages[pageIndex],
                              ),
                            ),
                            SizedBox(
                              height: MyUtility(context).height * 0.02,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  child: Image.asset(
                    'images/bannerBackground.jpg',
                    width: MyUtility(context).width / 1.5,
                    height: MyUtility(context).height * 0.04,
                    fit: BoxFit.cover,
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
