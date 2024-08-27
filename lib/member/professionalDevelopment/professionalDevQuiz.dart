import 'package:flutter/material.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/member/professionalDevelopment/ui/myCPDdisplayItem.dart';
import 'package:sama/member/professionalDevelopment/ui/quizQuestions/professionalDevQuizContent.dart';
import 'package:sama/member/professionalDevelopment/ui/quizProgressBar.dart';
import 'package:sama/member/professionalDevelopment/ui/results/quizEndResults.dart';

import '../../components/myutility.dart';
import 'professionalDevelopmentMainCon.dart';
import 'ui/courseInfoContainer.dart';

class ProfessionalDevQuiz extends StatefulWidget {
  final CourseModel course;
  final bool isResultsScreen;
  final bool isQuizInProgress;
  final bool hasPassed;
  const ProfessionalDevQuiz(
      {super.key,
      required this.course,
      required this.isQuizInProgress,
      required this.isResultsScreen, required this.hasPassed});

  @override
  State<ProfessionalDevQuiz> createState() => _ProfessionalDevQuizState();
}

class _ProfessionalDevQuizState extends State<ProfessionalDevQuiz> {
  @override
  Widget build(BuildContext context) {
    String title = widget.course.title;
    return SizedBox(
      width: MyUtility(context).width * 0.68,
      height: MyUtility(context).height * 0.80,
      child: SingleChildScrollView(
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
            const SizedBox(
              height: 20,
            ),
            CourseInfoContainer(
              isAccessed: true,
              accreditationOrg: 'Health Professions Council of South Africa',
              accreditationId: 'MDB015/MPDP/038/206',
              accreditationPoints: '3 Clinical',
              courseImage: 'images/sama_logo.png',
              allowedAttempts: '2',
              passRate: '70',
              userType: '',
              nonMemberPrice: 'R1500 inc VAT',
            ),
            const SizedBox(
              height: 40,
            ),
            QuizProgressBar(),
            Visibility(
              visible: widget.isResultsScreen == false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  StyleButton(
                      buttonColor: Color.fromRGBO(24, 69, 126, 1),
                      description: '1. READ ISSUE',
                      height: 50,
                      fontSize: 13,
                      width: 210,
                      onTap: () {}),
                  const SizedBox(
                    width: 30,
                  ),
                  StyleButton(
                      buttonColor: Color.fromRGBO(24, 69, 126, 1),
                      description: '2. QUIZ',
                      height: 50,
                      fontSize: 13,
                      width: 210,
                      onTap: () {}),
                  const SizedBox(
                    width: 30,
                  ),
                  StyleButton(
                      buttonColor: Color.fromRGBO(24, 69, 126, 1),
                      description: '1. SUBMIT ATTEMPT',
                      height: 50,
                      fontSize: 13,
                      width: 210,
                      onTap: () {}),
                ],
              ),
            ),
            Visibility(
              visible: widget.isResultsScreen == true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StyleButton(
                      buttonColor: Color.fromRGBO(24, 69, 126, 1),
                      description: 'READ ISSUE',
                      height: 50,
                      fontSize: 13,
                      width: 210,
                      onTap: () {}),
                  Visibility(
                    visible: widget.hasPassed == true,
                    child: StyleButton(
                        buttonColor: Color.fromRGBO(239, 81, 34, 1),
                        description: 'PASSED',
                        height: 50,
                        fontSize: 13,
                        width: 210,
                        onTap: () {}),
                  ),
                  Visibility(
                    visible: widget.hasPassed == false,
                    child: StyleButton(
                      buttonTextColor: Colors.black,
                        buttonColor: const Color.fromARGB(255, 185, 185, 185),
                        description: 'FAILED',
                        height: 50,
                        fontSize: 14,
                        width: 210,
                        onTap: () {}),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Visibility(
              visible: widget.isQuizInProgress,
              child: StyleButton(
                  buttonColor: Colors.teal,
                  description: 'Click to read issue online',
                  height: 50,
                  fontSize: 12,
                  width: 310,
                  onTap: () {}),
            ),
            /*MyCPDdisplayItem(
                image: '',
                productName: 'South African Medical Journal',
                productDetails: '- July 2024 Vol 144 No 7',
                points: '3.0 Clinical Points',
                difficultyLevel: 'Level 2',
                onTap: (){},
                progress: 0.7)*/

             /*QuizEndResults(
              hasPassed: widget.hasPassed,
                 dateCompleted: '19 August 2024',
                 grade: '17/20 (85%)',
                 cpdPoints: '3.0 Clinical')*/

              

             ProfessionalDevQuizContent(
                attemptNumber: '1',
              )
          ],
        ),
      ),
    );
  }
}
