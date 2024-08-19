import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui2/Excel/acceptanceRoundEx.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui2/Excel/chairPersonEx.dart';

import '../../../../../../components/styleButton.dart';
import '../../../ui/electionOverviewItem.dart';
import '../../Excel/exportAll.dart';
import '../../Excel/round1Ex.dart';
import '../../Excel/round2Ex.dart';

class ElectionOverView extends StatefulWidget {
  String nominateStartDate;
  String nominateEndDate;
  String nominateAcceptStartDate;
  String nominateAcceptEndDate;
  String electionDateStart;
  String electionDateEnd;
  String chairPersonStart;
  String chairPersonEnd;
  String electionId;
  List electionVotes;
  List chairMemberVoteList;
  String branch;
  ElectionOverView(
      {super.key,
      required this.nominateStartDate,
      required this.nominateEndDate,
      required this.nominateAcceptStartDate,
      required this.nominateAcceptEndDate,
      required this.electionDateStart,
      required this.electionDateEnd,
      required this.chairPersonStart,
      required this.chairPersonEnd,
      required this.electionId,
      required this.electionVotes,
      required this.chairMemberVoteList,
      required this.branch});
  @override
  State<ElectionOverView> createState() => _ElectionOverViewState();
}

class _ElectionOverViewState extends State<ElectionOverView> {
  List membersWhoAreNominated = [];
  List membersWhoAccepted = [];
  List acceptanceList = [];
  List chairMembers = [];
  List nominations = [];

  //get user details from notification
  getUserDetail(id) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(id).get();

