import 'package:flutter/material.dart';

import '../../../../../components/service/commonService.dart';

class SetupAcceptance extends StatefulWidget {
  String nominateAcceptStartDate;
  String nominateAcceptEndDate;
  SetupAcceptance(
      {super.key,
      required this.nominateAcceptStartDate,
      required this.nominateAcceptEndDate});

  @override
  State<SetupAcceptance> createState() => _SetupAcceptanceState();
}

class _SetupAcceptanceState extends State<SetupAcceptance> {
  checkDateStatus() {
    var status = "";

    if (CommonService().checkDateStarted(widget.nominateAcceptEndDate) ==
        "After") {
      status = "Completed Closed";
    } else if (CommonService()
                .checkDateStarted(widget.nominateAcceptStartDate) ==
            "After" &&
        CommonService().checkDateStarted(widget.nominateAcceptEndDate) ==
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
        child: Column(children: [
          Row(children: [
            Text(
              "Nomination Acceptance Round",
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
            /*      Visibility(
              visible: CommonService()
                          .checkDateStarted(widget.nominateAcceptEndDate) ==
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
              visible: CommonService()
                          .checkDateStarted(widget.nominateAcceptEndDate) ==
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
          ]),
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
              Container(
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
                    "${widget.nominateAcceptStartDate}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 201, 201, 201),
                        fontWeight: FontWeight.w400),
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
              Container(
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
                    "${widget.nominateAcceptEndDate}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 201, 201, 201),
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Spacer(),
              Text(
                CommonService().getDaysAmount(widget.nominateAcceptStartDate,
                    widget.nominateAcceptEndDate),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF6A6A6A),
                ),
              ),
            ],
          )
        ]));
  }
}
