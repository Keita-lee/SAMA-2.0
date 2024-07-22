import 'package:flutter/material.dart';

import '../../../../../components/service/commonService.dart';
import '../../../../../components/yesNoDialog.dart';
import '../../ui/previewElection/ui/dateUpdate.dart';

class SetupRound1 extends StatefulWidget {
  String nominationStartDate;
  String nominationEndDate;
  String electionId;
  Function(String) updateStartDate;
  Function(String) updateEndDate;
  Function(String) getEmailType;
  SetupRound1(
      {super.key,
      required this.nominationStartDate,
      required this.nominationEndDate,
      required this.electionId,
      required this.updateStartDate,
      required this.updateEndDate,
      required this.getEmailType});

  @override
  State<SetupRound1> createState() => _SetupRound1State();
}

class _SetupRound1State extends State<SetupRound1> {
  //popup to update the date
  Future updateDate(description, type, dateNotUnder) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: DateUpdate(
                description: description,
                closeDialog: () => Navigator.pop(context!),
                updateDate: type == "Start"
                    ? widget.updateStartDate
                    : widget.updateEndDate,
                dateNotUnder: dateNotUnder));
      });

  //Skip Nominations round
  Future closeNominationsPopup() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: YesNoDialog(
          description: "Are you sure you want to close nominations",
          closeDialog: () => Navigator.pop(context!),
          callFunction: () {
            widget.updateEndDate(CommonService().getTodaysDateText());
          },
        ));
      });

  //Reopen Nominations round
  Future reopenNominationsPopup() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: YesNoDialog(
          description: "Are you sure you want to reopen nominations",
          closeDialog: () => Navigator.pop(context!),
          callFunction: () {
            widget.updateStartDate(CommonService().getTodaysDateText());
          },
        ));
      });

  checkDateStatus() {
    var status = "";

    if (CommonService().checkDateStarted(widget.nominationEndDate) == "After") {
      status = "Completed Closed";
    } else if (CommonService().checkDateStarted(widget.nominationStartDate) ==
            "After" &&
        CommonService().checkDateStarted(widget.nominationEndDate) ==
            "Before") {
      status = "In Progress";
    } else {
      status = "Not Started";
    }
    return status;
  }

//  "Completed Closed",   "In Progress",   "Not Started",
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 10, 45, 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Round 1 Nominations",
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
                visible: CommonService().checkDatePeriod(
                    widget.nominationStartDate, widget.nominationEndDate),
                child: Text(
                  "In Progress",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.green,
                  ),
                ),
              ),
                Visibility(
                visible: CommonService()
                            .checkDateStarted(widget.nominationStartDate) ==
                        "Before"
                    ? true
                    : false,
                child: Text(
                  "Not Started",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color.fromARGB(255, 55, 71, 209),
                  ),
                ),
              ), */
              Spacer(),
              Visibility(
                visible: checkDateStatus() == "In Progress" ? true : false,
                child: InkWell(
                  onTap: () {
                    closeNominationsPopup();
                    widget.getEmailType("Nomination Close Early");
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
                visible: checkDateStatus() == "Completed Closed" ? true : false,
                child: InkWell(
                  onTap: () {
                    reopenNominationsPopup();
                    widget.getEmailType("Nomination Reopen");
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
                  fontSize: 18,
                  color: Color(0xFF6A6A6A),
                ),
              ),
              SizedBox(
                width: 25,
              ),
              InkWell(
                onTap: () {
                  updateDate("Update Start Date", "Start",
                      CommonService().getTodaysDateText());
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
                      "${widget.nominationStartDate}",
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
                  updateDate(
                      "Update End Date", "End", widget.nominationStartDate);
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
                      "${widget.nominationEndDate}",
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
                    widget.nominationStartDate, widget.nominationEndDate),
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
