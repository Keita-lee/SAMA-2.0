import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sama/Login/loginPages.dart';
import 'package:sama/PostLoginLandingPage.dart';


class UserState extends StatefulWidget {
  const UserState({super.key});

  @override
  State<UserState> createState() => _UserStateState();
}

class _UserStateState extends State<UserState> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.data == null) {
            print('Insert Login Details');
            return const LoginPages();
          } else if (userSnapshot.hasData) {
            print('Insert Login Detail123123s');
            User? user = FirebaseAuth.instance.currentUser;
// user logged in

            return PostLoginLandingPage(userId: user!.uid);
          } else if (userSnapshot.hasError) {
            print('error on snapshot');
          } else if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          User? user = FirebaseAuth.instance.currentUser;
// user logged in

          return PostLoginLandingPage(userId: user!.uid);
        });
  }
}
