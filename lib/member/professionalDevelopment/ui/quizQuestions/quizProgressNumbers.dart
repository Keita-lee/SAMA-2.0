import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizProgressNumbers extends StatefulWidget {
  final String questionNumber;
  const QuizProgressNumbers({super.key, required this.questionNumber});

  @override
  State<QuizProgressNumbers> createState() => _QuizProgressNumbersState();
}
bool isFinished = false;
class _QuizProgressNumbersState extends State<QuizProgressNumbers> {
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFinished = true;
        });
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 1.2,
              color: Color.fromRGBO(122, 122, 122, 1),
            ),
            right: BorderSide(
              width: 1.2,
              color: Color.fromRGBO(122, 122, 122, 1),
            ),
            top: BorderSide(
              width: 1.2,
              color: Color.fromRGBO(122, 122, 122, 1),
            ),
            bottom: BorderSide(
              width: isFinished == true ? 10 : 1.2,
              color: Color.fromRGBO(122, 122, 122, 1),
            ),
          ),
        ),
        child: Center(
          child: Text(
            widget.questionNumber,
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
