import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/login/popups/validateDialog.dart';

class MemberElectionRound1 extends StatefulWidget {
  String branch;
  String electionId;
  String position;
  String votingCount;
  String acceptDate;
  bool hdiStatus;
  MemberElectionRound1(
      {super.key,
      required this.branch,
      required this.electionId,
      required this.position,
      required this.votingCount,
      required this.acceptDate,
      required this.hdiStatus});

  @override
  State<MemberElectionRound1> createState() => _MemberElectionRound1State();
}

class _MemberElectionRound1State extends State<MemberElectionRound1> {
  //var
  List nominationData = [];
  var userNominateCount = 0;

//get nomination made by user
  getUsersNominations() async {
    final data = await FirebaseFirestore.instance
        .collection('nominations')
        .where("userIdWho", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      nominationData.clear();
      nominationData.addAll(data.docs);
      userNominateCount = data.docs.length;
    });
  }

  // nominate a user
  nominateUser(email, id) async {
    var nomineeData = {
      "id": "",
      "nominee": email,
      "userIdWho": FirebaseAuth.instance.currentUser!.uid,
      "electionId": widget.electionId
    };

    var nomIndex =
        nominationData.indexWhere((item) => item["nominee"] == email);

    if (nomIndex == -1) {
      if (int.parse(widget.votingCount) == userNominateCount) {
        return openValidateDialog();
      }
      //Add
      final doc = FirebaseFirestore.instance.collection('nominations').doc();
      nomineeData["id"] = doc.id;
      sendNomineeANotification(id);
      final json = nomineeData;
      doc.set(json).whenComplete(getUsersNominations());
      setState(() {
        userNominateCount = userNominateCount + 1;
      });
    } else {
      //remove
      setState(() {
        userNominateCount = userNominateCount - 1;
      });
      FirebaseFirestore.instance
          .collection('nominations')
          .doc(nominationData[nomIndex]["id"])
          .delete()
          .whenComplete(getUsersNominations());
    }
  }

//check if user already nominated
  checkIfNominated(email) {
    var nomIndex =
        nominationData.indexWhere((item) => item["nominee"] == email);
    if (nomIndex == -1) {
      return false;
    } else {
      return true;
    }
  }

//check if the notification already sent
  checkIfNotificationAlreadySent(id) async {
    var notificationSent = false;
    final doc = await FirebaseFirestore.instance
        .collection('notifications')
        .where("userWhoNotify", isEqualTo: id)
        .get();

    for (int i = 0; i < (doc.docs).length; i++) {
      if (doc.docs[i]['data']['electionId'] == "orIEplhDstxiWQdSLHlK") {
        notificationSent = true;
      }
    }
    return notificationSent;
  }

//send nominee a notification
  sendNomineeANotification(id) async {
    var notificationData = {
      "id": "",
      "userWhoNotify": id,
      "date": DateTime.now(),
      "message":
          "You have been Nominated for ${widget.position} at ${widget.branch} Branch",
      "read": false,
      "type": "Nomination",
      "data": {
        "electionId": "orIEplhDstxiWQdSLHlK",
        "acceptDate": widget.acceptDate,
        "accept": false
      }
    };

//check if Notifcation Already Sent
    var notificationSent = false;
    final notificationDoc = await FirebaseFirestore.instance
        .collection('notifications')
        .where("userWhoNotify", isEqualTo: id)
        .get();

    for (int i = 0; i < (notificationDoc.docs).length; i++) {
      if (notificationDoc.docs[i]['data']['electionId'] ==
          "orIEplhDstxiWQdSLHlK") {
        notificationSent = true;
      }
    }
    if (!notificationSent) {
      //Add
      final doc = FirebaseFirestore.instance.collection('notifications').doc();
      notificationData["id"] = doc.id;

      final json = notificationData;
      doc.set(json);
    }
  }

  //Dialog for nominate limit
  Future openValidateDialog() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: ValidateDialog(
                description: "Nomination Limit Reached",
                closeDialog: () => Navigator.pop(context!)));
      });

  @override
  void initState() {
    getUsersNominations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Text(
              'Current Nominations ${userNominateCount} / ${widget.votingCount}',
              style: TextStyle(
                fontSize: 28,
                color: Color(0xFF3D3D3D),
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: MyUtility(context).width * 0.8,
          height: MyUtility(context).height / 2,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          /* .where("selectBranch",
                              isEqualTo: "Border Coastal (BCB)")*/
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (!snapshot.hasData) {
                          return const Text('Loading...');
                        }

                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;
                        if (documents.isEmpty) {
                          return Center(child: Text('No Events listed'));
                        }

                        return Container(
                          width: MyUtility(context).width -
                              (MyUtility(context).width * 0.25),
                          child: Table(
                            columnWidths: {
                              0: FlexColumnWidth(3),
                              1: FlexColumnWidth(3),
                              2: FlexColumnWidth(3),
                              3: FlexColumnWidth(1),
                              4: FlexColumnWidth(1.2),
                            },
                            children: [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Email',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('HPCSA',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('HDI',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Nominate',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ),
                                ],
                              ),
                              ...documents.map((DocumentSnapshot document) {
                                Map<String, dynamic>? data =
                                    document.data() as Map<String, dynamic>?;
                                bool isEven =
                                    documents.indexOf(document) % 2 == 0;
                                return TableRow(
                                  decoration: BoxDecoration(
                                    color: isEven
                                        ? Colors.transparent
                                        : Colors.grey[200],
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color(0xFFD1D1D1),
                                      ),
                                    ),
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${data!["firstName"]} ${data!["lastName"]}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${data!["email"]} ',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${data!["hpcsa"]} ',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${data!["race"] == "White/Caucasian" || data!["race"] == "Other" ? "" : "HDI"} ',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          nominateUser(
                                              data!["email"], data!["id"]);
                                          if (data != null) {
                                            bool currentState =
                                                checkIfNominated(
                                                    data!["email"]);
                                          }
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 60),
                                          child: Container(
                                            width: 25,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              color: (checkIfNominated(
                                                          data!["email"]) ==
                                                      true)
                                                  ? Color(0xFF174486)
                                                  : Colors.grey,
                                            ),
                                            child: Align(
                                              alignment: (checkIfNominated(
                                                          data!["email"]) ==
                                                      true)
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
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
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
