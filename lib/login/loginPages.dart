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
import 'package:sama/login/loginPages/choosePassword.dart';
import 'package:sama/login/loginPages/displayUsername.dart';
import 'package:sama/login/loginPages/getUserName.dart';
import 'package:sama/login/loginPages/validateByEmailOtp.dart';
import 'package:sama/login/loginPages/validateByMobile.dart';
import 'package:sama/login/loginPages/validateByMobileGetUsername.dart';

class LoginPages extends StatefulWidget {
  LoginPages({super.key});

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
    super.initState();
  }

  Widget build(BuildContext context) {
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
          emailChangeType: emailChangeType)
    ];

    return Container(
      color: const Color.fromARGB(255, 8, 55, 145),
      width: MyUtility(context).width,
      height: MyUtility(context).height,
      child: Transform.scale(
        scale: 0.8,
        child: Center(
          child: Container(
            width: MyUtility(context).width / 1.5,
            height: MyUtility(context).height / 1.2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image(
                        width: MyUtility(context).width / 4,
                        height: MyUtility(context).height / 3.5,
                        image: AssetImage('images/sama_logo.png')),
                    SizedBox(
                      width: MyUtility(context).width / 1.5 -
                          MyUtility(context).width / 4,
                      height: MyUtility(context).height / 1.2,
                      child: Center(
                        child: pages[pageIndex],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
