import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/login/popups/validateDialog.dart';
import 'package:sama/member/election/viewMemberBio.dart';

import '../../../../components/email/sendElectionUpdates.dart';
import '../../../../components/service/commonService.dart';
import 'acceptNomination.dart';

class MemberElectionRound1 extends StatefulWidget {
  String branch;
  String electionId;
  String position;
  String votingCount;
  String acceptDate;
  String startDate;
  String endDate;
  bool hdiStatus;
  MemberElectionRound1(
      {super.key,
      required this.branch,
      required this.electionId,
      required this.position,
      required this.votingCount,
      required this.acceptDate,
      required this.startDate,
      required this.endDate,
      required this.hdiStatus});

  @override
  State<MemberElectionRound1> createState() => _MemberElectionRound1State();
}

class _MemberElectionRound1State extends State<MemberElectionRound1> {
  //var
  List nominationData = [];
  var userNominateCount = 0;

//Textediting controller
  final search = TextEditingController();

//get nomination made by user
  getUsersNominations() async {
    final data = await FirebaseFirestore.instance
        .collection('nominations')
        .where("userIdWho", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("electionId", isEqualTo: "ngZiVRVWoMETIGm0VPgj")
        .get();
    setState(() {
      nominationData.clear();
      nominationData.addAll(data.docs);
      userNominateCount = data.docs.length;
    });
  }

  sendUserEmailUpdate(nomDates, email) async {
    sendElectionUpdate(
        description: "You have been nominated",
        nomDates: nomDates,
        acceptanceDates: "",
        election: "",
        chairDates: "",
        email: "chrispotjnr@gmail.com");
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
      //Add 123
      final doc = FirebaseFirestore.instance.collection('nominations').doc();
      nomineeData["id"] = doc.id;
      sendNomineeANotification(id);
      final json = nomineeData;
      doc.set(json).whenComplete(getUsersNominations());
      setState(() {
        userNominateCount = userNominateCount + 1;
        sendUserEmailUpdate("${widget.startDate} - Widget.endDate", email);
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
      if (nominationData[nomIndex]['userIdWho'] ==
          FirebaseAuth.instance.currentUser!.uid) {
        return true;
      } else {
        return false;
      }
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
      if (doc.docs[i]['data']['electionId'] == "ngZiVRVWoMETIGm0VPgj") {
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
        "electionId": "ngZiVRVWoMETIGm0VPgj",
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
          "ngZiVRVWoMETIGm0VPgj") {
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

  //Dialog for nominate limit
  Future viewMemberBioDialog(memberId) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: ViewMemberBio(
          closeDialog: () => Navigator.pop(context!),
          memberId: memberId,
        ));
      });

  searchList(name, surname, email, hpcsa, samaNo) {
    if (search.text == "") {
      return true;
    } else if (search.text.contains(name) ||
        search.text.contains(surname) ||
        search.text.contains(email) ||
        search.text.contains(name) ||
        search.text.contains(samaNo)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    getUsersNominations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AcceptNomination(
            branch: widget.branch,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Nomination round open for ${widget.branch}',
            style: TextStyle(
              fontSize: 25,
              color: Color.fromARGB(255, 0, 159, 158),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Period: ${CommonService().getDateInText(widget.startDate)} to ${CommonService().getDateInText(widget.endDate)}',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 58, 65, 65),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Text(
            'You have ${userNominateCount} out of  ${widget.votingCount} nominations left.',
            style: TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 58, 65, 65),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 250,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Color.fromRGBO(170, 170, 170, 1.0)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: search,
                  onEditingComplete: () {
                    setState(() {});
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 10),
                    hintText: 'Search and enter',
                    border: InputBorder.none,
                    hintStyle:
                        TextStyle(color: Color.fromRGBO(170, 170, 170, 1.0)),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(
                width: MyUtility(context).width / 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Name',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
              ),
              SizedBox(
                width: MyUtility(context).width / 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Email',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
              ),
              SizedBox(
                width: MyUtility(context).width / 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('HPCSA',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
              ),
              SizedBox(
                width: MyUtility(context).width / 12,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('HDI',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
              ),
              SizedBox(
                width: MyUtility(context).width / 12,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Nominate',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
              ),
              SizedBox(
                width: MyUtility(context).width / 12,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
                                color: Colors.white,
                                width: MyUtility(context).width -
                                    (MyUtility(context).width * 0.25),
                                height: 500,
                                //color: Colors.transparent,
                                child: ListView.builder(
                                    itemCount: documents.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final DocumentSnapshot document =
                                          documents[index];

                                      return Visibility(
                                        visible: searchList(
                                            document["firstName"],
                                            document["lastName"],
                                            document["email"],
                                            document["hpcsaNumber"],
                                            document["firstName"]),
                                        child: Container(
                                            width: MyUtility(context).width -
                                                (MyUtility(context).width *
                                                    0.25),
                                            color: index.isEven
                                                ? Colors.transparent
                                                : Colors.grey[200],
                                            child: Row(children: [
                                              SizedBox(
                                                width:
                                                    MyUtility(context).width /
                                                        5,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '${document!["firstName"]} ${document!["lastName"]}',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    MyUtility(context).width /
                                                        7,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '${document!["email"]} ',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    MyUtility(context).width /
                                                        7,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '${document!["hpcsaNumber"]} ',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    MyUtility(context).width /
                                                        12,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '${document!["race"] == "White/Caucasian" || document!["race"] == "Other" ? "" : "HDI"} ',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    MyUtility(context).width /
                                                        12,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      nominateUser(
                                                          document!["email"],
                                                          document!["id"]);
                                                      if (document != null) {
                                                        bool currentState =
                                                            checkIfNominated(
                                                                document![
                                                                    "email"]);
                                                      }
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 60),
                                                      child: Container(
                                                        width: 45,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                          color: (checkIfNominated(
                                                                      document![
                                                                          "email"]) ==
                                                                  true)
                                                              ? Color(
                                                                  0xFF174486)
                                                              : Colors.grey,
                                                        ),
                                                        child: Align(
                                                          alignment: (checkIfNominated(
                                                                      document![
                                                                          "email"]) ==
                                                                  true)
                                                              ? Alignment
                                                                  .centerRight
                                                              : Alignment
                                                                  .centerLeft,
                                                          child: Container(
                                                            width: 20,
                                                            height: 20,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    5.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    MyUtility(context).width /
                                                        12,
                                                child: InkWell(
                                                  onTap: () {
                                                    viewMemberBioDialog(
                                                        document["id"]);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'View Profile',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Color(
                                                              0xFF174486)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ])),
                                      );
                                    }));
                          })

                      /*    Container(
                            width: MyUtility(context).width -
                                (MyUtility(context).width * 0.25),
                            child: Table(
                              columnWidths: {
                                0: FlexColumnWidth(3),
                                1: FlexColumnWidth(3),
                                2: FlexColumnWidth(3),
                                3: FlexColumnWidth(1),
                                4: FlexColumnWidth(1.6),
                                5: FlexColumnWidth(1.2)
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('',
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
                                        child: InkWell(
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
                                              width: 45,
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
                                      InkWell(
                                        onTap: () {
                                          viewMemberBioDialog(data["id"]);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'View Profile',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFF174486)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ],
                            ),
                          );
                   */
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
