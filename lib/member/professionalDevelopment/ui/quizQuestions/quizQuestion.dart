import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizQuestion extends StatefulWidget {
  final String question;
  final String questionNumber;
  const QuizQuestion({super.key, required this.question, required this.questionNumber});

  @override
  State<QuizQuestion> createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(
            'Question ${widget.questionNumber}',
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            widget.question,
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
    ],);
  }
}