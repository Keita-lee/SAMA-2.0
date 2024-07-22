import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/NominationHeader.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/brachVotingItems.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/branchVotingContainer.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/nominationForm.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/previewElection/sections/previewNominations.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui2/overView/overViewElection.dart';
import 'package:sama/components/myutility.dart';

import 'ui2/manageElection.dart';

class NominationSetup extends StatefulWidget {
  const NominationSetup({super.key});

  @override
  State<NominationSetup> createState() => _NominationSetupState();
}

class _NominationSetupState extends State<NominationSetup> {
  //var
  var pageIndex = 0;
  var electionId = "";
  // Text controllers
  final selectBranch = TextEditingController();

//changePage
  changePageIndex(value) {
    setState(() {
      if (value == 0) {
        electionId = "";
      }
      pageIndex = value;
    });
  }

  //get value of branch
  getBranchValue(value) {
    setState(() {
      selectBranch.text = value;
    });
  }

  //Open dialog for media
  Future openNominationForm(id) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: NominationFrom(
          id: id,
          closeDialog: () => Navigator.pop(context),
        ));
      });

  openElectionForm(electionIdS) {
    setState(() {
      pageIndex = 1;
      electionId = electionIdS;
    });
  }

//Get amount of days between dates
  getDaysAmount(date1, date2) {
    if (date1 != "" && date2 != "") {
      DateTime d1 = DateTime.parse(date1);
      DateTime d2 = DateTime.parse(date2);

      return "${d2.difference(d1).inDays} days";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      //Conditional Container
      /* Container(
        height: 180,
        width: MyUtility(context).width * 0.60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xFFD1D1D1),
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            'There are no elections in progress and none are pending.',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),*/
      ///////////////////////////////////
      Visibility(
        visible: pageIndex == 0 ? true : false,
        child: Text(
          'Branch Election - All Records',
          style: TextStyle(
              fontSize: 32,
              color: Color(0xFF3D3D3D),
              fontWeight: FontWeight.normal),
        ),
      ),
      SizedBox(
        height: 25,
      ),

      SizedBox(
        width: MyUtility(context).width - (MyUtility(context).width * 0.18),
        child: NominationHeader(
          controller: selectBranch,
          openElectionForm: () {
            openElectionForm("");
          },
          electionId: electionId,
          changePageIndex: changePageIndex,
          pageIndex: pageIndex,
        ),
      ),

      SizedBox(
        height: 25,
      ),

      Visibility(
          visible: pageIndex == 0 ? true : false,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Color(0xFFD1D1D1),
                )),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: MyUtility(context).width / 4,
                      child: Text(
                        "Branch",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFF6A6A6A),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MyUtility(context).width / 6,
                      child: Text(
                        "Nominations",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFF6A6A6A),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MyUtility(context).width / 6,
                      child: Text(
                        "Acceptance",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFF6A6A6A),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MyUtility(context).width / 6,
                      child: Text(
                        "Elections",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFF6A6A6A),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  color: Color(0xFF6A6A6A),
                  width: MyUtility(context).width -
                      (MyUtility(context).width * 0.22),
                  height: 1,
                ),
                SizedBox(
                  height: 15,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: selectBranch.text == ""
                        ? FirebaseFirestore.instance
                            .collection('elections')
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection('elections')
                            .where('selectBranch', isEqualTo: selectBranch.text)
                            .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: snapshot error');
                      }
                      if (!snapshot.hasData) {
                        return const Text('Loading...');
                      }

                      final List<DocumentSnapshot> documents =
                          snapshot.data!.docs;
                      if (documents.isEmpty) {
                        return Center(child: Text('No Elections yet'));
                      }

                      return Container(
                        color: Colors.transparent,
                        width: MyUtility(context).width -
                            (MyUtility(context).width * 0.18),
                        height: 550,
                        child: ListView.builder(
                            itemCount: documents.length,
                            itemBuilder: (BuildContext context, int index) {
                              final DocumentSnapshot document =
                                  documents[index];

                              return

                                  /*   
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BranchVotingContainer(
                          editElection: () {
                            //     openNominationForm(document['id']);
                            openElectionForm(document['id']);
                          },
                          branchTitle: document['selectBranch'],
                          count: document['count'],
                          isInProgress:
                              document['status'] != "Complete" ? false : true,
                          isChairpersonActive:
                              document['includeBranchChairPerson'],
                          votingItems: [
                            BranchVotingItems(
                                voteTitle: 'Round 1 Nominations',
                                startDate: document['nominateStartDate'],
                                endDate: document['nominateEndDate'],
                                voteDuration: getDaysAmount(
                                    document['nominateStartDate'],
                                    document['nominateEndDate'])),
                            BranchVotingItems(
                                voteTitle: 'Acceptance Round',
                                startDate: document['nominateAcceptStartDate'],
                                endDate: document['nominateAcceptEndDate'],
                                voteDuration: getDaysAmount(
                                    document['nominateAcceptStartDate'],
                                    document['nominateAcceptEndDate'])),
                            BranchVotingItems(
                              voteTitle: 'Elections',
                              startDate: document['electionDateStart'],
                              endDate: document['electionDateEnd'],
                              voteDuration: getDaysAmount(
                                  document['electionDateStart'],
                                  document['electionDateEnd']),
                            ),
                            Visibility(
                              visible: document['includeBranchChairPerson'],
                              child: BranchVotingItems(
                                voteTitle: 'Chairperson Round',
                                startDate: document['chairPersonStart'],
                                endDate: document['chairPersonEnd'],
                                voteDuration: getDaysAmount(
                                    document['electionDateStart'],
                                    document['electionDateEnd']),
                              ),
                            )
                          ],
                        ),
                      );
*/

                                  Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MyUtility(context).width,
                                      height: 120,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          SizedBox(
                                            width:
                                                MyUtility(context).width / 4.5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  document['status'] == "Draft"
                                                      ? "Draft"
                                                      : document['status'] ==
                                                              "Publish"
                                                          ? "In Progress"
                                                          : document['status'] ==
                                                                  "UnPublish"
                                                              ? "UnPublish"
                                                              : "Completed",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: document[
                                                                  'status'] ==
                                                              "UnPublish"
                                                          ? Colors.blue
                                                          : document['status'] ==
                                                                  "Publish"
                                                              ? Colors.green
                                                              : Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                                Text(
                                                  document['selectBranch'],
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0xFF3D3D3D),
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                              width:
                                                  MyUtility(context).width / 6,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    document[
                                                        'nominateStartDate'],
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color:
                                                            Color(0xFF3D3D3D),
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  Text(
                                                    document['nominateEndDate'],
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color:
                                                            Color(0xFF3D3D3D),
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  Text(
                                                    getDaysAmount(
                                                        document[
                                                            'nominateStartDate'],
                                                        document[
                                                            'nominateEndDate']),
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color:
                                                            Color(0xFF3D3D3D),
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              )),
                                          SizedBox(
                                              width:
                                                  MyUtility(context).width / 6,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    document[
                                                        'nominateAcceptStartDate'],
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color:
                                                            Color(0xFF3D3D3D),
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  Text(
                                                    document[
                                                        'nominateAcceptEndDate'],
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color:
                                                            Color(0xFF3D3D3D),
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  Text(
                                                    getDaysAmount(
                                                        document[
                                                            'nominateAcceptStartDate'],
                                                        document[
                                                            'nominateAcceptEndDate']),
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color:
                                                            Color(0xFF3D3D3D),
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              )),
                                          SizedBox(
                                              width:
                                                  MyUtility(context).width / 6,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    document[
                                                        'electionDateStart'],
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color:
                                                            Color(0xFF3D3D3D),
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  Text(
                                                    document['electionDateEnd'],
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color:
                                                            Color(0xFF3D3D3D),
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  Text(
                                                    getDaysAmount(
                                                        document[
                                                            'electionDateStart'],
                                                        document[
                                                            'electionDateEnd']),
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color:
                                                            Color(0xFF3D3D3D),
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              )),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 25, 0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        openElectionForm(
                                                            document['id']);
                                                      },
                                                      child: Text(
                                                        "Manage",
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        /*  openElectionForm(
                                                            document['id']);*/
                                                        setState(() {
                                                          electionId =
                                                              document['id'];
                                                        });
                                                        changePageIndex(2);
                                                      },
                                                      child: Text(
                                                        "View",
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Color(0xFF6A6A6A),
                                      width: MyUtility(context).width -
                                          (MyUtility(context).width * 0.22),
                                      height: 1,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      );
                    }),
              ],
            ),
          )),

      Visibility(
          visible: pageIndex == 3 ? true : false,
          child: StreamBuilder<QuerySnapshot>(
              stream: selectBranch.text == ""
                  ? FirebaseFirestore.instance
                      .collection('elections')
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection('elections')
                      .where('selectBranch', isEqualTo: selectBranch.text)
                      .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: snapshot error');
                }
                if (!snapshot.hasData) {
                  return const Text('Loading...');
                }

                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                if (documents.isEmpty) {
                  return Center(child: Text('No Elections yet'));
                }

                return Container(
                    color: Colors.transparent,
                    width: MyUtility(context).width -
                        (MyUtility(context).width * 0.18),
                    height: 550,
                    child: ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          final DocumentSnapshot document = documents[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BranchVotingContainer(
                              editElection: () {
                                //     openNominationForm(document['id']);
                                openElectionForm(document['id']);
                              },
                              branchTitle: document['selectBranch'],
                              count: document['count'],
                              isInProgress: document['status'] != "Complete"
                                  ? false
                                  : true,
                              isChairpersonActive:
                                  document['includeBranchChairPerson'],
                              votingItems: [
                                BranchVotingItems(
                                    voteTitle: 'Round 1 Nominations',
                                    startDate: document['nominateStartDate'],
                                    endDate: document['nominateEndDate'],
                                    voteDuration: getDaysAmount(
                                        document['nominateStartDate'],
                                        document['nominateEndDate'])),
                                BranchVotingItems(
                                    voteTitle: 'Acceptance Round',
                                    startDate:
                                        document['nominateAcceptStartDate'],
                                    endDate: document['nominateAcceptEndDate'],
                                    voteDuration: getDaysAmount(
                                        document['nominateAcceptStartDate'],
                                        document['nominateAcceptEndDate'])),
                                BranchVotingItems(
                                  voteTitle: 'Elections',
                                  startDate: document['electionDateStart'],
                                  endDate: document['electionDateEnd'],
                                  voteDuration: getDaysAmount(
                                      document['electionDateStart'],
                                      document['electionDateEnd']),
                                ),
                                Visibility(
                                  visible: document['includeBranchChairPerson'],
                                  child: BranchVotingItems(
                                    voteTitle: 'Chairperson Round',
                                    startDate: document['chairPersonStart'],
                                    endDate: document['chairPersonEnd'],
                                    voteDuration: getDaysAmount(
                                        document['electionDateStart'],
                                        document['electionDateEnd']),
                                  ),
                                )
                              ],
                            ),
                          );
                        }));
              })),

      Visibility(
          visible: pageIndex == 1 ? true : false,
          child: ManageElection(
            id: electionId,
            changePageIndex: changePageIndex,
          )),

      Visibility(
          visible: pageIndex == 2 ? true : false,
          child: OverViewElection(
            id: electionId,
            changePageIndex: changePageIndex,
          ))
    ]));
  }
}
