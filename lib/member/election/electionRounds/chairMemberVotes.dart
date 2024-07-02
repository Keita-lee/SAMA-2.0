import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/login/popups/validateDialog.dart';

class ChairMemberVotes extends StatefulWidget {
  List voteChareMemberList;
  List chairmemberVoteList;
  String votingCount;
  String electionId;
  List electionVotes;
  ChairMemberVotes(
      {super.key,
      required this.voteChareMemberList,
      required this.chairmemberVoteList,
      required this.votingCount,
      required this.electionId,
      required this.electionVotes});

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
        totalVotes = totalVotes + 1;
      }
    }
    return '${totalVotes}';
  }

  //get user details from notification
  getUserDetail(id) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(id).get();

    var userData = {
      "id": "${doc.get("id")}",
      "SamaNr": "15658",
      "name": "${doc.get("firstName")} ${doc.get("lastName")}",
      "hpca": doc.get("hpcsa"),
      "email": "${doc.get("email")}",
      "votes": getVotes(doc.get("email"))
    };
    print("TEST");
    setState(() {
      if (getNominationsForUser(doc.get("email")) >= 2 &&
          membersWhoAccepted.length <= int.parse(widget.votingCount)) {
        membersWhoAccepted.add(userData);
        print(userData);
      }
    });
    print("TEST");
  }

  //get User Notification list who accepted nomination
  getUserNotificationList() async {
    final doc = await FirebaseFirestore.instance
        .collection('notifications')
        .where("data.electionId", isEqualTo: "orIEplhDstxiWQdSLHlK")
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

        voteAmount = voteAmount - 1;
      } else {
        if (voteAmount == 0) {
          validateVotes();
        } else {
          setState(() {
            voteAmount = voteAmount + 1;
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
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: MyUtility(context).width / 1.6,
            ),
            Text('Votes Left ${voteAmount}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
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
              3: FlexColumnWidth(1.3),
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
                        child: Text('Vote',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                voteForMember(
                                    widget.voteChareMemberList[i]["email"]);
                                //  voteForMember(membersWhoAccepted[i]["email"]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 60),
                                child: Container(
                                  width: 25,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: (checkIfVoted(
                                                widget.voteChareMemberList[i]
                                                    ["email"]) ==
                                            true)
                                        ? Color(0xFF174486)
                                        : Colors.grey,
                                  ),
                                  child: Align(
                                    alignment: (checkIfVoted(
                                                widget.voteChareMemberList[i]
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
