import 'package:flutter/material.dart';
import 'package:sama/components/profileTextField.dart';

import '../../../../../components/myutility.dart';
import '../../../../../components/service/commonService.dart';
import '../../../../../components/styleButton.dart';
import '../../../../../components/yesNoDialog.dart';

class SetupElection2 extends StatefulWidget {
  TextEditingController selectBranch;
  TextEditingController count;
  bool hdiCompliant;
  VoidCallback updateHdi;
  String status;
  Function(String) updateElectionCriteria;
  Function(String) saveElection;
  SetupElection2(
      {super.key,
      required this.selectBranch,
      required this.count,
      required this.hdiCompliant,
      required this.updateHdi,
      required this.status,
      required this.saveElection,
      required this.updateElectionCriteria});

  @override
  State<SetupElection2> createState() => _SetupElection2State();
}

class _SetupElection2State extends State<SetupElection2> {
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 10, 45, 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
          Row(
            children: [
              Text(
                "Select Branch",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF6A6A6A),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              ProfileDropDownField(
                customSize: MyUtility(context).width -
                    (MyUtility(context).width * 0.35),
                description: '',
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
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                "Branch Count",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF6A6A6A),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              ProfileTextField(
                  customSize: MyUtility(context).width * 0.27,
                  description: "",
                  textfieldController: widget.count,
                  textFieldType: "stringType"),
              Spacer(),
              Text(
                "HDI compiliance required",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF6A6A6A),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {
                  widget.updateHdi();
                },
                child: Container(
                  width: 65,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: (widget.hdiCompliant == true)
                        ? Color(0xFF174486)
                        : Colors.grey,
                  ),
                  child: Align(
                    alignment: (widget.hdiCompliant == true)
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
            ],
          )
        ],
      ),
    );
  }
}
