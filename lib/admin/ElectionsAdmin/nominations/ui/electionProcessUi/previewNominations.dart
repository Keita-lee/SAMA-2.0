import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/styleButton.dart';

class PreviewNominations extends StatefulWidget {
  String branch;
  String nominationStartDate;
  String nominationEndDate;
  String nominateAcceptStartDate;
  String nominateAcceptEndDate;
  String electionDateStart;
  String electionDateEnd;
  PreviewNominations(
      {super.key,
      required this.branch,
      required this.nominationStartDate,
      required this.nominationEndDate,
      required this.nominateAcceptStartDate,
      required this.nominateAcceptEndDate,
      required this.electionDateStart,
      required this.electionDateEnd});

  @override
  State<PreviewNominations> createState() => _PreviewNominationsState();
}

class _PreviewNominationsState extends State<PreviewNominations> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.branch,
          style: TextStyle(
              fontSize: 22,
              color: Color(0xFF174486),
              fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StyleButton(
                description: "Back", height: 55, width: 150, onTap: () {}),
            SizedBox(
              width: 8,
            ),
            StyleButton(
                description: "Publish", height: 55, width: 150, onTap: () {}),
            SizedBox(
              width: 8,
            ),
            StyleButton(
                description: "Export Results in Excel",
                height: 55,
                width: 210,
                onTap: () {}),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Round 1 Nominations",
          style: TextStyle(
              fontSize: 22,
              color: Color(0xFF174486),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "Round 1 Nominations from ${widget.nominationStartDate} - ${widget.nominationEndDate}",
          style: TextStyle(
              fontSize: 22,
              color: Color(0xFF174486),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
