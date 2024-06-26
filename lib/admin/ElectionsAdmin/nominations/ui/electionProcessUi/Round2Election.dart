import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class Round2Election extends StatefulWidget {
  String electionDateStart;
  String electionDateEnd;
  Round2Election(
      {super.key,
      required this.electionDateStart,
      required this.electionDateEnd});

  @override
  State<Round2Election> createState() => _Round2ElectionState();
}

class _Round2ElectionState extends State<Round2Election> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Round 2 elections",
        style: TextStyle(
            fontSize: 22,
            color: Color(0xFF174486),
            fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        "Round 2 elections from ${widget.electionDateStart} - ${widget.electionDateEnd}",
        style: TextStyle(
            fontSize: 18,
            color: Color(0xFF174486),
            fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        "Round 2 elections has Finished",
        style: TextStyle(
            fontSize: 18,
            color: Color(0xFF174486),
            fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 8,
      ),
      Row(
        children: [
          Text(
            "HDI compliance checks for elections:",
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF174486),
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Disabled",
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF174486),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        "Election Results",
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
            width: MyUtility(context).width / 9,
            child: Text(
              "SAMA",
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF174486),
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            width: MyUtility(context).width / 9,
            child: Text(
              "HPCSA",
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF174486),
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            width: MyUtility(context).width / 6,
            child: Text(
              "Name",
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF174486),
                  fontWeight: FontWeight.w400),
            ),
          ),
          Spacer(),
          SizedBox(
            width: MyUtility(context).width / 11,
            child: Text(
              "HDI Status",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF174486),
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            width: MyUtility(context).width / 11,
            child: Text(
              "Selected",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF174486),
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            width: MyUtility(context).width / 11,
            child: Text(
              "Voted",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF174486),
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            width: MyUtility(context).width / 13,
            child: Text(
              "Total",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF174486),
                  fontWeight: FontWeight.w400),
            ),
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
