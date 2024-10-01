import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/professionalDevelopment/professionalDevelopmentMainCon.dart';
import 'package:sama/member/professionalDevelopment/ui/professionalDevelopmentDisplayItem.dart';

class UserCpdList extends StatefulWidget {
  const UserCpdList({super.key});

  @override
  State<UserCpdList> createState() => _UserCpdListState();
}

class _UserCpdListState extends State<UserCpdList> {
  //var
  var cpdAssessments = [];
  getUserCpd() async {
    final snapShot = await FirebaseFirestore.instance
        .collection('cpdUserData')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (snapShot.exists) {
      setState(() {
        //cpdAssessments.addAll(snapShot.get('cpdAssessments'));
      });
    }
  }

  @override
  void initState() {
    getUserCpd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return Wrap(
      children: [
        for (var i = 0; i < cpdAssessments.length; i++)
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: professionalDevelopmentDisplayItem(
              imageUrl: cpdAssessments[i]['cpdImage'],
              title: cpdAssessments[i]['title'],
              cpdPoints: "3.0 Clinical Point",
              level: "Level 2",
              subDescription: cpdAssessments[i]['subDescription'],
              course: CourseModel(
                id: cpdAssessments[i]['id'],
                imageUrl: cpdAssessments[i]['cpdImage'],
                title: cpdAssessments[i]['title'],
                cpdPoints: cpdAssessments[i]['subDescription'],
                level: cpdAssessments[i]['subDescription'],
              ),
              onPressed: (CourseModel) {},
            ),
          )
      ],
    );
  }
}
