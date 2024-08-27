import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/member/professionalDevelopment/ui/quizQuestions/quizAnswer.dart';
import 'package:sama/member/professionalDevelopment/ui/quizQuestions/quizProgressNumbers.dart';
import 'package:sama/member/professionalDevelopment/ui/quizQuestions/quizQuestion.dart';

import '../../../../components/myutility.dart';

class ProfessionalDevQuizContent extends StatefulWidget {
  final String attemptNumber;
  const ProfessionalDevQuizContent({
    super.key,
    required this.attemptNumber,
  });

  @override
  State<ProfessionalDevQuizContent> createState() =>
      _ProfessionalDevQuizContentState();
}

class _ProfessionalDevQuizContentState
    extends State<ProfessionalDevQuizContent> {
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
          Row(
            children: [
              QuizProgressNumbers(questionNumber: '1'),
               QuizProgressNumbers(questionNumber: '1'),
                QuizProgressNumbers(questionNumber: '1'),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          QuizQuestion(
            questionNumber: '1',
            question:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco ',
          ),
          const SizedBox(
            height: 20,
          ),
          QuizAnswer(
              questionLetter: 'a',
              question:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco '),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StyleButton(
                  fontSize: 13,
                  description: 'Go Back',
                  height: 40,
                  width: 130,
                  buttonTextColor: Colors.white,
                  buttonColor: Color.fromRGBO(0, 159, 159, 1),
                  onTap: () {
                    () {};
                  }),
              StyleButton(
                  fontSize: 13,
                  description: 'Next',
                  height: 40,
                  width: 130,
                  buttonTextColor: Colors.white,
                  buttonColor: Color.fromRGBO(0, 159, 159, 1),
                  onTap: () {
                    () {};
                  }),
            ],
          )
        ],
      ),
    );
  }
}
