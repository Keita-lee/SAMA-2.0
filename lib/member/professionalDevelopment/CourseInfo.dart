import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/login/loginPages/nonMemberSignup.dart';
import 'package:sama/member/professionalDevelopment/professionalDevelopmentMainCon.dart';
import 'package:sama/member/professionalDevelopment/ui/courseInfoContainer.dart';

import '../../components/styleButton.dart';
import 'ui/gradeRequiredCon.dart';

class CourseInfo extends StatefulWidget {
  final CourseModel course;
  String userType;
  bool isAccessed;
  CourseInfo(
      {super.key,
      required this.course,
      required this.userType,
      required this.isAccessed});

  @override
  State<CourseInfo> createState() => _CourseInfoState();
}

class _CourseInfoState extends State<CourseInfo> {
  Future openMemberSignUp() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: NonMemberSignUp(
          closeDialog: () => Navigator.pop(context),
        ));
      });

  @override
  Widget build(BuildContext context) {
    String title = widget.course.title;
    return Container(
      width: MyUtility(context).width,
      height: 1000,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Color(0xFF3D3D3D),
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          /*  CourseInfoContainer(
            isAccessed: false,
            accreditationOrg: 'Health Professions Council of South Africa',
            accreditationId: 'MDB015/MPDP/038/206',
            accreditationPoints: '3 Clinical',
            courseImage: 'images/sama_logo.png',
            allowedAttempts: '2',
            passRate: '70',
            userType: 'NonMember',
            nonMemberPrice: 'R1500 inc VAT',
          ),*/
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageNetwork(
                fitWeb: BoxFitWeb.contain,
                image: widget.course.imageUrl,
                width: MyUtility(context).width / 6,
                height: MyUtility(context).height / 4,
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Accreditation\n',
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            TextSpan(
                              text:
                                  'Health Professions Council of South Africa\n',
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.normal, fontSize: 15),
                            ),
                            TextSpan(
                              text: 'MDB015/MPDP/038/206',
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.normal, fontSize: 15),
                            ),
                            TextSpan(
                              text: '3 Clinical',
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.normal, fontSize: 15),
                            ),
                            TextSpan(
                              text: '\n\nCertification\n',
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            TextSpan(
                              text: 'Attempts allowed:2\n',
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.normal, fontSize: 15),
                            ),
                            TextSpan(
                              text: '70% pass rate',
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.normal, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Visibility(
                        visible: FirebaseAuth.instance.currentUser == null,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            //    Spacer(),
                            StyleButton(
                                buttonColor: Colors.teal,
                                description: 'Get Cpd Access',
                                height: 40,
                                width: 110,
                                onTap: () {
                                  openMemberSignUp();
                                }),
                            /*   const SizedBox(
                              height: 10,
                            ),
                            StyleButton(
                                description: 'Purchase Token',
                                height: 40,
                                width: 110,
                                onTap: () {}),*/
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              //   Spacer(),
              Visibility(
                visible: widget.isAccessed == true,
                child: GradeRequiredCon(
                  requiredCorrectQuestions: 2,
                  questionAmmount: 3,
                  requiredGradePercentage: 70,
                  attemptNumber: '1',
                  grade: '5',
                  failedAttemptScorePercentage: 25,
                  onTapReviewFailed: () {
                    //ADD LOGIC
                  },
                  isQuizInProgress: false,
                  isAttemptPending: true,
                  takeQuizFunction: () {},
                ),
              ),
              Visibility(
                visible: FirebaseAuth.instance.currentUser != null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    StyleButton(
                        buttonColor: Colors.teal,
                        description: 'Access',
                        height: 40,
                        width: 110,
                        onTap: () {})
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            'Introduction',
            style: TextStyle(
                color: Color(0xFF3D3D3D),
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
