import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/professionalDevelopment/professionalDevelopmentMainCon.dart';
import 'package:sama/member/professionalDevelopment/ui/professionalDevelopmentDisplayItem.dart';

class UserCpdList extends StatefulWidget {
  Function(int) changePageIndex;
  final Function(CourseModel) setSelectedCourse;
  UserCpdList(
      {super.key,
      required this.changePageIndex,
      required this.setSelectedCourse});

  @override
  State<UserCpdList> createState() => _UserCpdListState();
}

class _UserCpdListState extends State<UserCpdList> {
  //var
  var cpdAssessmentsList = [];
  var cpdAssessmentUserDetails = [];

//build cpd assesment list
  buildCpdList(cpdId) async {
    final snapShot =
        await FirebaseFirestore.instance.collection('cpd').doc(cpdId).get();

    if (snapShot.exists) {
      setState(() {
        cpdAssessmentsList.add(snapShot.data());
      });
    }
  }

  getUserCpd() async {
    final snapShot = await FirebaseFirestore.instance
        .collection('cpdUserData')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (snapShot.exists) {
      setState(() {
        //cpdAssessmentUserDetails.addAll(snapShot.get('cpdAssessments'));
        for (var i = 0; i < (snapShot.get('cpdAssessments')).length; i++) {
          buildCpdList((snapShot.get('cpdAssessments'))[i]['cpdId']);
        }
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
        for (var i = 0; i < cpdAssessmentsList.length; i++)
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: professionalDevelopmentDisplayItem(
                imageUrl: cpdAssessmentsList[i]['cpdImage'],
                title: cpdAssessmentsList[i]['title'],
                cpdPoints: "3.0 Clinical Point",
                level: "Level 2",
                subDescription: cpdAssessmentsList[i]['subDescription'],
                course: CourseModel(
                  id: cpdAssessmentsList[i]['id'],
                  imageUrl: cpdAssessmentsList[i]['cpdImage'],
                  title: cpdAssessmentsList[i]['title'],
                  cpdPoints: cpdAssessmentsList[i]['subDescription'],
                  level: cpdAssessmentsList[i]['subDescription'],
                ),
                onPressed: (CourseModel) {
                  widget.setSelectedCourse(CourseModel);
                  widget.changePageIndex(1);
                },
                startAssessment: ""),
          )
      ],
    );
  }
}
