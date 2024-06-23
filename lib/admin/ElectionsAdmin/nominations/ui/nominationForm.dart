import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/CheckBoxExample.dart';
import 'package:sama/components/dateSelecter.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/components/yesNoDialog.dart';

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
  //var
  bool includeBranchChairPerson = false;
  String status = "InComplete";
  List count = [];
//save add data to firebase
  saveData() async {
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
      "status": status,
      "title": title.text,
      "position": position.text,
      "criteria": criteria.text,
      "count": count,
      "id": widget.id,
    };

    if (widget.id == "") {
      var myNewDoc = await FirebaseFirestore.instance
          .collection("elections")
          .add(electionData);

      FirebaseFirestore.instance
          .collection("elections")
          .doc(myNewDoc.id)
          .update({
        "id": myNewDoc.id,
      }).whenComplete(() => widget.closeDialog());
    } else {
      FirebaseFirestore.instance
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
        count.addAll(data.get('count'));

        title.text = data.get('title');
        position.text = data.get('position');
        criteria.text = data.get('criteria');
      });
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

//Get amount of days between dates
  getDaysAmount(date1, date2) {
    if (date1 != "" && date2 != "") {
      DateTime d1 = DateTime.parse(date1);
      DateTime d2 = DateTime.parse(date2);

      return "${d2.difference(d1).inDays} days";
    }
    return "";
  }

//call setstate refresh data
  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    //get data when Id availble
    if (widget.id != "") {
      getElectionData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          scale: 0.8,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Branch Nominations and Elections - New Event',
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
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileDropDownField(
                    customSize: 300,
                    description: 'Please Select a Branch',
                    items: [
                      'Border Coastal (BCB)',
                      'Cape Western (CWB)',
                      'Eastern Highveld (ETB)',
                      'Eastern Province(EPB)',
                      'Free State (OFS)',
                      'Gauteng (STB)',
                      'Gauteng North (NTB)',
                      'GoldFields (GFB)',
                      'GoldFields (GFB)',
                      'Griqualand West (GWB)',
                      'KZN Coastal (NCB)',
                      'KZN Midlands (NIB)',
                      'KZN Northen (NNB)',
                      'Limpopo (SPB)',
                      'Lowveld (LVB)',
                      'North West (WTB)',
                      'Outeniqua (OQB)',
                      'Transkei (TRB)',
                      'Tygerberg Boland (TBB)',
                      'Vaal River (VR)',
                    ],
                    textfieldController: selectBranch,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  CheckBoxExample(
                      name: 'Include Branch Chair Person',
                      value: includeBranchChairPerson),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.grey,
              height: 1,
              width: MyUtility(context).width / 1.8,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                ProfileTextField(
                    customSize: MyUtility(context).width * 0.27,
                    description: "Title",
                    textfieldController: title,
                    textFieldType: "stringType"),
                SizedBox(
                  width: 15,
                ),
                ProfileTextField(
                    customSize: MyUtility(context).width * 0.27,
                    description: "Position",
                    textfieldController: position,
                    textFieldType: "stringType")
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.grey,
              height: 1,
              width: MyUtility(context).width / 1.8,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                ProfileTextField(
                    customSize: MyUtility(context).width * 0.55,
                    description: "Criteria",
                    textfieldController: criteria,
                    textFieldType: "stringType"),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.grey,
              height: 1,
              width: MyUtility(context).width / 1.8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 230,
                    child: Text(
                      "Nomination Dates (Round 1):",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF6A6A6A),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MyUtility(context).width / 11,
                  ),
                  DateSelecter(
                    customSize: MyUtility(context).width / 7,
                    description: 'Start Date',
                    controller: nominateStartDate,
                    refresh: refresh,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  DateSelecter(
                      customSize: MyUtility(context).width / 7,
                      description: 'End Date',
                      controller: nominateEndDate,
                      refresh: refresh),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "${getDaysAmount(nominateStartDate.text, nominateEndDate.text)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF6A6A6A),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              color: Colors.grey,
              height: 1,
              width: MyUtility(context).width / 1.8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 240,
                    child: Text(
                      "Nomination Acceptance Dates:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF6A6A6A),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MyUtility(context).width / 11.7,
                  ),
                  DateSelecter(
                      customSize: MyUtility(context).width / 7,
                      description: 'Start Date',
                      controller: nominateAcceptStartDate,
                      refresh: refresh),
                  SizedBox(
                    width: 15,
                  ),
                  DateSelecter(
                      customSize: MyUtility(context).width / 7,
                      description: 'End Date',
                      controller: nominateAcceptEndDate,
                      refresh: refresh),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "${getDaysAmount(nominateAcceptStartDate.text, nominateAcceptEndDate.text)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF6A6A6A),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              color: Colors.grey,
              height: 1,
              width: MyUtility(context).width / 1.8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 215,
                    child: Text(
                      "Election Dates (Round 2):",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF6A6A6A),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MyUtility(context).width / 9.8,
                  ),
                  DateSelecter(
                      customSize: MyUtility(context).width / 7,
                      description: 'Start Date',
                      controller: electionDateStart,
                      refresh: refresh),
                  SizedBox(
                    width: 15,
                  ),
                  DateSelecter(
                      customSize: MyUtility(context).width / 7,
                      description: 'End Date',
                      controller: electionDateEnd,
                      refresh: refresh),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "${getDaysAmount(electionDateStart.text, electionDateEnd.text)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF6A6A6A),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              color: Colors.grey,
              height: 1,
              width: MyUtility(context).width / 1.8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 230,
                    child: Text(
                      "Branch ChairPerson Voting:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF6A6A6A),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MyUtility(context).width / 11,
                  ),
                  DateSelecter(
                      customSize: MyUtility(context).width / 7,
                      description: 'Start Date',
                      controller: chairPersonStart,
                      refresh: refresh),
                  SizedBox(
                    width: 15,
                  ),
                  DateSelecter(
                      customSize: MyUtility(context).width / 7,
                      description: 'End Date',
                      controller: chairPersonEnd,
                      refresh: refresh),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "${getDaysAmount(chairPersonStart.text, chairPersonEnd.text)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF6A6A6A),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey,
              height: 1,
              width: MyUtility(context).width / 1.8,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              color: Colors.grey,
              height: 1,
              width: MyUtility(context).width / 1.8,
            ),
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
                        saveData();
                      }),
                  SizedBox(
                    width: 8,
                  ),
                  Visibility(
                    visible: widget.id != "" ? true : false,
                    child: StyleButton(
                        description: "Results",
                        height: 55,
                        width: 150,
                        onTap: () {}),
                  ),
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
            ),
          ]),
        )));
  }
}
