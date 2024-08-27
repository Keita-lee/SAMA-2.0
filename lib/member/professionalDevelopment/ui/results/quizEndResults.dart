import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/member/professionalDevelopment/ui/simpleQuizTextStyle.dart';

import '../../../../components/myutility.dart';
import '../../../../components/styleButton.dart';

class QuizEndResults extends StatefulWidget {
  final String dateCompleted;
  final String grade;
  final String cpdPoints;
  final bool hasPassed;
  const QuizEndResults(
      {super.key,
      required this.dateCompleted,
      required this.grade,
      required this.cpdPoints, required this.hasPassed});

  @override
  State<QuizEndResults> createState() => _QuizEndResultsState();
}

class _QuizEndResultsState extends State<QuizEndResults> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width * 0.68,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RESULTS',
            style: TextStyle(
                color: Color(0xFF3D3D3D),
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Date Completed',
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SimpleQuizTextStyle(text: widget.dateCompleted),
                ],
              ),
              SizedBox(width: MyUtility(context).width * 0.05,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Grade',
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SimpleQuizTextStyle(text: widget.grade),
                ],
              ),
              SizedBox(width: MyUtility(context).width * 0.05,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'CPD Points',
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SimpleQuizTextStyle(text: widget.cpdPoints),
                ],
              ),
              SizedBox(width: MyUtility(context).width * 0.05,),
              Visibility(
                visible: widget.hasPassed == true,
                child: StyleButton(
                    buttonColor: Colors.teal,
                    description: 'DOWNLOAD CERTIFICATE',
                    height: 50,
                    fontSize: 15,
                    width: 280,
                    onTap: () {}),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
