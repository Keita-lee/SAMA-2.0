import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class NominationAcceptanceRound extends StatefulWidget {
  String nominateAcceptStartDate;
  String nominateAcceptEndDate;
  NominationAcceptanceRound(
      {super.key,
      required this.nominateAcceptEndDate,
      required this.nominateAcceptStartDate});

  @override
  State<NominationAcceptanceRound> createState() =>
      _NominationAcceptanceRoundState();
}

class _NominationAcceptanceRoundState extends State<NominationAcceptanceRound> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Nomination acceptance round",
        style: TextStyle(
            fontSize: 22,
            color: Color(0xFF174486),
            fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        "The collection round is from ${widget.nominateAcceptStartDate} - ${widget.nominateAcceptEndDate}",
        style: TextStyle(
            fontSize: 18,
            color: Color(0xFF174486),
            fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        "Candidate with 2 or more nomination collection round has been accepted",
        style: TextStyle(
            fontSize: 18,
            color: Color(0xFF174486),
            fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        "Memebrs that have been seconded and invirted to stand for the round 2 election",
        style: TextStyle(
            fontSize: 18,
            color: Color(0xFF174486),
            fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 8,
      ),
      Container(
        color: Colors.grey,
        height: 1,
        width: MyUtility(context).width / 1.4,
      ),
      SizedBox(
        height: 8,
      ),
      Row(
        children: [
          SizedBox(
            width: MyUtility(context).width / 8,
            child: Text(
              "SAMA",
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF174486),
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: MyUtility(context).width / 8,
            child: Text(
              "HPCSA",
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF174486),
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: MyUtility(context).width / 6,
            child: Text(
              "Name",
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF174486),
                  fontWeight: FontWeight.w600),
            ),
          ),
          Spacer(),
          Text(
            "State",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF174486),
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            "Result",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF174486),
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      SizedBox(
        height: 8,
      ),
      Container(
        color: Colors.grey,
        height: 1,
        width: MyUtility(context).width / 1.4,
      ),
    ]);
  }
}
