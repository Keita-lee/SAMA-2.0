import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/member/professionalDevelopment/ui/quizQuestions/quizProgressNumbers.dart';
import 'package:sama/member/professionalDevelopment/ui/quizQuestions/quizQuestion.dart';
import 'package:sama/member/professionalDevelopment/ui/simpleQuizTextStyle.dart';

class QuizReview extends StatefulWidget {
  List questionAnswers;
  int attempt;
  QuizReview({super.key, required this.questionAnswers, required this.attempt});

  @override
  State<QuizReview> createState() => _QuizReviewState();
}

class _QuizReviewState extends State<QuizReview> {
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

  //goToNextQuestion
  nextQuestion() {
    setState(() {
      if (questionIndex != (widget.questionAnswers.length - 1)) {
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

//check if already answered question
  checkIfQuestionAnswered(questionNumber) {
    return true;
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
                'QUIZ REVIEW',
                style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                'Reviewing Answers from Attempt ${widget.attempt}',
                style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
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
              for (int j = 0; j < widget.questionAnswers.length; j++)
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
          /*   const SizedBox(
            height: 40,
          ),
          QuizQuestion(
            questionNumber: '${questionIndex + 1}',
            question: questions[questionIndex]['questionToBeAsked'],
          ),*/
          const SizedBox(
            height: 20,
          ),
          //  for (int j = 0; j < (widget.questionAnswers).length; j++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuizQuestion(
                  question: widget.questionAnswers[questionIndex]['question'],
                  questionNumber: widget.questionAnswers[questionIndex]
                          ['questionNumber']
                      .toString()),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MyUtility(context).width * 0.55,
                  child: SimpleQuizTextStyle(
                      text:
                          '${widget.questionAnswers[questionIndex]['letter']}.  ${widget.questionAnswers[questionIndex]['answerValue']}')),
              const SizedBox(
                height: 20,
              ),
            ],
          ),

          /*      for (int j = 0;
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
          */
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
