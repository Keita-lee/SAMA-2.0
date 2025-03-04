import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/service/commonService.dart';

class NominationAcceptanceRound extends StatefulWidget {
  String nominateAcceptStartDate;
  String nominateAcceptEndDate;
  String electionId;
  NominationAcceptanceRound(
      {super.key,
      required this.nominateAcceptEndDate,
      required this.nominateAcceptStartDate,
      required this.electionId});

  @override
  State<NominationAcceptanceRound> createState() =>
      _NominationAcceptanceRoundState();
}

class _NominationAcceptanceRoundState extends State<NominationAcceptanceRound> {
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
      "hpca": doc.get("hpcsaNumber"),
      "hdiStatus": "HDI",
      "email": "${doc.get("email")}",
      "state": "Elected",
      "result": result == true ? "Accept" : "Declined",
      "notificationId": notificationId
    };
    setState(() {
      if (getNominationsForUser(doc.get("email")) >= 2) {
        membersWhoAccepted.add(userData);
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
      padding: const EdgeInsets.all(25.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          width: MyUtility(context).width / 0.8,
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
          width: MyUtility(context).width / 0.8,
        ),
        SizedBox(
          height: 25,
        ),
        for (int i = 0; i < membersWhoAccepted.length; i++)
          Column(children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: MyUtility(context).width / 8,
                  child: Text(
                    membersWhoAccepted[i]['SamaNr'],
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF174486),
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: MyUtility(context).width / 8,
                  child: Text(
                    membersWhoAccepted[i]['hpca'],
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF174486),
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: MyUtility(context).width / 6,
                  child: Text(
                    membersWhoAccepted[i]['name'],
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF174486),
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Spacer(),
                Text(
                  membersWhoAccepted[i]['state'],
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF174486),
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
                          alignment: membersWhoAccepted[i]['result'] == "Accept"
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
                        color: Color(0xFF174486),
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
      ]),
    );
  }
}
