import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class Round1NominationsFinished extends StatefulWidget {
  String nominationStartDate;
  String nominationEndDate;
  String electionId;
  Round1NominationsFinished(
      {super.key,
      required this.nominationStartDate,
      required this.nominationEndDate,
      required this.electionId});

  @override
  State<Round1NominationsFinished> createState() =>
      _Round1NominationsFinishedState();
}

class _Round1NominationsFinishedState extends State<Round1NominationsFinished> {
  List membersWhoAreNominated = [];

  //get user details from notification
  getUserDetail(id) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    var userData = {
      "SamaNr": "9088466",
      "name": "${doc.get("firstName")} ${doc.get("lastName")}",
      "hdiStatus": "HDI",
      "email": "${doc.get("email")}",
      "nominations": ""
    };
    setState(() {
      membersWhoAreNominated.add(userData);
    });
  }

//TODO get real branch number
  //get User Notification list who accepted nomination
  getUserNotificationList() async {
    final doc = await FirebaseFirestore.instance
        .collection('notifications')
        .where("data.electionId", isEqualTo: widget.electionId)
        .get();
    setState(() {
      for (int i = 0; i < (doc.docs).length; i++) {
        getUserDetail(doc.docs[i]["userWhoNotify"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Round 1 nominations",
        style: TextStyle(
            fontSize: 22,
            color: Color(0xFF174486),
            fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        "Round 1 Nominations from ${widget.nominationStartDate} - ${widget.nominationEndDate}",
        style: TextStyle(
            fontSize: 18,
            color: Color(0xFF174486),
            fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        "Round 1 Nominations has Finished",
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
            "HDI compliance checks for nominations:",
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF174486),
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Disabled",
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
      Container(
        color: Colors.grey,
        height: 1,
        width: MyUtility(context).width / 1.4,
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
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            width: MyUtility(context).width / 8,
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
          Text(
            "Nominations",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF174486),
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
      SizedBox(
        height: 8,
      ),
      Container(
        color: Colors.grey,
        height: 1,
        width: MyUtility(context).width / 1.4,
      ),
    ]);
  }
}
