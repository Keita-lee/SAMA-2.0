import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/previewElection/ui/dateUpdate.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/service/commonService.dart';
import 'package:sama/components/styleButton.dart';

class PreviewElections extends StatefulWidget {
  String electionStartDate;
  String electionEndDate;
  Function(String) updateStartDate;
  Function(String) updateEndDate;

  PreviewElections(
      {super.key,
      required this.electionStartDate,
      required this.electionEndDate,
      required this.updateStartDate,
      required this.updateEndDate});

  @override
  State<PreviewElections> createState() => _PreviewElectionsState();
}

class _PreviewElectionsState extends State<PreviewElections> {
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        Text(
          "Round 2 Elections",
          style: TextStyle(
              fontSize: 25,
              color: Color(0xFF174486),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Text(
              "Round 2 Elections from ${CommonService().getDateInText(widget.electionStartDate)} - ${CommonService().getDateInText(widget.electionEndDate)}  ",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF174486),
                  fontWeight: FontWeight.w400),
            ),
            Text(
              "${CommonService().getDaysAmount(widget.electionStartDate, widget.electionEndDate)}",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF174486),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            RichText(
              text: TextSpan(
                text: '',
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: 'Round 2 Elections have',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF174486))),
                  TextSpan(
                      text: CommonService()
                                  .checkDateStarted(widget.electionStartDate) ==
                              "After"
                          ? "  started "
                          : "  not yet started. You may update the starting date",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF174486),
                          fontWeight: FontWeight.bold)),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          "Election Start Date:",
          style: TextStyle(
              fontSize: 16,
              color: Color(0xFF174486),
              fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Container(
              height: 55,
              width: 110,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 223, 223, 223),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color(0xFFD1D1D1),
                  )),
              child: Center(
                child: Text(
                  "${widget.electionStartDate}",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF174486),
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            StyleButton(
                description: "Update",
                height: 55,
                width: 85,
                onTap: () {
                  updateDate("Update Start Date", "Start");
                }),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          children: [
            RichText(
              text: TextSpan(
                text: '',
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: 'Round 2 Elections have',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF174486))),
                  TextSpan(
                      text: CommonService()
                                  .checkDateStarted(widget.electionEndDate) ==
                              "After"
                          ? "  finished "
                          : "  not yet finished. You may update the ending date",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF174486),
                          fontWeight: FontWeight.bold)),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          "Election End Date:",
          style: TextStyle(
              fontSize: 16,
              color: Color(0xFF174486),
              fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Container(
              height: 55,
              width: 110,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 223, 223, 223),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color(0xFFD1D1D1),
                  )),
              child: Center(
                child: Text(
                  "${widget.electionEndDate}",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF174486),
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            StyleButton(
                description: "Update",
                height: 55,
                width: 85,
                onTap: () {
                  updateDate("Update End Date", "End");
                }),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        Container(
          color: Colors.grey,
          height: 1,
          width: MyUtility(context).width / 1.8,
        ),
      ],
    );
  }
}
