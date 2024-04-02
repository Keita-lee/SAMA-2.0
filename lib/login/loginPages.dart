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
import 'package:sama/Login/loginPages/validateByMobile.dart';
import 'package:sama/components/myutility.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({super.key});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  String? email;
  int pageIndex = 0;

//set email state
  getEmail(value) {
    setState(() {
      email = value;
    });
  }

  // Change pages for login
  changePage(index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // pages to go to
    var pages = [
     
      LoginWithEmail(changePage: changePage, getEmail: getEmail),
      LoginWithPassword(changePage: changePage, email: email),
      ResetPassword(changePage: changePage, getEmail: getEmail),
      ValidateByMobile(changePage: changePage, email: email),
      ForgotUserName(changePage: changePage),
      EnterNewPassword(changePage: changePage, email: email),
      SendUsername(changePage: changePage),
      ValidateByEmail(changePage: changePage),
      AccessDenied(changePage: changePage),
      Register(changePage: changePage)
    ];

    return Container(
      color: const Color.fromARGB(255, 8, 55, 145),
      width: MyUtility(context).width,
      height: MyUtility(context).height,
      child: Center(
        child: Container(
            width: MyUtility(context).width / 1.5,
            height: MyUtility(context).height / 1.2,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Column(
              children: [
                Row(
                  children: [
                    Visibility(
                        visible: pageIndex == 9 ? false : true,
                        child: Image(
                            width: pageIndex == 9
                                ? MyUtility(context).width / 1.5
                                : MyUtility(context).width / 4,
                            height: MyUtility(context).height / 3.5,
                            image: AssetImage('imges/sama_logo.png'))),
                    SizedBox(
                      width: pageIndex == 9
                          ? MyUtility(context).width / 1.5
                          : MyUtility(context).width / 1.5 -
                              MyUtility(context).width / 4,
                      height: MyUtility(context).height / 1.2,
                      child: Center(
                        child: pages[pageIndex],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
