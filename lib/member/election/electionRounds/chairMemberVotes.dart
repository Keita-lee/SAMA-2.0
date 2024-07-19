import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/login/popups/validateDialog.dart';

import '../../../components/service/commonService.dart';

class ChairMemberVotes extends StatefulWidget {
  List voteChareMemberList;
  List chairmemberVoteList;
  String votingCount;
  String electionId;
  List electionVotes;
  String startDate;
  String endDate;
  String branch;
  ChairMemberVotes(
      {super.key,
      required this.voteChareMemberList,
      required this.chairmemberVoteList,
      required this.votingCount,
      required this.electionId,
      required this.electionVotes,
      required this.startDate,
      required this.endDate,
      required this.branch});

  @override
  State<ChairMemberVotes> createState() => _ChairMemberVotesState();
}

class _ChairMemberVotesState extends State<ChairMemberVotes> {
  List chairMemberVoteList = [];
  List membersWhoAccepted = [];
  List nominations = [];
  var voteAmount = 1;
  getVotes(email) {
    var totalVotes = 0;
    for (int i = 0; i < (widget.electionVotes).length; i++) {
      if (widget.electionVotes[i]['email'] == email) {
        totalVotes = totalVotes - 1;
      }
    }
    return '${totalVotes}';
  }

  //get user details from notification
  getUserDetail(id) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: id)
        .get();

    var userData = {
      "id": "${doc.docs[0].get("id")}",
      "SamaNr": "15658",
      "name": "${doc.docs[0].get("firstName")} ${doc.docs[0].get("lastName")}",
      "hpca": doc.docs[0].get("hpcsa"),
      "email": "${doc.docs[0].get("email")}",
      "hdi":
          '${doc.docs[0]["race"] == "White/Caucasian" || doc.docs[0]["race"] == "Other" ? "" : "HDI"}',
      "votes": getVotes(doc.docs[0].get("email"))
    };

    setState(() {
      var nomIndex =
          (membersWhoAccepted).indexWhere((item) => item["email"] == id);

      if (nomIndex == -1) {
        membersWhoAccepted.add(userData);
      }
    });
  }

  //get User Notification list who accepted nomination
  getUserNotificationList() async {
    setState(() {
      for (int i = 0; i < (widget.electionVotes).length; i++) {
        getUserDetail(widget.electionVotes[i]['email']);
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

//vote for member add to list
  voteForMember(email) {
    var voteDetails = {
      "email": email,
      "userWhoVoted": FirebaseAuth.instance.currentUser!.uid
    };

    setState(() {
      if (checkIfVoted(email)) {
        var voteIndex = (widget.chairmemberVoteList).indexWhere((item) =>
            item['email'] == email &&
            item['userWhoVoted'] == FirebaseAuth.instance.currentUser!.uid);

        widget.chairmemberVoteList.removeAt(voteIndex);

        voteAmount = voteAmount + 1;
      } else {
        if (voteAmount == 0 || voteAmount < 0) {
          validateVotes();
        } else {
          setState(() {
            voteAmount = voteAmount - 1;
          });
          widget.chairmemberVoteList.add(voteDetails);
        }

        //    voteAmount = voteAmount - 1;
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

  //check if member alread in list
  checkIfVoted(email) {
    var voteIndex = (widget.chairmemberVoteList).indexWhere((item) =>
        item['email'] == email &&
        item['userWhoVoted'] == FirebaseAuth.instance.currentUser!.uid);

    if (voteIndex != -1) {
      return true;
    } else {
      return false;
    }
  }

  //Send votes to db
  submitVotes() async {
    final doc = await FirebaseFirestore.instance
        .collection('elections')
        .doc(widget.electionId)
        .update({"chairmanVotes": widget.chairmemberVoteList});
  }

  @override
  void initState() {
    getNominations();
    getUserNotificationList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chair member vote round open for ${widget.branch}',
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
          'Period ${CommonService().getDateInText(widget.startDate)} to ${CommonService().getDateInText(widget.endDate)}',
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
          'You have ${voteAmount} out of  1 votes left.',
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 58, 65, 65),
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(
          height: 25,
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
                        child: Text(membersWhoAccepted[i]['SamaNr'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(membersWhoAccepted[i]['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(membersWhoAccepted[i]['hdi'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                voteForMember(membersWhoAccepted[i]["email"]);
                                //  voteForMember(membersWhoAccepted[i]["email"]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 60),
                                child: Container(
                                  width: 25,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: (checkIfVoted(membersWhoAccepted[i]
                                                ["email"]) ==
                                            true)
                                        ? Color(0xFF174486)
                                        : Colors.grey,
                                  ),
                                  child: Align(
                                    alignment: (checkIfVoted(
                                                membersWhoAccepted[i]
                                                    ["email"]) ==
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
                              )))
                    ])
            ],
          ),
        ),
      ],
    );
  }
}
