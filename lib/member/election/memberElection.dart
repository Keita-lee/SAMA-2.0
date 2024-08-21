import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/banner/samaBlueBanner.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/service/commonService.dart';
import 'package:sama/member/election/electionRounds/acceptanceRound.dart';
import 'package:sama/member/election/electionRounds/chairMemberVotes.dart';
import 'package:sama/member/election/electionRounds/electionOverView.dart';
import 'package:sama/member/election/electionRounds/electionStatus.dart';
import 'package:sama/member/election/electionRounds/electionSummaryView.dart';
import 'package:sama/member/election/electionRounds/nominations/memberElectionRound1.dart';
import 'package:sama/member/election/electionRounds/memberElectionsRound2.dart';
import 'package:sama/components/electionTabStyle.dart';

import '../../admin/ElectionsAdmin/nominations/ui/tabStyle.dart';
import '../../components/ui/pleaseLogin.dart';

List membersWhoAccepted = [];

class MemberElection extends StatefulWidget {
  String userType;
  MemberElection({super.key, required this.userType});

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

  String currentStartDate = "";
  String currentEndDate = "";
  //First part
  String nominateStartDate = "";
  String nominateEndDate = "";

  //Second Part
  String nominateAcceptStartDate = "";
  String nominateAcceptEndDate = "";

  // Third Part
  String electionDateStart = "";
  String electionDateEnd = "";

  //Fourth Part
  String chairmanStartDate = "";
  String chairmanEndDate = "";

