import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/Login/popups/validateDialog.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';

import '../../../components/service/commonService.dart';

class MemberElectionsRound2 extends StatefulWidget {
  String branch;
  String position;
  String electionId;
  String votingCount;
  String startDate;
  String endDate;
  List electionVotes;
  MemberElectionsRound2(
      {super.key,
      required this.branch,
      required this.position,
      required this.electionId,
      required this.votingCount,
      required this.startDate,
      required this.endDate,
      required this.electionVotes});

  @override
  State<MemberElectionsRound2> createState() => _MemberElectionsRound2State();
}

class _MemberElectionsRound2State extends State<MemberElectionsRound2> {
  //var
  List membersWhoAccepted = [];
  List voteList = [];
  List nominations = [];
  var voteAmount = 0;

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
      "hdiStatus":
          '${doc!["race"] == "White/Caucasian" || doc!["race"] == "Other" ? "" : "HDI"} ',
      "email": "${doc.get("email")}",
      "nominations": getNominationsForUser(doc.get("email"))
    };
    setState(() {
      if (getNominationsForUser(userData['email']) >= 2) {
        if (result) {
          membersWhoAccepted.add(userData);
        }
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

//check if member alread in list
  checkIfVoted(email) {
    var voteIndex = (widget.electionVotes).indexWhere((item) =>
        item['email'] == email &&
        item['userWhoVoted'] == FirebaseAuth.instance.currentUser!.uid);

    if (voteIndex != -1) {
      return true;
    } else {
      return false;
    }
  }

//vote for member add to list
  voteForMember(email) {
    var voteDetails = {
      "email": email,
      "userWhoVoted": FirebaseAuth.instance.currentUser!.uid
    };

    setState(() {
      if (checkIfVoted(email)) {
        var voteIndex = (widget.electionVotes).indexWhere((item) =>
            item['email'] == email &&
            item['userWhoVoted'] == FirebaseAuth.instance.currentUser!.uid);

        widget.electionVotes.removeAt(voteIndex);
        voteAmount = voteAmount + 1;
      } else if (voteAmount == 0) {
        validateVotes();
        return;
      } else {
        widget.electionVotes.add(voteDetails);
        voteAmount = voteAmount - 1;
      }
      submitVotes();
    });
  }

  //Dialog for validation popup
  Future validateVotes() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: ValidateDialog(
                description: "Vote Limit Reached",
                closeDialog: () => Navigator.pop(context!)));
      });

//Send votes to db
  submitVotes() async {
    final doc = await FirebaseFirestore.instance
        .collection('elections')
        .doc(widget.electionId)
        .update({"electionVotes": widget.electionVotes});
  }

  @override
  void initState() {
    getUserNotificationList();
    voteAmount = int.parse(widget.votingCount);
    getNominations();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Voting round open for ${widget.branch}',
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
          'You have ${voteAmount} out of  ${widget.votingCount} votes left.',
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
          color: Colors.white,
          width: MyUtility(context).width - (MyUtility(context).width * 0.25),
          child: Table(
            columnWidths: {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
              3: FlexColumnWidth(1.2),
            },
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Sama Number',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('HDI Status',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Vote',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ],
              ),
              for (int i = 0; i < membersWhoAccepted.length; i++)
                TableRow(
                    decoration: BoxDecoration(
                      color: i % 2 == 0 ? Colors.transparent : Colors.grey[200],
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
                          '${membersWhoAccepted[i]["SamaNr"]}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${membersWhoAccepted[i]["name"]}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${membersWhoAccepted[i]["hdiStatus"]} ',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            voteForMember(membersWhoAccepted[i]["email"]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 60),
                            child: Container(
                              width: 25,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: (checkIfVoted(
                                            membersWhoAccepted[i]["email"]) ==
                                        true)
                                    ? Color(0xFF174486)
                                    : Colors.grey,
                              ),
                              child: Align(
                                alignment: (checkIfVoted(
                                            membersWhoAccepted[i]["email"]) ==
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
                    ])
            ],
          ),
        ),
      ],
    );
  }
}

/*

      children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '1 ',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${document!["firstName"]} ${document!["lastName"]}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${document!["hpcsa"]} ',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (document != null) {
                        bool currentState = false;
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 60),
                      child: Container(
                        width: 25,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: (checkIfVoted() == true)
                              ? Color(0xFF174486)
                              : Colors.grey,
                        ),
                        child: Align(
                          alignment: (checkIfVoted() == true)
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
        

 */
