import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/service/commonService.dart';
import 'package:sama/member/election/electionRounds/electionSummaryView.dart';
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
  var pageIndex = 0;
  String title = "";
  String position = "";
  String criteria = "";
  String branch = "";
  String votingStatus = "";
  bool hdiStatus = false;
  String votingClosingDate = "";
  String votingCount = "";
  //First part
  String nominateStartDate = "";
  String nominateEndDate = "";

  //Second Part
  String nominateAcceptStartDate = "";
  String nominateAcceptEndDate = "";

  // Third Part
  String electionDateStart = "";
  String electionDateEnd = "";
  List electionVotes = [];
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
        votingCount = data.get('count');
        electionVotes = data.get('electionVotes');
      });
    }
    checkVotingStatus();
  }

//see what status the election is at
  checkVotingStatus() {
    if (CommonService().checkDatePeriod(nominateStartDate, nominateEndDate)) {
      setState(() {
        votingStatus = "Nominations";
        votingClosingDate = nominateEndDate;
      });
    } else if (CommonService()
        .checkDatePeriod(nominateAcceptStartDate, nominateAcceptEndDate)) {
      setState(() {
        votingStatus = "Nomination Acceptance";
        votingClosingDate = nominateAcceptEndDate;
      });
    } else if (CommonService()
        .checkDatePeriod(electionDateStart, electionDateEnd)) {
      setState(() {
        votingStatus = "Elections";
        votingClosingDate = electionDateEnd;
      });
    }
  }

//update the page index based on the status
  updatePageBasedOnStatus() {
    if (votingStatus == "Nominations") {
      setState(() {
        pageIndex = 1;
      });
    } else {
      setState(() {
        pageIndex = 2;
      });
    }
  }

  @override
  void initState() {
    getElection();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var electionPages = [
      Electionsummaryview(
          startDate: nominateStartDate,
          endDate: electionDateEnd,
          status: votingStatus,
          statusClosingDate: votingClosingDate,
          updatePageBasedOnStatus: updatePageBasedOnStatus),
      MemberElectionsRound2(
          branch: branch,
          position: position,
          electionId: "orIEplhDstxiWQdSLHlK",
          votingCount: votingCount,
          electionVotes: electionVotes),
      MemberElectionRound1(
        branch: branch,
        electionId: "orIEplhDstxiWQdSLHlK",
        position: position,
        votingCount: votingCount,
        acceptDate: nominateAcceptStartDate,
        hdiStatus: hdiStatus,
      ),
    ];
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
        Container(
          child: electionPages[pageIndex],
        ),
        SizedBox(
          height: 15,
        ),
        Electionsummaryview(
            startDate: nominateStartDate,
            endDate: electionDateEnd,
            status: "Nomination Acceptance",
            statusClosingDate: votingClosingDate,
            updatePageBasedOnStatus: updatePageBasedOnStatus),
        SizedBox(
          height: 15,
        ),
        Electionsummaryview(
            startDate: nominateStartDate,
            endDate: electionDateEnd,
            status: "Elections",
            statusClosingDate: votingClosingDate,
            updatePageBasedOnStatus: updatePageBasedOnStatus),
        /*   MemberElectionRound1(
          branch: branch,
          position: position,
        ),
        MemberElectionsRound2(
          branch: branch,
          position: position,
        ),
        Visibility(
          visible: checkDatePeriod(nominateStartDate, nominateEndDate)
              ? true
              : false,
          child: MemberElectionRound1(
            branch: branch,
            position: position,
          ),
        ),
        Visibility(
          visible: checkDatePeriod(electionDateStart, electionDateEnd)
              ? true
              : false,
          child: MemberElectionsRound2(
            branch: branch,
            position: position,
          ),
        ),

        Electionsummaryview(
          startDate: nominateStartDate,
          endDate: electionDateEnd,
          status: votingStatus,
          statusClosingDate: votingClosingDate,
        ),*/
      ]),
    );
  }
}
