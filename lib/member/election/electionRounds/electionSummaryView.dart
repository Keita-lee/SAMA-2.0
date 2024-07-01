import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/service/commonService.dart';
import 'package:sama/components/styleButton.dart';

class Electionsummaryview extends StatefulWidget {
  String startDate;
  String endDate;
  String status;
  String statusClosingDate;
  VoidCallback updatePageBasedOnStatus;
  Electionsummaryview(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.status,
      required this.statusClosingDate,
      required this.updatePageBasedOnStatus});

  @override
  State<Electionsummaryview> createState() => _ElectionsummaryviewState();
}

class _ElectionsummaryviewState extends State<Electionsummaryview> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MyUtility(context).width * 0.8,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color(0xFFD1D1D1),
            )),
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    "Nomination and elections from",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "${CommonService().getDateInText(widget.startDate)} -  ${CommonService().getDateInText(widget.endDate)}",
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Current voting status:",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "${widget.status}",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "${widget.status} is open. The will close on the ${CommonService().getDateInText(widget.statusClosingDate)}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Visibility(
                visible:
                    widget.status != "Nomination Acceptance" ? true : false,
                child: StyleButton(
                    description: "Open ${widget.status}",
                    height: 55,
                    width: 150,
                    onTap: () {
                      widget.updatePageBasedOnStatus();
                    }),
              ),
              SizedBox(
                height: 25,
              ),
            ])));
  }
}
