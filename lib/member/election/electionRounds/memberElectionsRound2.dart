import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/Login/popups/validateDialog.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';

final List<List<String>> tableData = [
  ['9088466', 'John Doe', 'HDI', '2'],
  ['9088466', 'Jane Smith', 'HDI', '8'],
  ['9088466', 'Alice Brown', 'HDI', '0'],
  ['9088466', 'Bob White', 'HDI', '12'],
  ['9088466', 'Eve Black', 'HDI', '3'],
  ['9088466', 'Tom Blue', 'HDI', '2'],
];

class MemberElectionsRound2 extends StatefulWidget {
  String branch;
  String position;
  MemberElectionsRound2(
      {super.key, required this.branch, required this.position});

  @override
  State<MemberElectionsRound2> createState() => _MemberElectionsRound2State();
}

class _MemberElectionsRound2State extends State<MemberElectionsRound2> {
  //var
  List membersWhoAccepted = [];
  List voteList = [];
  var voteAmount = 3;
//get user details from notification
  getUserDetail(id) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    var userData = {
      "SamaNr": "9088466",
      "name": "${doc.get("firstName")} ${doc.get("lastName")}",
      "hdiStatus": "HDI",
      "email": "${doc.get("email")}",
      "vote": ""
    };
    setState(() {
      membersWhoAccepted.add(userData);
    });
  }

//TODO get real branch number
  //get User Notification list who accepted nomination
  getUserNotificationList() async {
    final doc = await FirebaseFirestore.instance
        .collection('notifications')
        .where("data.electionId", isEqualTo: "orIEplhDstxiWQdSLHlK")
        .where("data.accept", isEqualTo: true)
        .get();
    setState(() {
      for (int i = 0; i < (doc.docs).length; i++) {
        getUserDetail(doc.docs[i]["userWhoNotify"]);
      }
    });
  }

//check if member alread in list
  checkIfVoted(email) {
    if (voteList.contains(email)) {
      return true;
    } else {
      return false;
    }
  }

//vote for member add to list
  voteForMember(email) {
    setState(() {
      if (checkIfVoted(email)) {
        var voteIndex = voteList.indexWhere((item) => item == email);
        voteList.removeAt(voteIndex);
        voteAmount = voteAmount + 1;
      } else if (voteAmount == 0) {
        validateVotes();
        return;
      } else {
        voteList.add(email);
        voteAmount = voteAmount - 1;
      }
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

  @override
  void initState() {
    getUserNotificationList();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Votes Left ${voteAmount}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(
              width: 15,
            ),
            StyleButton(
                description: "Submit Vote",
                height: 55,
                width: 125,
                onTap: () {})
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
