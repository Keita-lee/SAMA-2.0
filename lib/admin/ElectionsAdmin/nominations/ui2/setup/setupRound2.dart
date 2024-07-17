import 'package:flutter/material.dart';

import '../../../../../components/service/commonService.dart';
import '../../../../../components/yesNoDialog.dart';
import '../../ui/previewElection/ui/dateUpdate.dart';

class SetupRound2 extends StatefulWidget {
  String electionStartDate;
  String electionEndDate;
  Function(String) updateStartDate;
  Function(String) updateEndDate;
  SetupRound2(
      {super.key,
      required this.electionStartDate,
      required this.electionEndDate,
      required this.updateStartDate,
      required this.updateEndDate});

  @override
  State<SetupRound2> createState() => _SetupRound2State();
}

class _SetupRound2State extends State<SetupRound2> {
//popup to update the date
  Future updateDate(description, type) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: DateUpdate(
          description: description,
          closeDialog: () => Navigator.pop(context!),
          updateDate:
              type == "Start" ? widget.updateStartDate : widget.updateEndDate,
        ));
      });

  //Skip Election round
  Future closeElectionPopup() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: YesNoDialog(
          description: "Are you sure you want to close elections",
          closeDialog: () => Navigator.pop(context!),
          callFunction: () {
            widget.updateEndDate(CommonService().getTodaysDateText());
          },
        ));
      });

  //Reopen Election round
  Future reopenElectionsPopup() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: YesNoDialog(
          description: "Are you sure you want to reopen elections",
          closeDialog: () => Navigator.pop(context!),
          callFunction: () {
            widget.updateStartDate(CommonService().getTodaysDateText());
          },
        ));
      });

  checkDateStatus() {
    var status = "";

    if (CommonService().checkDateStarted(widget.electionEndDate) == "After") {
      status = "Completed Closed";
    } else if (CommonService().checkDateStarted(widget.electionStartDate) ==
            "After" &&
        CommonService().checkDateStarted(widget.electionEndDate) == "Before") {
      status = "In Progress";
    } else {
      status = "Not Started";
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 10, 45, 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Round 2 Election",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF6A6A6A),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(checkDateStatus(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: checkDateStatus() == "Completed Closed"
                          ? Colors.red
                          : checkDateStatus() == "In Progress"
                              ? Colors.green
                              : Colors.blue)),
              /*   Visibility(
                visible:
                    CommonService().checkDateStarted(widget.electionEndDate) ==
                            "After"
                        ? false
                        : true,
                child: Text(
                  "(Completely Closed)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.red,
                  ),
                ),
              ),
              Visibility(
                visible:
                    CommonService().checkDateStarted(widget.electionEndDate) ==
                            "Before"
                        ? false
                        : true,
                child: Text(
                  "In Progress",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.green,
                  ),
                ),
              ),*/
              Spacer(),
              Visibility(
                visible:
                    CommonService().checkDateStarted(widget.electionEndDate) ==
                            "After"
                        ? false
                        : true,
                child: InkWell(
                  onTap: () {
                    closeElectionPopup();
                  },
                  child: Text(
                    "Close Early",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF6A6A6A),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible:
                    CommonService().checkDateStarted(widget.electionEndDate) ==
                            "Before"
                        ? false
                        : true,
                child: InkWell(
                  onTap: () {
                    reopenElectionsPopup();
                  },
                  child: Text(
                    "Reopen",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF6A6A6A),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                "Start Date",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF6A6A6A),
                ),
              ),
              SizedBox(
                width: 25,
              ),
              InkWell(
                onTap: () {
                  updateDate("Update End Date", "End");
                },
                child: Container(
                  height: 55,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(7.0),
                      border: Border.all(
                        color: Color(0xFFD1D1D1),
                      )),
                  child: Center(
                    child: Text(
                      "${widget.electionStartDate}",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 201, 201, 201),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 25,
              ),
              Text(
                "End Date",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF6A6A6A),
                ),
              ),
              SizedBox(
                width: 25,
              ),
              InkWell(
                onTap: () {
                  updateDate("Update Start Date", "Start");
                },
                child: Container(
                  height: 55,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(7.0),
                      border: Border.all(
                        color: Color(0xFFD1D1D1),
                      )),
                  child: Center(
                    child: Text(
                      "${widget.electionStartDate}",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 201, 201, 201),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Text(
                CommonService().getDaysAmount(
                    widget.electionStartDate, widget.electionEndDate),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF6A6A6A),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
