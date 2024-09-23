import 'package:flutter/material.dart';

class QuizProgressBar extends StatefulWidget {
  int questionAnswers;
  int questionLength;
  QuizProgressBar(
      {super.key, required this.questionAnswers, required this.questionLength});

  @override
  State<QuizProgressBar> createState() => _QuizProgressBarState();
}

class _QuizProgressBarState extends State<QuizProgressBar> {
  int totalQuestions = 10; // Total number of questions in the quiz
  int answeredQuestions = 0; // Number of questions answered so far

  @override
  Widget build(BuildContext context) {
    double progress = widget.questionAnswers / widget.questionLength;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        LinearProgressIndicator(
          borderRadius: BorderRadius.circular(20),
          minHeight: 15,
          value: progress,
          backgroundColor: Colors.grey[300],
          valueColor:
              AlwaysStoppedAnimation<Color>(Color.fromRGBO(237, 157, 4, 1)),
        ), /**/
      ],
    );
  }
}
