import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/electionTabStyle.dart';

class ElectionOverView extends StatefulWidget {
  String startDate;
  String endDate;
  String status;
  String statusClosingDate;
  String branch;
  String memberName;
  ElectionOverView(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.status,
      required this.statusClosingDate,
      required this.branch,
      required this.memberName});

  @override
  State<ElectionOverView> createState() => _ElectionOverViewState();
}

class _ElectionOverViewState extends State<ElectionOverView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dear ${widget.memberName}',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 58, 65, 65),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'As a member of the South African Medical Association (SAMA) in the ${widget.branch}, have the right to nominate and vote for SAMA members that are eligible to serve as council members, in the ${widget.branch}, in accordance with the Articles of Association of the South African Medical Association ',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 58, 65, 65),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Branch elections have been made easy and effective, in accordance with Section 63 of the South African Companies Act, using online, automated application controls that ensure that valid votes are processed accurately and completely. The nomination and voting process for the ${widget.branch} council positions are based on the requirements of the Articles of Association of the South African Medical Association.',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 58, 65, 65),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'The nomination and voting process for the ${widget.branch} council positions are based on the requirements of the Articles of Association of the South African Medical Association.',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 58, 65, 65),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'How it works',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 0, 159, 158),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Round 1: Nomination process',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 58, 65, 65),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '• Every SAMA member in the ${widget.branch} has the right to make {nom_number} nominations for positions for the branch committee.',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 58, 65, 65),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '• All nominees that were nominated 2 or more times will be informed of the results of the nomination process and requested to make themselves available to serve as branch committee members.',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 58, 65, 65),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '• Nominees that make themselves available will go through to Round 2 of the election process. Round 2: Elections',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 58, 65, 65),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '•Members in the ${widget.branch} will have the opportunity to vote for representatives from the top nominations from Round 1. Each member will have (nom_number} votes during round 2 and the top {nom_number} candidates will be appointed to the branch committee.',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 58, 65, 65),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Round 2: Elections',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 58, 65, 65),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Members in the ${widget.branch} will have the opportunity to vote for representatives from the top nominations from Round 1. Each member will have (nom_number} votes during round 2 and the top {nom_number} candidates will be appointed to the branch committee.',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 58, 65, 65),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 45,
          ),
        ],
      ),
    );
  }
}