  List electionVotes = [];
  List chairManVotes = [];
//get election data
//TODO get elections based on branch
  getElection() async {
    final data = await FirebaseFirestore.instance
        .collection('elections')
        .doc("ngZiVRVWoMETIGm0VPgj")
        .get();

    if (data.exists) {
      setState(() {
        nominateStartDate = data.get('nominateStartDate');
        nominateEndDate = data.get('nominateEndDate');
        nominateAcceptStartDate = data.get('nominateAcceptStartDate');
        nominateAcceptEndDate = data.get('nominateAcceptEndDate');
        electionDateStart = data.get('electionDateStart');
        electionDateEnd = data.get('electionDateEnd');
        chairmanStartDate = data.get('chairPersonStart');
        chairmanEndDate = data.get('chairPersonEnd');
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
        currentStartDate = nominateStartDate;
        currentEndDate = nominateEndDate;
      });
    } else if (CommonService()
        .checkDatePeriod(nominateAcceptStartDate, nominateAcceptEndDate)) {
      setState(() {
        votingStatus = "Nomination Acceptance";
        votingClosingDate = nominateAcceptEndDate;
        currentStartDate = nominateAcceptStartDate;
        currentEndDate = nominateAcceptEndDate;
      });
    } else if (CommonService()
        .checkDatePeriod(electionDateStart, electionDateEnd)) {
      setState(() {
        votingStatus = "Elections";
        votingClosingDate = electionDateEnd;
        currentStartDate = electionDateStart;
        currentEndDate = electionDateEnd;
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
        .where("data.electionId", isEqualTo: "ngZiVRVWoMETIGm0VPgj")
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

  var memberName = "";
  getMemberName() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (doc.exists) {}
    setState(() {
      memberName = "${doc.get("firstName")} ${doc.get("lastName")}";
    });
  }

  @override
  void initState() {
    getElection();
    getUserNotificationList();
    getNominations();
    getMemberName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var electionPages = [
      ElectionOverView(
        startDate: nominateStartDate,
        endDate: electionDateEnd,
        status: votingStatus,
        statusClosingDate: votingClosingDate,
        branch: branch,
        memberName: memberName,
      ),

      /* Electionsummaryview(
          startDate: nominateStartDate,
          endDate: electionDateEnd,
          status: votingStatus,
          statusClosingDate: votingClosingDate,
          updatePageBasedOnStatus: () {
            updatePageBasedOnStatus(1);
          }),*/
      MemberElectionRound1(
        branch: branch,
        electionId: "ngZiVRVWoMETIGm0VPgj",
        position: position,
        votingCount: votingCount,
        acceptDate: nominateAcceptStartDate,
        startDate: nominateStartDate,
        endDate: nominateEndDate,
        hdiStatus: hdiStatus,
      ),
      AcceptanceRound(
          startDate: nominateAcceptStartDate,
          endDate: nominateAcceptEndDate,
          branch: branch),
      MemberElectionsRound2(
        branch: branch,
        position: position,
        electionId: "ngZiVRVWoMETIGm0VPgj",
        votingCount: votingCount,
        electionVotes: electionVotes,
        startDate: electionDateStart,
        endDate: electionDateEnd,
      ),
      ChairMemberVotes(
        votingCount: votingCount,
        electionId: "ngZiVRVWoMETIGm0VPgj",
        voteChareMemberList: membersWhoAccepted,
        chairmemberVoteList: chairManVotes,
        electionVotes: electionVotes,
        startDate: chairmanStartDate,
        endDate: chairmanEndDate,
        branch: branch,
      )
    ];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SamaBlueBanner(pageName: 'BRANCH VOTING'),
          Visibility(
              visible: widget.userType == "NonMember",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: PleaseLogin(
                      pleaseLoginText:
                          'Access to this content is restricted. Please log in to view or sign up for membership today.',
                    ),
                  ),
                ],
              )),
          Visibility(
            visible: widget.userType != "NonMember",
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElectionTabStyle(
                          changePage: () {
                            setState(() {
                              pageIndex = 0;
                            });
                          },
                          tabIndexNumber: 0,
                          description: "Overview",
                          customWidth: 150,
                          customColor1: Color.fromARGB(255, 211, 210, 210),
                          customColor2: Color.fromARGB(255, 0, 159, 158),
                          pageIndex: pageIndex,
                        ),
                        ElectionTabStyle(
                          changePage: () {
                            setState(() {
                              pageIndex = 1;
                            });
                          },
                          tabIndexNumber: 1,
                          description: "Nominations",
                          customWidth: 150,
                          customColor1: Color.fromARGB(255, 211, 210, 210),
                          customColor2: Color.fromARGB(255, 0, 159, 158),
                          pageIndex: pageIndex,
                        ),
                        /* ElectionTabStyle(
                                changePage: () {
                  setState(() {
                    pageIndex = 2;
                  });
                                },
                                tabIndexNumber: 2,
                                description: "Acceptance Round",
                                customWidth: 180,
                                customColor1: Color.fromARGB(255, 211, 210, 210),
                                customColor2: Color.fromARGB(255, 0, 159, 158),
                                pageIndex: pageIndex,
                              ),*/
                        ElectionTabStyle(
                          changePage: () {
                            setState(() {
                              pageIndex = 3;
                            });
                          },
                          tabIndexNumber: 3,
                          description: "Voting",
                          customWidth: 150,
                          customColor1: Color.fromARGB(255, 211, 210, 210),
                          customColor2: Color.fromARGB(255, 0, 159, 158),
                          pageIndex: pageIndex,
                        ),
                        ElectionTabStyle(
                          changePage: () {
                            setState(() {
                              pageIndex = 4;
                            });
                          },
                          tabIndexNumber: 4,
                          description: "Chairperson",
                          customWidth: 150,
                          customColor1: Color.fromARGB(255, 211, 210, 210),
                          customColor2: Color.fromARGB(255, 0, 159, 158),
                          pageIndex: pageIndex,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: pageIndex == 0 ? true : false,
                      child: Container(
                          width: MyUtility(context).width * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Color(0xFFD1D1D1),
                              )),
                          child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ElectionStatus(
                                  startDate: currentStartDate,
                                  endDate: currentEndDate,
                                  status: votingStatus,
                                  statusClosingDate: votingClosingDate,
                                  branch: branch))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        width: MyUtility(context).width * 0.8,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Color(0xFFD1D1D1),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: electionPages[pageIndex],
                        )),
                    SizedBox(
                      height: 15,
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
