import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/service/commonService.dart';
import 'package:sama/member/election/electionRounds/chairMemberVotes.dart';
import 'package:sama/member/election/electionRounds/electionSummaryView.dart';
import 'package:sama/member/election/electionRounds/memberElectionRound1.dart';
import 'package:sama/member/election/electionRounds/memberElectionsRound2.dart';

List membersWhoAccepted = [];

class MemberElection extends StatefulWidget {
  const MemberElection({super.key});

  @override
  State<MemberElection> createState() => _MemberElectionState();
}

class _MemberElectionState extends State<MemberElection> {
  //var

  List nominations = [];
  List chairMemberVoteList = [];
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
  List chairManVotes = [];
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
        chairManVotes = data.get('chairmanVotes');
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
  updatePageBasedOnStatus(value) {
    /*   if (votingStatus == "Nominations") {
      setState(() {
        pageIndex = 1;
      });
    } else {
      setState(() {
        pageIndex = 2;
      });
    }*/

    setState(() {
      pageIndex = value;
    });
  }

/////////////////////////////////////

  getVotes(email) {
    var totalVotes = 0;
    for (int i = 0; i < (electionVotes).length; i++) {
      if (electionVotes[i]['email'] == email) {
        totalVotes = totalVotes + 1;
      }
    }
    return '${totalVotes}';
  }

  //get user details from notification
  getUserDetail(id) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(id).get();

    var userData = {
      "id": "${doc.get("id")}",
      "SamaNr": "15658",
      "name": "${doc.get("firstName")} ${doc.get("lastName")}",
      "hpca": doc.get("hpcsa"),
      "email": "${doc.get("email")}",
      "votes": getVotes(doc.get("email"))
    };
    print("TEST");
    setState(() {
      if (getNominationsForUser(doc.get("email")) >= 2) {
        membersWhoAccepted.add(userData);
        print(userData);
      }
    });
    print("TEST");
    voteChareMemberPermission();
  }

  //get User Notification list who accepted nomination
  getUserNotificationList() async {
    final doc = await FirebaseFirestore.instance
        .collection('notifications')
        .where("data.electionId", isEqualTo: "orIEplhDstxiWQdSLHlK")
        .get();
    setState(() {
      for (int i = 0; i < (doc.docs).length; i++) {
        getUserDetail(doc.docs[i]["userWhoNotify"]);
      }
    });
  }

  getNominations() async {
    final doc =
        await FirebaseFirestore.instance.collection('nominations').get();
    if (doc != null) {
      setState(() {
        nominations.addAll(doc.docs);
      });
    }
  }

  getNominationsForUser(email) {
    var nomAmount = 0;
    for (int i = 0; i < nominations.length; i++) {
      if (nominations[i]['nominee'] == email) {
        setState(() {
          nomAmount++;
        });
      }
    }
    return nomAmount;
  }

// check if user can vote for chair member
  voteChareMemberPermission() {
    var permission = false;
    membersWhoAccepted.sort((b, a) => a["votes"].compareTo(b["votes"]));
    for (int i = 0; i < membersWhoAccepted.length; i++) {
      if (membersWhoAccepted[i]["id"] ==
          FirebaseAuth.instance.currentUser!.uid) {
        permission = true;
      }

      print(membersWhoAccepted[i]['email']);
    }
    return permission;
  }

  @override
  void initState() {
    getElection();
    getUserNotificationList();
    getNominations();

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
          updatePageBasedOnStatus: () {
            updatePageBasedOnStatus(1);
          }),
      MemberElectionRound1(
        branch: branch,
        electionId: "orIEplhDstxiWQdSLHlK",
        position: position,
        votingCount: votingCount,
        acceptDate: nominateAcceptStartDate,
        hdiStatus: hdiStatus,
      ),
      MemberElectionsRound2(
          branch: branch,
          position: position,
          electionId: "orIEplhDstxiWQdSLHlK",
          votingCount: votingCount,
          electionVotes: electionVotes),
      ChairMemberVotes(
          votingCount: votingCount,
          electionId: "orIEplhDstxiWQdSLHlK",
          voteChareMemberList: membersWhoAccepted,
          chairmemberVoteList: chairManVotes,
          electionVotes: electionVotes)
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
          height: 15,
        ),
        Electionsummaryview(
            startDate: nominateStartDate,
            endDate: electionDateEnd,
            status: "Nominations",
            statusClosingDate: votingClosingDate,
            updatePageBasedOnStatus: () {
              updatePageBasedOnStatus(1);
            }),
        SizedBox(
          height: 15,
        ),
        Electionsummaryview(
            startDate: nominateStartDate,
            endDate: electionDateEnd,
            status: "Nomination Acceptance",
            statusClosingDate: votingClosingDate,
            updatePageBasedOnStatus: () {
              updatePageBasedOnStatus(1);
            }),
        SizedBox(
          height: 15,
        ),
        Electionsummaryview(
            startDate: nominateStartDate,
            endDate: electionDateEnd,
            status: "Elections",
            statusClosingDate: votingClosingDate,
            updatePageBasedOnStatus: () {
              updatePageBasedOnStatus(2);
            }),
        SizedBox(
          height: 15,
        ),
        /* ChairMemberVotes(
            votingCount: votingCount,
            electionId: "orIEplhDstxiWQdSLHlK",
            voteChareMemberList: membersWhoAccepted,
            chairmemberVoteList: chairManVotes,
            electionVotes: electionVotes),*/
        Visibility(
          visible: voteChareMemberPermission(),
          child: Electionsummaryview(
              startDate: nominateStartDate,
              endDate: electionDateEnd,
              status: "Chair member vote",
              statusClosingDate: votingClosingDate,
              updatePageBasedOnStatus: () {
                updatePageBasedOnStatus(3);
              }),
        ),
        SizedBox(
          height: 25,
        ),
        Visibility(
          visible: pageIndex >= 1 ? true : false,
          child: Container(
            child: electionPages[pageIndex],
          ),
        ),
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
