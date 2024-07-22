import 'package:flutter/material.dart';

import '../../../../../components/service/commonService.dart';
import '../../../../../components/yesNoDialog.dart';
import '../../ui/previewElection/ui/dateUpdate.dart';

class SetupChairPersonElection extends StatefulWidget {
  String chairPersonStartDate;
  String chairPersonEndDate;
  Function(String) updateChairPersonDate;
  String electionEndDate;
  bool includeBranchChairPerson;
  VoidCallback updateChairperson;
  SetupChairPersonElection(
      {super.key,
      required this.chairPersonStartDate,
      required this.chairPersonEndDate,
      required this.updateChairPersonDate,
      required this.electionEndDate,
      required this.includeBranchChairPerson,
      required this.updateChairperson});

  @override
  State<SetupChairPersonElection> createState() =>
      _SetupChairPersonElectionState();
}

class _SetupChairPersonElectionState extends State<SetupChairPersonElection> {
  Future updateDate(description, dateNotUnder) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: DateUpdate(
          description: description,
          closeDialog: () => Navigator.pop(context!),
          updateDate: widget.updateChairPersonDate,
          dateNotUnder: dateNotUnder,
        ));
      });

  Future reopenChairPopup() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: YesNoDialog(
          description: "Are you sure you want to close chairperson election",
          closeDialog: () => Navigator.pop(context!),
          callFunction: () {
            widget.updateChairPersonDate(CommonService().getTodaysDateText());
          },
        ));
      });

  checkDateStatus() {
    var status = "";

    if (CommonService().checkDateStarted(widget.chairPersonEndDate) ==
        "After") {
      status = "Completed Closed";
    } else if (CommonService().checkDateStarted(widget.chairPersonStartDate) ==
            "After" &&
        CommonService().checkDateStarted(widget.chairPersonEndDate) ==
            "Before") {
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
                "Activate Chairperson Elections",
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
                  widget.updateChairperson();
                },
                child: Container(
                  width: 65,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: (widget.includeBranchChairPerson == true)
                        ? Color(0xFF174486)
                        : Colors.grey,
                  ),
                  child: Align(
                    alignment: (widget.includeBranchChairPerson == true)
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
          ),
          SizedBox(
            height: 15,
          ),
          Visibility(
              visible: widget.includeBranchChairPerson,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "ChairPerson Eletions",
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
                      /*        Visibility(
                        visible: CommonService().checkDateStarted(
                                    widget.chairPersonEndDate) ==
                                "Before"
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
                        visible: CommonService().checkDateStarted(
                                    widget.chairPersonEndDate) ==
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
                      ),
                    */
                      Spacer(),
                      Visibility(
                        visible:
                            checkDateStatus() == "In Progress" ? true : false,
                        child: InkWell(
                          onTap: () {
                            reopenChairPopup();
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
                    ],
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
                          updateDate(
                              "Update Start Date", widget.electionEndDate);
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
                              "${widget.chairPersonStartDate}",
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
                        onTap: () {},
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
                              "${widget.chairPersonEndDate}",
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
                            widget.chairPersonStartDate,
                            widget.chairPersonEndDate),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF6A6A6A),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
