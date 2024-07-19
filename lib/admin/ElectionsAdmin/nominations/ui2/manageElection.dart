import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../components/electionTabStyle.dart';
import '../../../../components/myutility.dart';
import '../../../../components/service/commonService.dart';
import '../../../../components/styleButton.dart';
import '../../../../components/yesNoDialog.dart';
import 'overView/sections/acceptanceRoundOverView.dart';
import 'overView/sections/chairPersonOverview.dart';
import 'overView/sections/electionOverView.dart';
import 'overView/sections/round1OverView.dart';
import 'overView/sections/round2OverView.dart';
import 'setup/setupAcceptance.dart';
import 'setup/setupChairPersonElection.dart';
import 'setup/setupElection2.dart';
import 'setup/setupRound1.dart';
import 'setup/setupRound2.dart';

class ManageElection extends StatefulWidget {
  String id;
  Function(int) changePageIndex;

  ManageElection({super.key, required this.id, required this.changePageIndex});

  @override
  State<ManageElection> createState() => _ManageElectionState();
}

class _ManageElectionState extends State<ManageElection> {
  // Text controllers
  final selectBranch = TextEditingController();
  final nominateStartDate = TextEditingController();
  final nominateEndDate = TextEditingController();
  final nominateAcceptStartDate = TextEditingController();
  final nominateAcceptEndDate = TextEditingController();
  final electionDateStart = TextEditingController();
  final electionDateEnd = TextEditingController();
  final chairPersonStart = TextEditingController();
  final chairPersonEnd = TextEditingController();

  final title = TextEditingController();
  final position = TextEditingController();
  final criteria = TextEditingController();
  final count = TextEditingController();
  //var
  bool includeBranchChairPerson = false;
  bool hdiCompliant = false;
  List electionVotes = [];
  List chairMemberVoteList = [];
  String status = "";
  int nomintionCount = 0;
  int pageIndex = 0;
  int electionIndex = 0;

  updateStatus() {
    setState(() {
      if (status == "") {
        setState(() {
          status = "Draft";
        });
      } else if (status == "Draft") {
        setState(() {
          status = "Publish";
        });
      } else if (status == "Publish") {
        setState(() {
          status = "Complete";
        });
      }
    });
  }

//save add data to firebase
  saveData(statusType) async {
    var electionData = {
      "selectBranch": selectBranch.text,
      "nominateStartDate": nominateStartDate.text,
      "nominateEndDate": nominateEndDate.text,
      "nominateAcceptStartDate": nominateAcceptStartDate.text,
      "nominateAcceptEndDate": nominateAcceptEndDate.text,
      "electionDateStart": electionDateStart.text,
      "electionDateEnd": electionDateEnd.text,
      "chairPersonStart": chairPersonStart.text,
      "chairPersonEnd": chairPersonEnd.text,
      "includeBranchChairPerson": includeBranchChairPerson,
      "status": statusType,
      "title": title.text,
      "position": position.text,
      "criteria": criteria.text,
      "count": count.text,
      "hdiComply": hdiCompliant,
      "electionVotes": electionVotes,
      "chairmanVotes": chairMemberVoteList,
      "id": widget.id,
    };

    if (widget.id == "") {
      var myNewDoc = await FirebaseFirestore.instance
          .collection("elections")
          .add(electionData);

      await FirebaseFirestore.instance
          .collection("elections")
          .doc(myNewDoc.id)
          .update({
        "id": myNewDoc.id,
      }).whenComplete(() => widget.changePageIndex(0));
    } else {
      await FirebaseFirestore.instance
          .collection("elections")
          .doc(widget.id)
          .update(electionData)
          .whenComplete(() => widget.changePageIndex(0));
    }
  }

