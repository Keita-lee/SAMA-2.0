import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../../components/utility.dart';
import '../../Excel/chairPersonEx.dart';

class ChairPersonOverview extends StatefulWidget {
  String chairMemberStartDate;
  String chairMemberEndDate;
  List chairMemberVoteList;
  String electionId;
  ChairPersonOverview(
      {super.key,
      required this.chairMemberEndDate,
      required this.chairMemberStartDate,
      required this.chairMemberVoteList,
      required this.electionId});

  @override
  State<ChairPersonOverview> createState() => _ChairPersonOverviewState();
}

class _ChairPersonOverviewState extends State<ChairPersonOverview> {
  //var
  List membersWhoAccepted = [];
  List nominations = [];

  getVotes(email) {
    var totalVotes = 0;
    for (int i = 0; i < (widget.chairMemberVoteList).length; i++) {
      if (widget.chairMemberVoteList[i]['email'] == email) {
        totalVotes = totalVotes + 1;
      }
    }
    return '${totalVotes}';
  }

  //get user details from notification
  getUserDetail(id, result) async {
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
        if (double.parse(getVotes(doc.get("email"))) >= 1) {
          membersWhoAccepted.add(userData);
        }
      }
    });

    membersWhoAccepted.sort((b, a) => a["votes"].compareTo(b["votes"]));
  }

  //get User Notification list who accepted nomination
  getUserNotificationList() async {
    final doc = await FirebaseFirestore.instance
        .collection('notifications')
        .where("data.electionId", isEqualTo: widget.electionId)
        // .where("data.accept", isEqualTo: true)
        .get();
    setState(() {
      for (int i = 0; i < (doc.docs).length; i++) {
        getUserDetail(doc.docs[i]["userWhoNotify"], doc.docs[i]["data.accept"]);
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
        child: SingleChildScrollView(
            child: Column(children: [
          Row(
            children: [
              Text(
                "Chairperson Elections",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xFF6A6A6A),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  ChairPersonEx().exportChairPerson(widget.chairMemberStartDate,
                      widget.chairMemberEndDate, membersWhoAccepted);
                },
                child: Text(
                  "Export Result in Excel",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                '${widget.chairMemberStartDate}   -   ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color(0xFF6A6A6A),
                ),
              ),
              Text(
                widget.chairMemberEndDate,
                style: TextStyle(
                    color: Color(0xFF6A6A6A),
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: MyUtility(context).width / 6,
                child: Text(
                  "Name",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF6A6A6A),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              SizedBox(
                width: MyUtility(context).width / 9,
                child: Text(
                  "SAMA",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF6A6A6A),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: MyUtility(context).width / 9,
                child: Text(
                  "HPCSA",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF6A6A6A),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: MyUtility(context).width / 11,
                child: Text(
                  "HDI Status",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF6A6A6A),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: MyUtility(context).width / 11,
                child: Text(
                  "Votes",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF6A6A6A),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: Color(0xFFD1D1D1),
          ),
          SizedBox(
            height: 8,
          ),
          for (int i = 0; i < membersWhoAccepted.length; i++)
            Column(children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MyUtility(context).width / 6,
                    child: Text(
                      membersWhoAccepted[i]['name'],
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6A6A6A),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: MyUtility(context).width / 8,
                    child: Text(
                      membersWhoAccepted[i]['SamaNr'],
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6A6A6A),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    width: MyUtility(context).width / 8,
                    child: Text(
                      membersWhoAccepted[i]['hpca'],
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6A6A6A),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    width: MyUtility(context).width / 11,
                    child: Text(
                      membersWhoAccepted[i]['hdiStatus'],
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6A6A6A),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    width: MyUtility(context).width / 11,
                    child: Text(
                      membersWhoAccepted[i]['votes'],
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6A6A6A),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ])
        ])));
  }
}
