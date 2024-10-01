import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/professionalDevelopment/ui/yourQuizAnswers/quizAnswerCheckBox.dart';
import 'package:sama/member/professionalDevelopment/ui/simpleQuizTextStyle.dart';

class QuizAnswer extends StatefulWidget {
  final String questionToBeAsked;
  final List questionAnswers;
  final int questionNumber;
  final String questionLetter;
  final String question;
  final VoidCallback addToQuestionAnswers;
  const QuizAnswer(
      {super.key,
      required this.questionToBeAsked,
      required this.questionAnswers,
      required this.questionNumber,
      required this.questionLetter,
      required this.question,
      required this.addToQuestionAnswers});

  @override
  State<QuizAnswer> createState() => _QuizAnswerState();
}

class _QuizAnswerState extends State<QuizAnswer> {
  checkIfQuestionAnswered() {
    var check = false;

    var index = (widget.questionAnswers)
        .indexWhere((item) => item["questionNumber"] == widget.questionNumber);

    if (index != -1) {
      if (widget.questionAnswers[index]['question'] ==
              widget.questionToBeAsked &&
          widget.questionAnswers[index]['answerValue'] == widget.question) {
        setState(() {
          check = true;
        });
      }
    }

    return check;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width * 0.60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuizAnswerCheckBox(
            check: checkIfQuestionAnswered(),
            addToQuestionAnswers: () {
              widget.addToQuestionAnswers();
            },
          ),
          const SizedBox(
            width: 20,
          ),
          SimpleQuizTextStyle(text: '${widget.questionLetter}. '),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
              width: MyUtility(context).width * 0.55,
              child: SimpleQuizTextStyle(text: widget.question))
        ],
      ),
    );
  }
}
