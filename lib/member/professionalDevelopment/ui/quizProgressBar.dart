import 'package:flutter/material.dart';

class QuizProgressBar extends StatefulWidget {
  const QuizProgressBar({super.key});

  @override
  State<QuizProgressBar> createState() => _QuizProgressBarState();
}

class _QuizProgressBarState extends State<QuizProgressBar> {
  int totalQuestions = 10; // Total number of questions in the quiz
  int answeredQuestions = 3; // Number of questions answered so far

  @override
  Widget build(BuildContext context) {
    double progress = answeredQuestions / totalQuestions;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        
        LinearProgressIndicator(
          borderRadius: BorderRadius.circular(20),
          minHeight: 15,
          value: progress,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(237, 157, 4, 1)),
        ),
        FloatingActionButton(
          onPressed: () {
            setState(() {
              if (answeredQuestions < totalQuestions) {
                answeredQuestions++;
              }
            });
          },
          child: Icon(Icons.add),
        ),
      ],
    );
  }
}
