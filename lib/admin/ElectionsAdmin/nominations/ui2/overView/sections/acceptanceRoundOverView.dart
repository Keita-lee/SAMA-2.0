import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../../components/myutility.dart';
import '../../../../../../components/service/commonService.dart';
import '../../Excel/acceptanceRoundEx.dart';

class Acceptanceroundoverview extends StatefulWidget {
  String nominateAcceptStartDate;
  String nominateAcceptEndDate;
  String electionId;

  Acceptanceroundoverview(
      {super.key,
      required this.nominateAcceptStartDate,
      required this.nominateAcceptEndDate,
      required this.electionId});

  @override
  State<Acceptanceroundoverview> createState() =>
      _AcceptanceroundoverviewState();
}

class _AcceptanceroundoverviewState extends State<Acceptanceroundoverview> {
  //var
  List membersWhoAccepted = [];
  List nominations = [];

  //get user details from notification
  getUserDetail(id, result, notificationId) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(id).get();

    var count = 0;
    var userData = {
      "SamaNr": "9088466",
      "name": "${doc.get("firstName")} ${doc.get("lastName")}",
      "hpca": doc.get("hpcsa"),
      "hdiStatus": "HDI",
      "email": "${doc.get("email")}",
      "state": "Nominated",
      "nominated": getNominationsForUser(doc.get("email")),
      "result": result == true ? "Accept" : "Declined",
      "notificationId": notificationId
    };
    setState(() {
      if (getNominationsForUser(doc.get("email")) >= 2) {
        membersWhoAccepted.add(userData);

        membersWhoAccepted
            .sort((b, a) => a["nominated"].compareTo(b["nominated"]));
      }
    });
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
        getUserDetail(doc.docs[i]["userWhoNotify"], doc.docs[i]["data.accept"],
            doc.docs[i]["id"]);
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

  acceptNominationForUser(nomId, value) async {
    final doc = await FirebaseFirestore.instance
        .collection('notifications')
        .doc(nomId)
        .update({"data.accept": value});
    setState(() {
      var nomIndex = (membersWhoAccepted)
          .indexWhere((item) => item["notificationId"] == nomId);

      membersWhoAccepted[nomIndex]['result'] = value ? "Accept" : "Declined";
    });
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
                "Nomiantion Acceptance Round",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xFF6A6A6A),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  AcceptanceRoundExcel().exportAcceptance(
                      widget.nominateAcceptStartDate,
                      widget.nominateAcceptEndDate,
                      membersWhoAccepted);
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
                '${widget.nominateAcceptStartDate}   -   ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color(0xFF6A6A6A),
                ),
              ),
              Text(
                widget.nominateAcceptEndDate,
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
                width: MyUtility(context).width / 8,
                child: Text(
                  "SAMA",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF6A6A6A),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: MyUtility(context).width / 8,
                child: Text(
                  "HPCSA",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF6A6A6A),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "State",
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF6A6A6A),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Result",
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF6A6A6A),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 15,
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
                  Text(
                    membersWhoAccepted[i]['state'],
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6A6A6A),
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Visibility(
                    visible: CommonService()
                            .checkDateStarted(widget.nominateAcceptEndDate) ==
                        "Before",
                    child: GestureDetector(
                      onTap: () {
                        acceptNominationForUser(
                            membersWhoAccepted[i]['notificationId'],
                            membersWhoAccepted[i]['result'] == "Accept"
                                ? false
                                : true);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: membersWhoAccepted[i]['result'] == "Accept"
                                ? Color(0xFF174486)
                                : Colors.grey, // Update this line
                          ),
                          child: Align(
                            alignment:
                                membersWhoAccepted[i]['result'] == "Accept"
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft, // Update this line
                            child: Container(
                              width: 20,
                              height: 20,
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: CommonService()
                            .checkDateStarted(widget.nominateAcceptEndDate) ==
                        "After",
                    child: Text(
                      membersWhoAccepted[i]['result'],
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
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.grey,
                height: 0.5,
                width: MyUtility(context).width / 0.8,
              ),
            ])
        ])));
  }
}