  getElectionData() async {
    final data = await FirebaseFirestore.instance
        .collection('elections')
        .doc(widget.id)
        .get();

    if (data.exists) {
      setState(() {
        selectBranch.text = data.get('selectBranch');
        nominateStartDate.text = data.get('nominateStartDate');
        nominateEndDate.text = data.get('nominateEndDate');
        nominateAcceptStartDate.text = data.get('nominateAcceptStartDate');
        nominateAcceptEndDate.text = data.get('nominateAcceptEndDate');
        electionDateStart.text = data.get('electionDateStart');
        electionDateEnd.text = data.get('electionDateEnd');
        chairPersonStart.text = data.get('chairPersonStart');
        chairPersonEnd.text = data.get('chairPersonEnd');
        includeBranchChairPerson = data.get('includeBranchChairPerson');
        status = data.get('status');
        count.text = data.get('count');
        electionVotes.addAll(data.get('electionVotes'));
        chairMemberVoteList.addAll(data.get('chairmanVotes'));

        title.text = data.get('title');
        position.text = data.get('position');
        criteria.text = data.get('criteria');
        hdiCompliant = data.get('hdiComply');
      });
      updateStatus();
    }
  }

  //Remove member from db
  removeElection() {
    FirebaseFirestore.instance
        .collection('elections')
        .doc(widget.id)
        .delete()
        .whenComplete(() => widget.changePageIndex(0));
  }

  //Dialog to Remove Item
  Future removeElectionPopup() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: YesNoDialog(
          description: "Are you sure you want to remove this item",
          closeDialog: () => Navigator.pop(context!),
          callFunction: removeElection,
        ));
      });