    var count = 0;
    var userData = {
      "SamaNr": "9088466",
      "name": "${doc.get("firstName")} ${doc.get("lastName")}",
      "hpca": doc.get("hpcsa"),
      "hdiStatus": "HDI",
      "email": "${doc.get("email")}",
      "nominations": '${getNominationsForUser(doc.get("email"))}',
    };
    setState(() {
      membersWhoAreNominated.add(userData);
    });
  }

  getChairVotesVotes(email) {
    var totalVotes = 0;
    for (int i = 0; i < (widget.chairMemberVoteList).length; i++) {
      if (widget.chairMemberVoteList[i]['email'] == email) {
        totalVotes = totalVotes + 1;
      }
    }
    return '${totalVotes}';
  }

  getVotes(email) {
    var totalVotes = 0;
    for (int i = 0; i < (widget.electionVotes).length; i++) {
      if (widget.electionVotes[i]['email'] == email) {
        totalVotes = totalVotes + 1;
      }
    }
    return '${totalVotes}';
  }

  //get User Notification list who accepted nomination
  getUserNotificationList() async {
    print(widget.electionId);
    final doc = await FirebaseFirestore.instance
        .collection('notifications')
        .where("data.electionId", isEqualTo: widget.electionId)
        .get();
    setState(() {
      for (int i = 0; i < (doc.docs).length; i++) {
        getUserDetail(doc.docs[i]["userWhoNotify"]);
        getUserDetailRound2(
            doc.docs[i]["userWhoNotify"], doc.docs[i]["data.accept"]);
        getUserDetailAcceptance(doc.docs[i]["userWhoNotify"],
            doc.docs[i]["data.accept"], doc.docs[i]["id"]);
        getUserDetailChair(
            doc.docs[i]["userWhoNotify"], doc.docs[i]["data.accept"]);
      }
    });
  }

  getUserDetailAcceptance(id, result, notificationId) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(id).get();

    var count = 0;
    var userData = {
      "SamaNr": "9088466",
      "name": "${doc.get("firstName")} ${doc.get("lastName")}",
      "hpca": doc.get("hpcsa"),
      "hdiStatus": "HDI",
      "email": "${doc.get("email")}",
      "state": "Elected",
      "result": result == true ? "Accept" : "Declined",
      "notificationId": notificationId
    };
    setState(() {
      if (getNominationsForUser(doc.get("email")) >= 2) {
        acceptanceList.add(userData);
      }
    });
  }

  //get user details from notification
  getUserDetailRound2(id, result) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(id).get();

    var userData = {
      "SamaNr": "9088466",
      "name": "${doc.get("firstName")} ${doc.get("lastName")}",
      "hpca": doc.get("hpcsa"),
      "hdiStatus":
          '${doc!["race"] == "White/Caucasian" || doc!["race"] == "Other" ? "" : "HDI"} ',
      "email": "${doc.get("email")}",
      "votes": getVotes(doc.get("email"))
    };
    setState(() {
      if (getNominationsForUser(doc.get("email")) >= 2) {
        membersWhoAccepted.add(userData);
      }
    });
  }

  getVotesChir(email) {
    var totalVotes = 0;
    for (int i = 0; i < (widget.chairMemberVoteList).length; i++) {
      if (widget.chairMemberVoteList[i]['email'] == email) {
        totalVotes = totalVotes + 1;
      }
    }
    return '${totalVotes}';
  }

  //get user details from notification
  getUserDetailChair(id, result) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(id).get();

    var userData = {
      "SamaNr": "9088466",
      "name": "${doc.get("firstName")} ${doc.get("lastName")}",
      "hpca": doc.get("hpcsa"),
      "hdiStatus":
          '${doc!["race"] == "White/Caucasian" || doc!["race"] == "Other" ? "" : "HDI"} ',
      "email": "${doc.get("email")}",
      "votes": getVotesChir(doc.get("email"))
    };
    setState(() {
      if (getNominationsForUser(doc.get("email")) >= 2) {
        chairMembers.add(userData);
      }
    });

    membersWhoAccepted.sort((b, a) => a["votes"].compareTo(b["votes"]));
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

  @override
  void initState() {
    getUserNotificationList();
    getNominations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 10, 45, 10),
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          ElectionOverviewItem(
              voteTitle: 'Round 1 Nominations',
              startDate: widget.nominateStartDate,
              endDate: widget.nominateEndDate,
              exportToExcel: () {
                Round1Excel().exportRound1(
                    widget.nominateStartDate,
                    widget.nominateEndDate,
                    membersWhoAreNominated,
                    widget.branch);
                //  _exportToExcel();
              }),
          ElectionOverviewItem(
              voteTitle: 'Nomination Acceptance Round',
              startDate: widget.nominateAcceptStartDate,
              endDate: widget.nominateAcceptEndDate,
              exportToExcel: () {
                AcceptanceRoundExcel().exportAcceptance(
                    widget.nominateAcceptStartDate,
                    widget.nominateAcceptEndDate,
                    acceptanceList,
                    widget.branch);
              }),
          ElectionOverviewItem(
              voteTitle: 'Round 2 Elections',
              startDate: widget.electionDateStart,
              endDate: widget.electionDateEnd,
              exportToExcel: () {
                Round2Excel().exportRound2(widget.electionDateStart,
                    widget.electionDateEnd, membersWhoAccepted, widget.branch);
              }),
          ElectionOverviewItem(
              voteTitle: 'Chairperson Election',
              startDate: widget.chairPersonStart,
              endDate: widget.chairPersonEnd,
              exportToExcel: () {
                ChairPersonEx().exportChairPerson(widget.chairPersonStart,
                    widget.chairPersonEnd, chairMembers, widget.branch);
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StyleButton(
                  description: "Export All CSV",
                  height: 55,
                  width: 165,
                  onTap: () {
                    ExportAllData().exportAllData(
                        widget.nominateStartDate,
                        widget.nominateEndDate,
                        membersWhoAreNominated,
                        widget.nominateAcceptStartDate,
                        widget.nominateAcceptEndDate,
                        acceptanceList,
                        widget.electionDateStart,
                        widget.electionDateEnd,
                        membersWhoAccepted,
                        widget.chairPersonStart,
                        widget.chairPersonEnd,
                        chairMembers,
                        widget.branch);
                  })
            ],
          )
        ],
      ),
    );
  }
}
