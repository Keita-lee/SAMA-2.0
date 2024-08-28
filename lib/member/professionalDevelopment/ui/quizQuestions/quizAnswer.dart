import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/professionalDevelopment/ui/yourQuizAnswers/quizAnswerCheckBox.dart';
import 'package:sama/member/professionalDevelopment/ui/simpleQuizTextStyle.dart';

class QuizAnswer extends StatefulWidget {
  final String questionLetter;
  final String question;
  const QuizAnswer(
      {super.key, required this.questionLetter, required this.question});

  @override
  State<QuizAnswer> createState() => _QuizAnswerState();
}

class _QuizAnswerState extends State<QuizAnswer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: MyUtility(context).width * 0.60,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
      
        children: [
          QuizAnswerCheckBox(),
          const SizedBox(width: 20,),
          SimpleQuizTextStyle(text: '${widget.questionLetter}. '),
          const SizedBox(width: 5,),
          SizedBox(width: MyUtility(context).width * 0.55,
            child: SimpleQuizTextStyle(text: widget.question))
        ],
      ),
    );
  }
}
