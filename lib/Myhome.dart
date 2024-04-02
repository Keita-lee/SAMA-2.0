import 'package:flutter/material.dart';
import 'package:sama/PostLoginLandingPage.dart';
import 'package:sama/components/userState.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: UserState()
      ),
    );
  }
}