//update chairperson/ hdi value
  updateElectionCriteria(type) {
    setState(() {
      if (type == "chairPerson") {
        includeBranchChairPerson = !includeBranchChairPerson;
      } else {
        hdiCompliant = !hdiCompliant;
      }
    });
  }

  updateHdi() {
    setState(() {
      hdiCompliant = !hdiCompliant;
    });
  }

  updateChairperson() {
    setState(() {
      includeBranchChairPerson = !includeBranchChairPerson;
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

  updateNominationStartDate(date) {
    setState(() {
      nominateStartDate.text = updateDateValues(date, 0);
      nominateEndDate.text = updateDateValues(nominateStartDate.text, 10);

      nominateAcceptStartDate.text = updateDateValues(nominateEndDate.text, 1);
      nominateAcceptEndDate.text =
          updateDateValues(nominateAcceptStartDate.text, 4);
      electionDateStart.text = updateDateValues(nominateAcceptEndDate.text, 1);
      electionDateEnd.text = updateDateValues(electionDateStart.text, 10);
      chairPersonStart.text = updateDateValues(electionDateEnd.text, 1);
      chairPersonEnd.text = updateDateValues(chairPersonStart.text, 10);
    });
  }

  updateNominationEndDate(date) {
    setState(() {
      nominateStartDate.text = updateDateValues(date, -10);
      nominateEndDate.text = updateDateValues(date, 0);

      nominateAcceptStartDate.text = updateDateValues(nominateEndDate.text, 1);
      nominateAcceptEndDate.text =
          updateDateValues(nominateAcceptStartDate.text, 4);
      electionDateStart.text = updateDateValues(nominateAcceptEndDate.text, 1);
      electionDateEnd.text = updateDateValues(electionDateStart.text, 10);
      chairPersonStart.text = updateDateValues(electionDateEnd.text, 1);
      chairPersonEnd.text = updateDateValues(chairPersonStart.text, 10);
    });
  }

  updateRound2StartDate(date) {
    setState(() {
      electionDateStart.text = updateDateValues(date, 0);
      electionDateEnd.text = updateDateValues(electionDateStart.text, 10);
      chairPersonStart.text = updateDateValues(electionDateEnd.text, 1);
      chairPersonEnd.text = updateDateValues(chairPersonStart.text, 10);
    });
  }

  updateRound2EndDate(date) {
    setState(() {
      electionDateStart.text = updateDateValues(date, -10);
      electionDateEnd.text = updateDateValues(date, 0);
      chairPersonStart.text = updateDateValues(electionDateEnd.text, 1);
      chairPersonEnd.text = updateDateValues(chairPersonStart.text, 10);
    });
  }

  updateChairPersonDate(date) {
    setState(() {
      chairPersonStart.text = updateDateValues(date, 1);
      chairPersonEnd.text = updateDateValues(chairPersonStart.text, 10);
    });
  }

//update dates
  updateDateValues(date, daysValue) {
    DateTime now = DateTime.parse(date);

    DateTime dt = DateTime(now.year, now.month, now.day, 0, 0, 0);
    DateTime dt1;
    if (daysValue < 0) {
      dt1 = dt.subtract(Duration(days: 10));
    } else {
      dt1 = dt.add(Duration(days: daysValue));
    }

    return DateFormat('yyyy-MM-dd').format(dt1);
  }

  @override
  void initState() {
    print(widget.id);
    //get data when Id availble
    if (widget.id != "") {
      getElectionData();
    } else {
      updateNominationStartDate(CommonService().getTodaysDateText());
    }

    super.initState();
    updateStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Branch Voting - Manage',
          style: TextStyle(
            fontSize: 36,
            color: Color.fromARGB(255, 24, 69, 126),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: MyUtility(context).width / 2.3,
            ),
            SizedBox(
              width: 10,
            ),
            StyleButton(
                description: "Exit",
                height: 55,
                width: 175,
                onTap: () {
                  widget.changePageIndex(0);
                }),
            SizedBox(
              width: 10,
            ),
            StyleButton(
                description: "${status == "Draft" ? "Publish" : status}",
                height: 55,
                width: 125,
                onTap: () {
                  updateStatus();
                }),
            SizedBox(
              width: 10,
            ),
            StyleButton(
                description: "OverView",
                height: 55,
                width: 125,
                onTap: () {
                  widget.changePageIndex(2);
                }),
            SizedBox(
              width: 10,
            ),
            StyleButton(
                description: "Update",
                height: 55,
                width: 125,
                onTap: () {
                  saveData(status);
                }),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Visibility(
          visible: widget.id == "" ? false : true,
          child: Row(
            children: [
              /* ElectionTabStyle(
                changePage: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                tabIndexNumber: 0,
                description: "Setup",
                customWidth: 150,
                customColor1: Color.fromARGB(255, 211, 210, 210),
                customColor2: Color(0xFF174486),
                pageIndex: pageIndex,
              ),
                    ElectionTabStyle(
                changePage: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                tabIndexNumber: 1,
                description: "Overview",
                customWidth: 150,
                customColor1: Color.fromARGB(255, 211, 210, 210),
                customColor2: Color(0xFF174486),
                pageIndex: pageIndex,
              ),
              ElectionTabStyle(
                changePage: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                tabIndexNumber: 2,
                description: "Round 1",
                customWidth: 150,
                customColor1: Color.fromARGB(255, 211, 210, 210),
                customColor2: Color(0xFF174486),
                pageIndex: pageIndex,
              ),
              ElectionTabStyle(
                changePage: () {
                  setState(() {
                    pageIndex = 3;
                  });
                },
                tabIndexNumber: 3,
                description: "Acceptance Round",
                customWidth: 180,
                customColor1: Color.fromARGB(255, 211, 210, 210),
                customColor2: Color(0xFF174486),
                pageIndex: pageIndex,
              ),
              ElectionTabStyle(
                changePage: () {
                  setState(() {
                    pageIndex = 4;
                  });
                },
                tabIndexNumber: 4,
                description: "Round 2",
                customWidth: 150,
                customColor1: Color.fromARGB(255, 211, 210, 210),
                customColor2: Color(0xFF174486),
                pageIndex: pageIndex,
              ),
              ElectionTabStyle(
                changePage: () {
                  setState(() {
                    pageIndex = 5;
                  });
                },
                tabIndexNumber: 5,
                description: "Chair Person",
                customWidth: 150,
                customColor1: Color.fromARGB(255, 211, 210, 210),
                customColor2: Color(0xFF174486),
                pageIndex: pageIndex,
              ),
            */
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Container(
            width: MyUtility(context).width - (MyUtility(context).width * 0.18),
            height: 750,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color(0xFFD1D1D1),
                width: 1.5,
              ),
            ),
            child: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                /* */ Row(
                  children: [
                    Container(
                      height: 55,
                      width: 160,
                      decoration: BoxDecoration(
                        color: status == "Draft"
                            ? Colors.grey
                            : Color.fromRGBO(0, 159, 12, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      child: Center(
                        child: Text(
                          status,
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.1,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Visibility(
                  visible: pageIndex == 0 ? true : false,
                  child: Column(children: [
                    SetupElection2(
                      selectBranch: selectBranch,
                      count: count,
                      hdiCompliant: hdiCompliant,
                      updateHdi: updateHdi,
                      status: status,
                      updateElectionCriteria: updateElectionCriteria,
                      saveElection: saveData,
                    ),
                    SetupRound1(
                        nominationStartDate: nominateStartDate.text,
                        nominationEndDate: nominateEndDate.text,
                        updateStartDate: updateNominationStartDate,
                        updateEndDate: updateNominationEndDate,
                        electionId: widget.id),
                    SetupAcceptance(
                      nominateAcceptStartDate: nominateAcceptStartDate.text,
                      nominateAcceptEndDate: nominateAcceptEndDate.text,
                    ),
                    SetupRound2(
                      electionStartDate: electionDateStart.text,
                      electionEndDate: electionDateEnd.text,
                      nominationEndDate: nominateEndDate.text,
                      updateStartDate: updateRound2StartDate,
                      updateEndDate: updateRound2EndDate,
                    ),
                    SetupChairPersonElection(
                        chairPersonStartDate: chairPersonStart.text,
                        chairPersonEndDate: chairPersonEnd.text,
                        updateChairPersonDate: updateChairPersonDate,
                        includeBranchChairPerson: includeBranchChairPerson,
                        updateChairperson: () {
                          updateChairperson();
                        }),
                  ]),
                ),
                Visibility(
                  visible: pageIndex == 1 ? true : false,
                  child: ElectionOverView(
                    nominateStartDate: nominateStartDate.text,
                    nominateEndDate: nominateEndDate.text,
                    nominateAcceptEndDate: nominateAcceptEndDate.text,
                    nominateAcceptStartDate: nominateAcceptStartDate.text,
                    electionDateStart: electionDateStart.text,
                    electionDateEnd: electionDateEnd.text,
                    chairPersonStart: chairPersonStart.text,
                    chairPersonEnd: chairPersonEnd.text,
                    electionId: widget.id,
                    electionVotes: electionVotes,
                    chairMemberVoteList: chairMemberVoteList,
                  ),
                ),
                Visibility(
                  visible: pageIndex == 2 ? true : false,
                  child: Round1OverView(
                    startDate: nominateStartDate.text,
                    endDate: nominateEndDate.text,
                    electionId: widget.id,
                  ),
                ),
                Visibility(
                  visible: pageIndex == 3 ? true : false,
                  child: Acceptanceroundoverview(
                    electionId: widget.id,
                    nominateAcceptEndDate: nominateAcceptEndDate.text,
                    nominateAcceptStartDate: nominateAcceptStartDate.text,
                  ),
                ),
                Visibility(
                  visible: pageIndex == 4 ? true : false,
                  child: Round2OverView(
                    electionDateStart: electionDateStart.text,
                    electionDateEnd: electionDateEnd.text,
                    electionId: widget.id,
                    electionVotes: electionVotes,
                    hdiCompliant: hdiCompliant,
                  ),
                ),
                Visibility(
                  visible: pageIndex == 5 ? true : false,
                  child: ChairPersonOverview(
                    chairMemberEndDate: chairPersonEnd.text,
                    chairMemberStartDate: chairPersonStart.text,
                    chairMemberVoteList: chairMemberVoteList,
                    electionId: widget.id,
                  ),
                ),
              ]),
            )),
      ],
    );
  }
}
