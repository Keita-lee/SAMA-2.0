import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/service/commonService.dart';

class Round2Election extends StatefulWidget {
  String electionDateStart;
  String electionDateEnd;
  String electionId;
  List electionVotes;
  bool hdiCompliant;

  Round2Election(
      {super.key,
      required this.electionDateStart,
      required this.electionDateEnd,
      required this.electionId,
      required this.electionVotes,
      required this.hdiCompliant});

  @override
  State<Round2Election> createState() => _Round2ElectionState();
}

class _Round2ElectionState extends State<Round2Election> {
  //var
  List membersWhoAccepted = [];
  List nominations = [];

  getVotes(email) {
    var totalVotes = 0;
    for (int i = 0; i < (widget.electionVotes).length; i++) {
      if (widget.electionVotes[i]['email'] == email) {
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
      "hpca": doc.get("hpcsaNumber"),
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
      padding: const EdgeInsets.all(25.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          CommonService().checkDateStarted(widget.electionDateStart) == "After"
              ? "Round 2 elections has Finished"
              : "Round 2 elections has not yet Finished",
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
              widget.hdiCompliant ? "Enabled" : "Disabled",
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
          width: MyUtility(context).width / 0.8,
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
                "Votes",
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
          width: MyUtility(context).width / 0.8,
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
                SizedBox(
                  width: MyUtility(context).width / 11,
                  child: Text(
                    membersWhoAccepted[i]['hdiStatus'],
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF174486),
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: MyUtility(context).width / 11,
                  child: Text(
                    membersWhoAccepted[i]['votes'],
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
