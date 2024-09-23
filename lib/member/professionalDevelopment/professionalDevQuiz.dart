import 'package:flutter/material.dart';
import 'package:sama/components/service/commonService.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/member/professionalDevelopment/ui/myCPDdisplayItem.dart';
import 'package:sama/member/professionalDevelopment/ui/quizQuestions/professionalDevQuizContent.dart';
import 'package:sama/member/professionalDevelopment/ui/quizProgressBar.dart';
import 'package:sama/member/professionalDevelopment/ui/results/quizEndResults.dart';
import 'package:sama/member/professionalDevelopment/ui/yourQuizAnswers/yourAnswers.dart';

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
      required this.isResultsScreen,
      required this.hasPassed});

  @override
  State<ProfessionalDevQuiz> createState() => _ProfessionalDevQuizState();
}

class _ProfessionalDevQuizState extends State<ProfessionalDevQuiz> {
  //var
  var quizStatus = "READ ISSUE";
  List questionAnswers = [];

  int questionLength = 0;
  String passedValue = "FAILED";

// set state of question list
  getQuestionAnswers(value, questionLengthAmount) {
    setState(() {
      questionAnswers = value;
      questionLength = questionLengthAmount;
    });
  }

  getGradeForQuestions() {
    print(questionAnswers);
    int correctAmountAnswers = 0;
    for (int j = 0; j < questionAnswers.length; j++) {
      if (questionAnswers[j]['questionCorrect'] == true) {
        print("true");
        correctAmountAnswers++;
      }
    }
    if (correctAmountAnswers < 0) {
      correctAmountAnswers = 0;
    }
    if ((correctAmountAnswers / questionLength).roundToDouble() * 100 >= 70) {
      setState(() {
        passedValue = "PASSED";
      });
    }
    return '${correctAmountAnswers}/ ${questionLength} ( ${(correctAmountAnswers / questionLength).roundToDouble() * 100} % )';
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.course.title;
    return SizedBox(
      width: MyUtility(context).width * 0.68,
      height: MyUtility(context).height,
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
            Visibility(
                visible: quizStatus == "QUIZ" && questionAnswers.length >= 1,
                child: QuizProgressBar(
                    questionAnswers: questionAnswers.length,
                    questionLength: questionLength)),
            const SizedBox(
              height: 40,
            ),
            Visibility(
              visible: quizStatus != "SUBMIT ATTEMPT FINAL",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  StyleButton(
                      buttonColor: Color.fromRGBO(24, 69, 126, 1),
                      description: '1. READ ISSUE',
                      height: 50,
                      fontSize: 13,
                      width: 210,
                      onTap: () {
                        setState(() {
                          quizStatus = "READ ISSUE";
                        });
                      }),
                  const SizedBox(
                    width: 30,
                  ),
                  StyleButton(
                      buttonColor: Color.fromRGBO(24, 69, 126, 1),
                      description: '2. QUIZ',
                      height: 50,
                      fontSize: 13,
                      width: 210,
                      onTap: () {
                        setState(() {
                          quizStatus = "QUIZ";
                        });
                      }),
                  const SizedBox(
                    width: 30,
                  ),
                  StyleButton(
                      buttonColor: Color.fromRGBO(24, 69, 126, 1),
                      description: '1. SUBMIT ATTEMPT',
                      height: 50,
                      fontSize: 13,
                      width: 210,
                      onTap: () {
                        setState(() {
                          quizStatus = "SUBMIT ATTEMPT";
                        });
                      }),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Visibility(
              visible: quizStatus == "READ ISSUE",
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

            /**/

            Visibility(
              visible: quizStatus == "QUIZ",
              child: ProfessionalDevQuizContent(
                getQuestionAnswers: getQuestionAnswers,
                attemptNumber: '1',
                cpdId: widget.course.id,
              ),
            ),
            Visibility(
              visible: quizStatus == "SUBMIT ATTEMPT",
              child: YourAnswers(
                  attemptNumber: '1',
                  questionAnswers: questionAnswers,
                  finalSubmit: () {
                    setState(() {
                      quizStatus = "SUBMIT ATTEMPT FINAL";
                    });
                  }),
            ),
            Visibility(
              visible: quizStatus == "SUBMIT ATTEMPT FINAL",
              child: Column(
                children: [
                  Row(
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
                        visible: passedValue == "PASSED",
                        child: StyleButton(
                            buttonColor: Color.fromRGBO(239, 81, 34, 1),
                            description: 'PASSED',
                            height: 50,
                            fontSize: 13,
                            width: 210,
                            onTap: () {}),
                      ),
                      Visibility(
                        visible: passedValue != "PASSED",
                        child: StyleButton(
                            buttonTextColor: Colors.black,
                            buttonColor:
                                const Color.fromARGB(255, 185, 185, 185),
                            description: 'FAILED',
                            height: 50,
                            fontSize: 14,
                            width: 210,
                            onTap: () {}),
                      ),
                    ],
                  ),
                  QuizEndResults(
                      hasPassed: passedValue == "PASSED",
                      dateCompleted: CommonService().getTodaysDateText(),
                      grade: getGradeForQuestions(),
                      cpdPoints: '3.0 Clinical')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
