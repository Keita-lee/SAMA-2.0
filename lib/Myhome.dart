import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/pageUnderContruction.dart';

import 'package:sama/login/loginPages.dart';
import 'package:sama/login/membershipCategory/membershipSignup.dart';

import 'homePage/PostLoginLandingPage.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    var width = MyUtility(context).width;
    return Stack(children: <Widget>[
      Center(
          child: MyUtility(context).width < 600
              ? Material(child: PageUnderConstruction())
              : PostLoginLandingPage(
                  userId: "",
                  activeIndex: 0,
                )),
    ]);
  }
}
