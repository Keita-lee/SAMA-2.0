import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/previewElection/ui/dateUpdate.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/service/commonService.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/yesNoDialog.dart';

class PreviewChairPersonRound extends StatefulWidget {
  String chairPersonStartDate;
  String chairPersonEndDate;
  Function(String) updateChairPersonDate;

  PreviewChairPersonRound(
      {super.key,
      required this.chairPersonStartDate,
      required this.chairPersonEndDate,
      required this.updateChairPersonDate});

  @override
  State<PreviewChairPersonRound> createState() =>
      _PreviewChairPersonRoundState();
}

class _PreviewChairPersonRoundState extends State<PreviewChairPersonRound> {
  //popup to update the date
  Future updateDate(description) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: DateUpdate(
          description: description,
          closeDialog: () => Navigator.pop(context!),
          updateDate: widget.updateChairPersonDate,
          dateNotUnder: '',
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        Text(
          "Chairperson Election",
          style: TextStyle(
              fontSize: 25,
              color: Color(0xFF174486),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 25,
        ),
        Visibility(
          visible:
              CommonService().checkDateStarted(widget.chairPersonEndDate) ==
                      "Before"
                  ? false
                  : true,
          child: StyleButton(
              description: "Close Chairperson Election Early",
              height: 55,
              width: 85,
              onTap: () {
                reopenChairPopup();
              }),
        ),
        Row(
          children: [
            Text(
              "ChairPerson Election from ${CommonService().getDateInText(widget.chairPersonStartDate)} - ${CommonService().getDateInText(widget.chairPersonEndDate)}  ",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF174486),
                  fontWeight: FontWeight.w400),
            ),
            Text(
              "${CommonService().getDaysAmount(widget.chairPersonStartDate, widget.chairPersonEndDate)}",
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
                      text: 'ChairPerson Election',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF174486))),
                  TextSpan(
                      text: CommonService().checkDateStarted(
                                  widget.chairPersonStartDate) ==
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
          "ChairPerson Election Start Date:",
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
                  "${widget.chairPersonStartDate}",
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
            Visibility(
              visible: CommonService()
                          .checkDateStarted(widget.chairPersonStartDate) ==
                      "After"
                  ? false
                  : true,
              child: StyleButton(
                  description: "Update",
                  height: 55,
                  width: 85,
                  onTap: () {
                    updateDate("Update Start Date");
                  }),
            ),
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
                      text: 'ChairPerson Election have',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF174486))),
                  TextSpan(
                      text: CommonService().checkDateStarted(
                                  widget.chairPersonEndDate) ==
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
          "ChairPerson Election End Date:",
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
                  "${widget.chairPersonEndDate}",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF174486),
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
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
