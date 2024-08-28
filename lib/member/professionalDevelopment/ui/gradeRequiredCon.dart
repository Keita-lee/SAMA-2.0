import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/member/professionalDevelopment/ui/simpleQuizTextStyle.dart';

class GradeRequiredCon extends StatefulWidget {
  final int requiredCorrectQuestions;
  final int questionAmmount;
  final double requiredGradePercentage;
  final bool isQuizInProgress;
  final String attemptNumber;
  final String grade;
  final double failedAttemptScorePercentage;
  final Function() onTapReviewFailed;
  final Function() takeQuizFunction;
  final bool isAttemptPending;
  const GradeRequiredCon(
      {super.key,
      required this.requiredCorrectQuestions,
      required this.questionAmmount,
      required this.requiredGradePercentage,
      required this.attemptNumber,
      required this.grade,
      required this.failedAttemptScorePercentage,
      required this.onTapReviewFailed,
      required this.isQuizInProgress,
      required this.isAttemptPending,
      required this.takeQuizFunction});

  @override
  State<GradeRequiredCon> createState() => _GradeRequiredConState();
}

class _GradeRequiredConState extends State<GradeRequiredCon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Color.fromARGB(255, 238, 237, 237),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Grade Required:',
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: widget.requiredCorrectQuestions.toString(),
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: '/${widget.questionAmmount.toString()} ',
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: '(${widget.requiredGradePercentage.toString()}%)',
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Visibility(
              visible: widget.isQuizInProgress == true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SimpleQuizTextStyle(
                      text: 'Attempt ${widget.attemptNumber}: Failed'),
                  SimpleQuizTextStyle(
                      text:
                          'Grade: ${widget.grade} /${widget.questionAmmount} (${widget.failedAttemptScorePercentage})'),
                  GestureDetector(
                    onTap: widget.onTapReviewFailed,
                    child: Text(
                      'Review',
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          decorationThickness: 2,
                          decorationColor: Colors.black,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.normal,
                          fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  SimpleQuizTextStyle(
                      text: 'Attempt ${widget.attemptNumber}: In Progress'),
                ],
              ),
            ),
            Visibility(
              visible: widget.isAttemptPending,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SimpleQuizTextStyle(
                      text: 'Attempt ${widget.attemptNumber}: Pending'),
                  SimpleQuizTextStyle(text: 'Grade: Pending'),
                  const SizedBox(
                    height: 40,
                  ),
                  StyleButton(
                      buttonColor: Color.fromRGBO(24, 69, 126, 1),
                      description: 'TAKE QUIZ',
                      fontSize: 12,
                      height: 50,
                      width: 200,
                      onTap: widget.takeQuizFunction)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
