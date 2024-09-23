import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/member/professionalDevelopment/ui/quizQuestions/quizAnswer.dart';
import 'package:sama/member/professionalDevelopment/ui/quizQuestions/quizQuestion.dart';
import 'package:sama/member/professionalDevelopment/ui/simpleQuizTextStyle.dart';

import '../../../../components/myutility.dart';
import '../../../../components/styleButton.dart';

class YourAnswers extends StatefulWidget {
  final String attemptNumber;
  final List questionAnswers;
  final VoidCallback finalSubmit;
  YourAnswers(
      {super.key,
      required this.attemptNumber,
      required this.questionAnswers,
      required this.finalSubmit});

  @override
  State<YourAnswers> createState() => _YourAnswersState();
}

class _YourAnswersState extends State<YourAnswers> {
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
                'YOUR ANSWERS',
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
          StyleButton(
              buttonColor: Colors.teal,
              description: 'SUBMIT ATTEMPT',
              height: 50,
              fontSize: 13,
              width: 200,
              onTap: () {
                widget.finalSubmit();
              }),
          const SizedBox(
            height: 20,
          ),
          for (int j = 0; j < (widget.questionAnswers).length; j++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QuizQuestion(
                    question: widget.questionAnswers[j]['question'],
                    questionNumber:
                        widget.questionAnswers[j]['questionNumber'].toString()),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: MyUtility(context).width * 0.55,
                    child: SimpleQuizTextStyle(
                        text:
                            '${widget.questionAnswers[j]['letter']}.  ${widget.questionAnswers[j]['answerValue']}')),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          /*   const SizedBox(
            height: 20,
          ),
           QuizAnswer(
              questionLetter: 'a',
              question:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco '),
          const SizedBox(
            height: 20,
          ),*/
        ],
      ),
    );
  }
}
