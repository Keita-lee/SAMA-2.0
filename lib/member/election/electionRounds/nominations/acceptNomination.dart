import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../components/electionTabStyle.dart';
import '../../../../components/myutility.dart';
import '../../../../components/yesNoDialog.dart';

class AcceptNomination extends StatefulWidget {
  String branch;
  AcceptNomination({super.key, required this.branch});

  @override
  State<AcceptNomination> createState() => _AcceptNominationState();
}

class _AcceptNominationState extends State<AcceptNomination> {
  var acceptedStatus = false;
  var read = false;
  var noNomination = true;
  var notificationId = "";

  //get nomination made by user
  getUsersNominations() async {
    final data = await FirebaseFirestore.instance
        .collection('notifications')
        .where("userWhoNotify",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("data.electionId", isEqualTo: "ngZiVRVWoMETIGm0VPgj")
        .get();

    if (data.docs.isNotEmpty) {
      setState(() {
        acceptedStatus = data.docs[0]['data.accept'];
        read = data.docs[0]['read'];
        notificationId = data.docs[0]['id'];
        noNomination = false;
        print(data.docs[0]);
      });
    } else {
      setState(() {
        noNomination = true;
      }); /**/
    }
  }

//accept nomination and update
  acceptNom() async {
    print(notificationId);
    final data = await FirebaseFirestore.instance
        .collection('notifications')
        .doc(notificationId)
        .update({"data.accept": true, "read": true}).whenComplete(() {
      setState(() {
        acceptedStatus = true;
        read = true;
      });
    });
  }

//decline nomination and update
  declineNom() async {
    print(notificationId);
    final data = await FirebaseFirestore.instance
        .collection('notifications')
        .doc(notificationId)
        .update({"data.accept": false, "read": true}).whenComplete(() {
      setState(() {
        acceptedStatus = false;
        read = true;
      });
    });
  }

  //Dialog for password Validate
  Future acceptRequest(nomType) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: YesNoDialog(
          description: "Are you sure you sure?",
          closeDialog: () => Navigator.pop(context!),
          callFunction: () {
            nomType == "accept" ? acceptNom() : declineNom();
          },
        ));
      });

  @override
  void initState() {
    getUsersNominations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: noNomination ? false : true,
      child: Container(
        width: MyUtility(context).width * 0.8,
        decoration: BoxDecoration(
          color: Color.fromRGBO(174, 204, 236, 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Visibility(
                visible: !acceptedStatus && !read ? true : false,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'You have been nominated !',
                        style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFF174486),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'You have been nominated  to be Branch Council Member at ${widget.branch}. In order to be eligible for selection please click accept below. If you do not want to be eligible please choose decline below!',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF174486),
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElectionTabStyle(
                            changePage: () {
                              acceptRequest("Accept");
                            },
                            tabIndexNumber: 1,
                            description: "Accept",
                            customWidth: 150,
                            customColor1: Color.fromARGB(255, 211, 210, 210),
                            customColor2: Color.fromARGB(255, 0, 159, 158),
                            pageIndex: 1,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ElectionTabStyle(
                            changePage: () {
                              acceptRequest("Decline");
                            },
                            tabIndexNumber: 1,
                            description: "Decline",
                            customWidth: 150,
                            customColor1: Color.fromARGB(255, 211, 210, 210),
                            customColor2: Color.fromARGB(255, 0, 159, 158),
                            pageIndex: 1,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: acceptedStatus && read ? true : false,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Nomination Accepted',
                        style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFF174486),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'You have accepted nominations to be a Branch Council member at ${widget.branch}. You will be listed in the voting round',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF174486),
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: !acceptedStatus && read ? true : false,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Nomination declined',
                        style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFF174486),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'You have declined nominations to be a Branch Council member at ${widget.branch}. ',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF174486),
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
