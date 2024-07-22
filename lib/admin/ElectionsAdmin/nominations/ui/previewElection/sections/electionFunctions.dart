import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/CheckBoxExample.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/yesNoDialog.dart';

class ElectionFunctions extends StatefulWidget {
  bool includeBranchChairPerson;
  bool hdiCompliant;
  String status;
  TextEditingController selectBranch;
  TextEditingController title;
  TextEditingController position;
  TextEditingController criteria;
  TextEditingController count;
  Function(String) updateElectionCriteria;
  Function(String) saveElection;
  ElectionFunctions({
    super.key,
    required this.includeBranchChairPerson,
    required this.selectBranch,
    required this.status,
    required this.title,
    required this.position,
    required this.criteria,
    required this.count,
    required this.hdiCompliant,
    required this.updateElectionCriteria,
    required this.saveElection,
  });

  @override
  State<ElectionFunctions> createState() => _ElectionFunctionsState();
}

class _ElectionFunctionsState extends State<ElectionFunctions> {
  //save election data
  Future saveData(description, statusType) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: YesNoDialog(
          customHeight: 225,
          customWidth: 435,
          description: description,
          closeDialog: () => Navigator.pop(context),
          callFunction: () {
            widget.saveElection(statusType);
          },
        ));
      });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            StyleButton(
                buttonColor: widget.includeBranchChairPerson == true
                    ? Colors.green
                    : Colors.grey,
                description: "Include Branch Chairperson",
                height: 55,
                width: 125,
                onTap: () {
                  widget.updateElectionCriteria("chairPerson");
                }),
            SizedBox(
              width: 15,
            ),
            StyleButton(
                buttonColor:
                    widget.hdiCompliant == true ? Colors.green : Colors.grey,
                description: "HDI Compliant",
                height: 55,
                width: 125,
                onTap: () {
                  widget.updateElectionCriteria("hdi");
                }),
            Spacer(),
            StyleButton(
                description: widget.status,
                height: 55,
                width: 150,
                onTap: () {
                  if (widget.status == "Publish") {
                    saveData(
                        "Are you sure you want to publish this event? It will be visible to members of the branch, but not yet accessible?",
                        "Publish");
                  } else if (widget.status == "UnPublish") {}
                }),
            SizedBox(
              width: 15,
            ),
            Visibility(
              visible: widget.status == "UnPublish" ? true : false,
              child: StyleButton(
                  buttonColor: Colors.grey,
                  description: "Open Nominations",
                  height: 55,
                  width: 150,
                  onTap: () {
                    saveData("Are you sure you want to open the nominations?",
                        "Close Nomination");
                  }),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
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
                textfieldController: widget.selectBranch,
              ),
              SizedBox(
                width: 15,
              ),
              ProfileTextField(
                  customSize: MyUtility(context).width * 0.27,
                  description: "Branch Count",
                  textfieldController: widget.count,
                  textFieldType: "stringType")
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            ProfileTextField(
                customSize: MyUtility(context).width * 0.27,
                description: "Title",
                textfieldController: widget.title,
                textFieldType: "stringType"),
            SizedBox(
              width: 15,
            ),
            ProfileTextField(
                customSize: MyUtility(context).width * 0.27,
                description: "Position",
                textfieldController: widget.position,
                textFieldType: "stringType")
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            ProfileTextField(
                customSize: MyUtility(context).width * 0.55,
                description: "Criteria",
                textfieldController: widget.criteria,
                textFieldType: "stringType"),
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
