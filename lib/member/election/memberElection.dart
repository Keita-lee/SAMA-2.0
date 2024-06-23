import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/election/electionRounds/memberElectionRound1.dart';
import 'package:sama/member/election/electionRounds/memberElectionsRound2.dart';

class MemberElection extends StatefulWidget {
  const MemberElection({super.key});

  @override
  State<MemberElection> createState() => _MemberElectionState();
}

class _MemberElectionState extends State<MemberElection> {
  //var
  List nominationData = [];

  String title = "";
  String position = "";
  String criteria = "";
  String branch = "";
  //First part
  String nominateStartDate = "";
  String nominateEndDate = "";

  //Second Part
  String nominateAcceptStartDate = "";
  String nominateAcceptEndDate = "";

  // Third Part
  String electionDateStart = "";
  String electionDateEnd = "";

//get election data
//TODO get elections based on branch
  getElection() async {
    final data = await FirebaseFirestore.instance
        .collection('elections')
        .doc("orIEplhDstxiWQdSLHlK")
        .get();

    if (data.exists) {
      setState(() {
        nominateStartDate = data.get('nominateStartDate');
        nominateEndDate = data.get('nominateEndDate');
        nominateAcceptStartDate = data.get('nominateAcceptStartDate');
        nominateAcceptEndDate = data.get('nominateAcceptEndDate');
        electionDateStart = data.get('electionDateStart');
        electionDateEnd = data.get('electionDateEnd');
        title = data.get('title');
        position = data.get('position');
        criteria = data.get('criteria');
        branch = data.get('selectBranch');
      });
    }
  }

//check if date inbetween and call correct election round
  checkDatePeriod(start, end) {
    var validDate = false;

    var startDate = DateTime.parse(start);
    var endDate = DateTime.parse(end);
    final currentDate = DateTime.now();

    final today =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    final checkDateStart =
        DateTime(startDate.year, startDate.month, startDate.day);
    final checkDateEnd = DateTime(endDate.year, endDate.month, endDate.day);

    if (checkDateStart == today || checkDateEnd == today) {
      validDate = true;
    } else if (currentDate.isAfter(startDate) &&
        currentDate.isBefore(endDate)) {
      validDate = true;
    }
    return validDate;
  }

  @override
  void initState() {
    getElection();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Nominations',
          style: TextStyle(
            fontSize: 36,
            color: Color(0xFF3D3D3D),
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          'Title: ${title}',
          style: TextStyle(
            fontSize: 22,
            color: Color(0xFF3D3D3D),
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Position:  ${position}',
          style: TextStyle(
            fontSize: 22,
            color: Color(0xFF3D3D3D),
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Criteria :${criteria}',
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF3D3D3D),
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        /*    Visibility(
          visible: checkDatePeriod(nominateStartDate, nominateEndDate)
              ? true
              : false,
          child: MemberElectionRound1(
            branch: branch,
            position: position,
          ),
        ),*/
        Visibility(
          visible: checkDatePeriod(electionDateStart, electionDateEnd)
              ? true
              : false,
          child: MemberElectionsRound2(
            branch: branch,
            position: position,
          ),
        ),
        MemberElectionsRound2(
          branch: branch,
          position: position,
        ),
      ]),
    );
  }
}
