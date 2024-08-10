import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../../components/myutility.dart';
import '../../Excel/round1Ex.dart';

class Round1OverView extends StatefulWidget {
  String startDate;
  String endDate;
  String electionId;
  String branch;
  Round1OverView(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.electionId,
      required this.branch});

  @override
  State<Round1OverView> createState() => _Round1OverViewState();
}

class _Round1OverViewState extends State<Round1OverView> {
  List membersWhoAreNominated = [];
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
      membersWhoAreNominated
          .sort((b, a) => a["nominations"].compareTo(b["nominations"]));
    });
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
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Round 1 Nominations",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Color(0xFF6A6A6A),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Round1Excel().exportRound1(widget.startDate, widget.endDate,
                        membersWhoAreNominated, widget.branch);
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
                  '${widget.startDate}   -   ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color(0xFF6A6A6A),
                  ),
                ),
                Text(
                  widget.endDate,
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
                    "SAMA No",
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
                SizedBox(
                  width: MyUtility(context).width / 8,
                  child: Text(
                    "Nominations",
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
            for (int i = 0; i < membersWhoAreNominated.length; i++)
              Column(children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MyUtility(context).width / 6,
                      child: Text(
                        membersWhoAreNominated[i]['name'],
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
                        membersWhoAreNominated[i]['SamaNr'],
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF6A6A6A),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      width: MyUtility(context).width / 8,
                      child: Text(
                        membersWhoAreNominated[i]['hpca'],
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF6A6A6A),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      width: MyUtility(context).width / 8,
                      child: Text(
                        membersWhoAreNominated[i]['nominations'],
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF6A6A6A),
                            fontWeight: FontWeight.w400),
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
              ]),
          ],
        ),
      ),
    );
  }
}
