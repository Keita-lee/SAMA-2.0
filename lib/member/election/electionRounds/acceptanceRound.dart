import 'package:flutter/material.dart';

import '../../../components/service/commonService.dart';

class AcceptanceRound extends StatefulWidget {
  String startDate;
  String endDate;
  String branch;
  AcceptanceRound(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.branch});

  @override
  State<AcceptanceRound> createState() => _AcceptanceRoundState();
}

class _AcceptanceRoundState extends State<AcceptanceRound> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Acceptance round open for ${widget.branch}',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 0, 159, 158),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Period: ${CommonService().getDateInText(widget.startDate)} to ${CommonService().getDateInText(widget.endDate)}',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 58, 65, 65),
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
