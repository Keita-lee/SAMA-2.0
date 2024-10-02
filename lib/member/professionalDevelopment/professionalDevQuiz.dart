import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/service/commonService.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/member/professionalDevelopment/ui/myCPDdisplayItem.dart';
import 'package:sama/member/professionalDevelopment/ui/quizQuestions/professionalDevQuizContent.dart';
import 'package:sama/member/professionalDevelopment/ui/quizProgressBar.dart';
import 'package:sama/member/professionalDevelopment/ui/quizQuestions/quizReview.dart';
import 'package:sama/member/professionalDevelopment/ui/results/quizEndResults.dart';
import 'package:sama/member/professionalDevelopment/ui/yourQuizAnswers/yourAnswers.dart';
import 'package:url_launcher/url_launcher.dart';

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
  String journalLink = "";
  String grade = "";
  int attemptsLeft = 0;
  int attemptNumber = 0;
  List reviewList = [];
  List cpdAssessments = [];

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
    if ((correctAmountAnswers / questionLength) * 100 >= 70) {
      setState(() {
        passedValue = "PASSED";
      });
    }

    return '${correctAmountAnswers}/ ${questionLength} ( ${((correctAmountAnswers / questionLength) * 100).toStringAsFixed(2)} % )';
  }

  getPreviousListData(questionAnswersValue, attemptNumberValue) {
    setState(() {
      print("TEST");
      print(questionAnswersValue);
      questionAnswers.addAll(questionAnswersValue);
      attemptNumber = attemptNumberValue;
      quizStatus = "REVIEWQUIZ";
    });
  }

  getAttempsOnQuiz() async {
    final doc = await FirebaseFirestore.instance
        .collection('cpdUserData')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (doc.exists) {
      setState(() {
        cpdAssessments.addAll(doc.get('cpdAssessments'));
        var cpdIndex = (doc.get('cpdAssessments'))
            .indexWhere((item) => item["cpdId"] == widget.course.id);

        if (cpdIndex != -1) {
          attemptsLeft = doc.get('cpdAssessments')[cpdIndex]['attempts'];
          grade = doc.get('cpdAssessments')[cpdIndex]['grade'];
          reviewList = doc.get('cpdAssessments')[cpdIndex]['reviewList'];
        }
      });
    }
  }

  //get all cpd questions from firestore
  getCpdInformation() async {
    final doc = await FirebaseFirestore.instance
        .collection('cpd')
        .doc(widget.course.id)
        .get();

    if (doc.exists) {
      setState(() {
        questionLength = (doc.get('questions')).length;
        journalLink = doc.get('journalLink');
      });
    }
  }

  //update user cpd attemps
  updateCpdAttempts() async {
    var reviewData = {
      "attempt": "${attemptsLeft == 2 ? '1' : '2'}",
      "passedValue": passedValue,
      "grade": getGradeForQuestions(),
      "dateAttempt": CommonService().getTodaysDateText(),
      "answerList": questionAnswers,
    };

    var cpdIndex = (cpdAssessments)
        .indexWhere((item) => item["cpdId"] == widget.course.id);
    cpdAssessments[cpdIndex]['attempts'] = attemptsLeft - 1;
    cpdAssessments[cpdIndex]['reviewList'].add(reviewData);

    final doc = await FirebaseFirestore.instance
        .collection('cpdUserData')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"cpdAssessments": cpdAssessments});
  }

  @override
  void initState() {
    getCpdInformation();
    getAttempsOnQuiz();
    super.initState();
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
              questionLength: questionLength,
              attemptsLeft: attemptsLeft,
              grade: grade,
              takeQuiz: () {
                setState(() {
                  quizStatus = "QUIZ";
                });
              },
              quizStatus: quizStatus,
              reviewList: reviewList,
              reviewQuiz: getPreviousListData,
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
                      description: '3. SUBMIT ATTEMPT',
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
                  onTap: () {
                    final Uri url = Uri.parse(journalLink);

                    launchUrl(url);
                  }),
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
                attemptNumber: attemptsLeft == 2 ? '1' : '2',
                cpdId: widget.course.id,
              ),
            ),
            Visibility(
              visible: quizStatus == "SUBMIT ATTEMPT",
              child: YourAnswers(
                  attemptNumber: attemptsLeft == 2 ? '1' : '2',
                  questionAnswers: questionAnswers,
                  finalSubmit: () {
                    setState(() {
                      quizStatus = "SUBMIT ATTEMPT FINAL";
                      updateCpdAttempts();
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
                      cpdPoints: '3.0 Clinical'),
                ],
              ),
            ),
            Visibility(
                visible: quizStatus == "REVIEWQUIZ",
                child: QuizReview(
                  questionAnswers: questionAnswers,
                  attempt: attemptNumber,
                ))
          ],
        ),
      ),
    );
  }
}
