import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/member/professionalDevelopment/ui/gradeRequiredCon.dart';

import '../../../components/myutility.dart';

class CourseInfoContainer extends StatefulWidget {
  final String courseImage;
  final String accreditationOrg;
  final String accreditationId;
  final String accreditationPoints;
  final String passRate;
  final String allowedAttempts;
  final String userType;
  final String nonMemberPrice;
  final bool isAccessed;
  final int questionLength;
  final int attemptsLeft;
  final String grade;
  final VoidCallback takeQuiz;
  final String quizStatus;
  final List reviewList;
  final Function(List, int) reviewQuiz;

  const CourseInfoContainer(
      {super.key,
      required this.courseImage,
      required this.accreditationOrg,
      required this.accreditationId,
      required this.accreditationPoints,
      required this.passRate,
      required this.allowedAttempts,
      required this.userType,
      required this.nonMemberPrice,
      required this.isAccessed,
      required this.questionLength,
      required this.attemptsLeft,
      required this.grade,
      required this.takeQuiz,
      required this.quizStatus,
      required this.reviewList,
      required this.reviewQuiz});

  @override
  State<CourseInfoContainer> createState() => _CourseInfoContainerState();
}

class _CourseInfoContainerState extends State<CourseInfoContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width * 0.68,
      //    height: 500,
      child: Column(
        children: [
          Row(
            children: [
              ImageNetwork(
                fitWeb: BoxFitWeb.contain,
                image: widget.courseImage,
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
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Accreditation\n',
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        TextSpan(
                          text: '${widget.accreditationOrg}\n',
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.normal, fontSize: 15),
                        ),
                        TextSpan(
                          text: '${widget.accreditationId}\n',
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.normal, fontSize: 15),
                        ),
                        TextSpan(
                          text: widget.accreditationPoints,
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.normal, fontSize: 15),
                        ),
                        TextSpan(
                          text: '\n\nCertification\n',
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        TextSpan(
                          text: 'Attempts allowed: ${widget.allowedAttempts}\n',
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.normal, fontSize: 15),
                        ),
                        TextSpan(
                          text: '${widget.passRate}% pass rate',
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.normal, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Visibility(
                visible: widget.isAccessed == true,
                child: GradeRequiredCon(
                  requiredCorrectQuestions:
                      (widget.questionLength * 0.7).toInt(),
                  questionAmmount: widget.questionLength,
                  requiredGradePercentage: 70,
                  attemptNumber: '${widget.attemptsLeft}',
                  grade: widget.grade,
                  failedAttemptScorePercentage: 25,
                  onTapReviewFailed: widget.reviewQuiz,
                  isQuizInProgress: false,
                  isAttemptPending: true,
                  quizStatus: widget.quizStatus,
                  takeQuizFunction: () {
                    widget.takeQuiz();
                  },
                  reviewList: widget.reviewList,
                ),
              ),
              Visibility(
                visible: widget.userType != 'NonMember' &&
                    widget.isAccessed == false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Spacer(),
                    StyleButton(
                        buttonColor: Colors.teal,
                        description: 'Access',
                        height: 40,
                        width: 110,
                        onTap: () {})
                  ],
                ),
              ),
              Visibility(
                visible: widget.userType == 'NonMember' &&
                    widget.isAccessed == false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Spacer(),
                    StyleButton(
                        buttonColor: Colors.teal,
                        description: 'Login to Access',
                        height: 40,
                        width: 110,
                        onTap: () {}),
                    const SizedBox(
                      height: 10,
                    ),
                    StyleButton(
                        description: 'Purchase Token',
                        height: 40,
                        width: 110,
                        onTap: () {}),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.nonMemberPrice,
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
    );
  }
}
