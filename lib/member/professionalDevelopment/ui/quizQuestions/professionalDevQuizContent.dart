import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/member/professionalDevelopment/ui/quizQuestions/quizAnswer.dart';
import 'package:sama/member/professionalDevelopment/ui/quizQuestions/quizProgressNumbers.dart';
import 'package:sama/member/professionalDevelopment/ui/quizQuestions/quizQuestion.dart';

import '../../../../components/myutility.dart';

class ProfessionalDevQuizContent extends StatefulWidget {
  final Function(List<dynamic>, int) getQuestionAnswers;
  final String attemptNumber;
  final cpdId;
  const ProfessionalDevQuizContent({
    super.key,
    required this.getQuestionAnswers,
    required this.attemptNumber,
    required this.cpdId,
  });

  @override
  State<ProfessionalDevQuizContent> createState() =>
      _ProfessionalDevQuizContentState();
}

class _ProfessionalDevQuizContentState
    extends State<ProfessionalDevQuizContent> {
  //var
  List questions = [];
  int questionsAmount = 0;
  int questionIndex = 0;
  List questionAnswers = [];
//map number question to letters
  var myMapName = {
    1: "a",
    2: "b",
    3: "c",
    4: "d",
    5: "e",
    6: "f",
    7: "g",
    8: "d"
  };

//get all cpd questions from firestore
  getAllQuestions() async {
    final doc = await FirebaseFirestore.instance
        .collection('cpd')
        .doc(widget.cpdId)
        .get();

    if (doc.exists) {
      setState(() {
        questions.addAll(doc.get('questions'));
        questionsAmount = (questions).length;
      });
    }
  }

  //goToNextQuestion
  nextQuestion() {
    setState(() {
      if (questionIndex != (questionsAmount - 1)) {
        questionIndex++;
      } else {
        questionIndex = 0;
      }
    });
  }

// go back a question
  prevQuestion() {
    setState(() {
      questionIndex--;
    });
  }

  //add value to question answer list
  addToQuestionAnswers(value) {
    var index = (questionAnswers).indexWhere(
        (item) => item["questionNumber"] == value['questionNumber']);
    setState(() {
      if (index != -1) {
        questionAnswers.removeAt(index);
        questionAnswers.insert(index, value);
      } else {
        questionAnswers.add(value);
      }
    });
    widget.getQuestionAnswers(questionAnswers, questionsAmount);
  }

//check if already answered question
  checkIfQuestionAnswered(questionNumber) {
    var index = (questionAnswers)
        .indexWhere((item) => item["questionNumber"] == questionNumber);

    if (index != -1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    getAllQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width * 0.68,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'QUIZ',
                style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Attempt ${widget.attemptNumber}',
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Questions',
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Wrap(
            children: [
              for (int j = 0; j < questions.length; j++)
                QuizProgressNumbers(
                  changeQuestion: () {
                    setState(() {
                      questionIndex = j;
                    });
                  },
                  questionNumber: (j + 1).toString(),
                  isFinished: checkIfQuestionAnswered,
                ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          QuizQuestion(
            questionNumber: '${questionIndex + 1}',
            question: questions[questionIndex]['questionToBeAsked'],
          ),
          const SizedBox(
            height: 20,
          ),
          for (int j = 0;
              j < questions[questionIndex]['answerOptions'].length;
              j++)
            QuizAnswer(
              questionToBeAsked: questions[questionIndex]['questionToBeAsked'],
              questionAnswers: questionAnswers,
              questionLetter: '${myMapName[j + 1]}',
              question: questions[questionIndex]['answerOptions'][j]
                  ['answerValue'],
              addToQuestionAnswers: () {
                addToQuestionAnswers({
                  "letter": myMapName[j + 1],
                  "questionNumber": questionIndex + 1,
                  "question": questions[questionIndex]['questionToBeAsked'],
                  "answerValue": questions[questionIndex]['answerOptions'][j]
                      ['answerValue'],
                  "questionCorrect": questions[questionIndex]['answerOptions']
                      [j]['answerTrueFalse'],
                });
              },
              questionNumber: questionIndex + 1,
            ),
          /* */
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: questionIndex != 0,
                child: StyleButton(
                    fontSize: 13,
                    description: 'Go Back',
                    height: 40,
                    width: 130,
                    buttonTextColor: Colors.white,
                    buttonColor: Color.fromRGBO(0, 159, 159, 1),
                    onTap: () {
                      prevQuestion();
                    }),
              ),
              StyleButton(
                  fontSize: 13,
                  description: questionIndex != (questionsAmount - 1)
                      ? 'Next'
                      : "Complete Quiz",
                  height: 40,
                  width: 130,
                  buttonTextColor: Colors.white,
                  buttonColor: Color.fromRGBO(0, 159, 159, 1),
                  onTap: () {
                    nextQuestion();
                  }),
            ],
          )
        ],
      ),
    );
  }
}
