import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/electionResults.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/electionProcessUi/NomintaionAcceptanceRound.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/electionProcessUi/Round1NominationsFinished.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/electionProcessUi/Round2Election.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/previewElection/sections/electionFunctions.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/previewElection/sections/previewAcceptanceRound.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/previewElection/sections/previewChairPersonRound.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/previewElection/sections/previewElections.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/previewElection/sections/previewNominations.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/tabStyle.dart';
import 'package:sama/components/CheckBoxExample.dart';
import 'package:sama/components/dateSelecter.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/components/service/commonService.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/components/yesNoDialog.dart';

import '../ui2/setup/setupAcceptance.dart';
import '../ui2/setup/setupChairPersonElection.dart';
import '../ui2/setup/setupElection2.dart';
import '../ui2/setup/setupRound1.dart';
import '../ui2/setup/setupRound2.dart';

class NominationFrom extends StatefulWidget {
  Function closeDialog;
  String id;
  NominationFrom({super.key, required this.closeDialog, required this.id});

  @override
  State<NominationFrom> createState() => _NominationFromState();
}

class _NominationFromState extends State<NominationFrom> {
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
        status = "Publish";
      } else if (status == "Publish") {
        status = "UnPublish";
      } else if (status == "Open Nominations") {
        status = "Close";
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
      }).whenComplete(() => widget.closeDialog());
    } else {
      await FirebaseFirestore.instance
          .collection("elections")
          .doc(widget.id)
          .update(electionData)
          .whenComplete(() => widget.closeDialog());
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
        .whenComplete(() => widget.closeDialog!());
  }

  //Dialog to Remove Item
  Future removeMediaPopup() => showDialog(
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
      nominateStartDate.text = updateDateValues(nominateEndDate.text, -15);
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
      electionDateStart.text = updateDateValues(date, 1);
      electionDateEnd.text = updateDateValues(electionDateStart.text, 10);
      chairPersonStart.text = updateDateValues(electionDateEnd.text, 1);
      chairPersonEnd.text = updateDateValues(chairPersonStart.text, 10);
    });
  }

  updateRound2EndDate(date) {
    setState(() {
      electionDateEnd.text = updateDateValues(date, 10);
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

    DateTime dt1 = dt.add(Duration(days: daysValue));
    return DateFormat('yyyy-MM-dd').format(dt1);
  }

  @override
  void initState() {
    //get data when Id availble
    if (widget.id != "") {
      getElectionData();
    } else {
      updateNominationStartDate(CommonService().getTodaysDateText());
    }

    super.initState();
    updateStatus();
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

  @override
  Widget build(BuildContext context) {
    return Container(
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
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Branch Nominations and Elections - ${selectBranch.text}',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF174486),
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      widget.closeDialog();
                    },
                    child: Icon(Icons.cancel),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Tabstyle(
                  pageIndex: pageIndex,
                  changePage: () {
                    setState(() {
                      pageIndex = 0;
                    });
                  },
                  tabIndexNumber: 0,
                  description: "Setup Election",
                  customWidth: 150,
                  customColor1: Color.fromARGB(255, 8, 55, 145),
                  customColor2: Color.fromARGB(255, 83, 115, 175),
                ),
                Visibility(
                  visible: widget.id == "" ? false : true,
                  child: Tabstyle(
                    pageIndex: pageIndex,
                    changePage: () {
                      setState(() {
                        pageIndex = 1;
                      });
                    },
                    tabIndexNumber: 1,
                    description: "Results",
                    customWidth: 150,
                    customColor1: Color.fromARGB(255, 8, 55, 145),
                    customColor2: Color.fromARGB(255, 83, 115, 175),
                  ),
                )
              ],
            ),
            /*  Visibility(
              visible: pageIndex == 0 ? true : false,
              child: Column(
                children: [
                  SetupElection2(
                      selectBranch: selectBranch,
                      count: count,
                      hdiCompliant: hdiCompliant,
                      updateHdi: updateHdi),
                  SetupRound1(
                    nominationStartDate: nominateStartDate.text,
                    nominationEndDate: nominateEndDate.text,
                    updateStartDate: updateNominationStartDate,
                    updateEndDate: updateNominationEndDate,
                  ),
                  SetupAcceptance(
                    nominateAcceptStartDate: nominateAcceptStartDate.text,
                    nominateAcceptEndDate: nominateAcceptEndDate.text,
                  ),
                  SetupRound2(
                    electionStartDate: electionDateStart.text,
                    electionEndDate: electionDateEnd.text,
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
                ],
              ),
            ),*/
            Visibility(
              visible: pageIndex == 1 ? true : false,
              child: ElectionResults(
                  branch: selectBranch.text,
                  nominationStartDate: nominateStartDate.text,
                  nominationEndDate: nominateEndDate.text,
                  nominateAcceptStartDate: nominateAcceptStartDate.text,
                  nominateAcceptEndDate: nominateAcceptEndDate.text,
                  electionDateStart: electionDateStart.text,
                  electionDateEnd: electionDateEnd.text,
                  electionId: widget.id,
                  electionVotes: electionVotes,
                  hdiCompliant: hdiCompliant,
                  chairmanStartDate: chairPersonStart.text,
                  chairmanEndDate: chairPersonEnd.text,
                  chairMemberVoteList: chairMemberVoteList),
            ),
          ]),
        ));
  }
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    
    
    Container(
        width: MyUtility(context).width / 1.6,
        height: MyUtility(context).height / 1.2,
        decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color.fromARGB(255, 8, 55, 145),
                width: 2.0,
              ),
            ),
            borderRadius: BorderRadius.circular(15),
            color: Color.fromARGB(255, 255, 255, 255)),
        child: SingleChildScrollView(
            child: Transform.scale(
          scale: 0.9,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Branch Nominations and Elections - ${selectBranch.text}',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF174486),
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      widget.closeDialog();
                    },
                    child: Icon(Icons.cancel),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Tabstyle(
                  pageIndex: pageIndex,
                  changePage: () {
                    setState(() {
                      pageIndex = 0;
                    });
                  },
                  tabIndexNumber: 0,
                  description: "Setup Election",
                  customWidth: 150,
                  customColor1: Color.fromARGB(255, 8, 55, 145),
                  customColor2: Color.fromARGB(255, 83, 115, 175),
                ),
                Visibility(
                  visible: widget.id == "" ? false : true,
                  child: Tabstyle(
                    pageIndex: pageIndex,
                    changePage: () {
                      setState(() {
                        pageIndex = 1;
                      });
                    },
                    tabIndexNumber: 1,
                    description: "Results",
                    customWidth: 150,
                    customColor1: Color.fromARGB(255, 8, 55, 145),
                    customColor2: Color.fromARGB(255, 83, 115, 175),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),







         /*   Visibility(
              visible: pageIndex == 0 ? true : false,
              child: Row(
                children: [
                  Tabstyle(
                    pageIndex: electionIndex,
                    changePage: () {
                      setState(() {
                        electionIndex = 0;
                      });
                    },
                    tabIndexNumber: 0,
                    description: "Election Details",
                    customWidth: 150,
                    customColor1: Color.fromARGB(255, 7, 124, 179),
                    customColor2: Color.fromARGB(255, 8, 55, 145),
                  ),
                  Tabstyle(
                    pageIndex: electionIndex,
                    changePage: () {
                      setState(() {
                        electionIndex = 1;
                      });
                    },
                    tabIndexNumber: 1,
                    description: "Round 1",
                    customWidth: 150,
                    customColor1: Color.fromARGB(255, 7, 124, 179),
                    customColor2: Color.fromARGB(255, 8, 55, 145),
                  ),
                  Tabstyle(
                    pageIndex: electionIndex,
                    changePage: () {
                      setState(() {
                        electionIndex = 2;
                      });
                    },
                    tabIndexNumber: 2,
                    description: "Acceptance Round",
                    customWidth: 150,
                    customColor1: Color.fromARGB(255, 7, 124, 179),
                    customColor2: Color.fromARGB(255, 8, 55, 145),
                  ),
                  Tabstyle(
                    pageIndex: electionIndex,
                    changePage: () {
                      setState(() {
                        electionIndex = 3;
                      });
                    },
                    tabIndexNumber: 3,
                    description: "Round2",
                    customWidth: 150,
                    customColor1: Color.fromARGB(255, 7, 124, 179),
                    customColor2: Color.fromARGB(255, 8, 55, 145),
                  ),
                  Tabstyle(
                    pageIndex: electionIndex,
                    changePage: () {
                      setState(() {
                        electionIndex = 4;
                      });
                    },
                    tabIndexNumber: 4,
                    description: "Chair Person",
                    customWidth: 150,
                    customColor1: Color.fromARGB(255, 7, 124, 179),
                    customColor2: Color.fromARGB(255, 8, 55, 145),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Visibility(
              visible: pageIndex == 1 ? true : false,
              child: ElectionResults(
                  branch: selectBranch.text,
                  nominationStartDate: nominateStartDate.text,
                  nominationEndDate: nominateEndDate.text,
                  nominateAcceptStartDate: nominateAcceptStartDate.text,
                  nominateAcceptEndDate: nominateAcceptEndDate.text,
                  electionDateStart: electionDateStart.text,
                  electionDateEnd: electionDateEnd.text,
                  electionId: widget.id,
                  electionVotes: electionVotes,
                  hdiCompliant: hdiCompliant,
                  chairmanStartDate: chairPersonStart.text,
                  chairmanEndDate: chairPersonEnd.text,
                  chairMemberVoteList: chairMemberVoteList),
            ),
            Visibility(
              visible: pageIndex == 0 ? true : false,
              child: Column(
                children: [
                  Visibility(
                    visible: electionIndex == 0 ? true : false,
                    child: ElectionFunctions(
                      includeBranchChairPerson: includeBranchChairPerson,
                      hdiCompliant: hdiCompliant,
                      status: status,
                      selectBranch: selectBranch,
                      title: title,
                      position: position,
                      criteria: criteria,
                      count: count,
                      updateElectionCriteria: updateElectionCriteria,
                      saveElection: saveData,
                    ),
                  ),
                  Visibility(
                    visible: electionIndex == 1 ? true : false,
                    child: PreviewNominations(
                      nominationStartDate: nominateStartDate.text,
                      nominationEndDate: nominateEndDate.text,
                      updateStartDate: updateNominationStartDate,
                      updateEndDate: updateNominationEndDate,
                    ),
                  ),
                  Visibility(
                    visible: electionIndex == 2 ? true : false,
                    child: PreviewAcceptanceRound(
                      nominateAcceptStartDate: nominateAcceptStartDate.text,
                      nominateAcceptEndDate: nominateAcceptEndDate.text,
                    ),
                  ),
                  Visibility(
                    visible: electionIndex == 3 ? true : false,
                    child: PreviewElections(
                      electionStartDate: electionDateStart.text,
                      electionEndDate: electionDateEnd.text,
                      updateStartDate: updateRound2StartDate,
                      updateEndDate: updateRound2EndDate,
                    ),
                  ),
                  Visibility(
                    visible: electionIndex == 4 ? true : false,
                    child: PreviewChairPersonRound(
                      chairPersonStartDate: chairPersonStart.text,
                      chairPersonEndDate: chairPersonEnd.text,
                      updateChairPersonDate: updateChairPersonDate,
                    ),
                  ),
                ],
              ),
            ),
         
         */
         
         
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  StyleButton(
                      description: "Save Event",
                      height: 55,
                      width: 150,
                      onTap: () {
                        saveData("");
                      }),
                  SizedBox(
                    width: 8,
                  ),
                  Visibility(
                    visible: widget.id != "" ? true : false,
                    child: StyleButton(
                        description: "Remove",
                        height: 55,
                        width: 150,
                        onTap: () {
                          removeElection();
                        }),
                  ),
                ],
              ),
            ), /* */
          ]),
        )));
  }
}
*/