import 'package:flutter/material.dart';
import 'package:sama/PostLoginLandingPage.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/pageUnderContruction.dart';
import 'package:sama/components/userState.dart';
import 'package:sama/login/loginPages.dart';
import 'package:sama/login/membershipCategory/memberCategory.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    var width = MyUtility(context).width;
    return Scaffold(
      body: Center(child: width < 800 ? PageUnderConstruction() : LoginPages()),
    );
  }
}


// LoginPages()