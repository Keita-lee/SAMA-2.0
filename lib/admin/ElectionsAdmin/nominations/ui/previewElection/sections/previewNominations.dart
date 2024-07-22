import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/previewElection/ui/dateUpdate.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/service/commonService.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/yesNoDialog.dart';

class PreviewNominations extends StatefulWidget {
  String nominationStartDate;
  String nominationEndDate;
  Function(String) updateStartDate;
  Function(String) updateEndDate;

  PreviewNominations({
    super.key,
    required this.nominationStartDate,
    required this.nominationEndDate,
    required this.updateStartDate,
    required this.updateEndDate,
  });

  @override
  State<PreviewNominations> createState() => _PreviewNominationsState();
}

class _PreviewNominationsState extends State<PreviewNominations> {
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
          dateNotUnder: '',
        ));
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        Text(
          "Round 1 Nominations",
          style: TextStyle(
              fontSize: 25,
              color: Color(0xFF174486),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 25,
        ),
        Visibility(
          visible: CommonService().checkDateStarted(widget.nominationEndDate) ==
                  "After"
              ? false
              : true,
          child: StyleButton(
              description: "Close Nominations Early",
              height: 55,
              width: 85,
              onTap: () {
                closeNominationsPopup();
              }),
        ),
        Visibility(
          visible: CommonService().checkDateStarted(widget.nominationEndDate) ==
                  "Before"
              ? false
              : true,
          child: StyleButton(
              description: "Reopen Nominations",
              height: 55,
              width: 85,
              onTap: () {
                reopenNominationsPopup();
              }),
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Text(
              "Round 1 Nominations from ${CommonService().getDateInText(widget.nominationStartDate)} - ${CommonService().getDateInText(widget.nominationEndDate)}  ",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF174486),
                  fontWeight: FontWeight.w400),
            ),
            Text(
              "${CommonService().getDaysAmount(widget.nominationStartDate, widget.nominationEndDate)}",
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
                      text: 'Round 1 Nominations have',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF174486))),
                  TextSpan(
                      text: CommonService().checkDateStarted(
                                  widget.nominationStartDate) ==
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
          "Nomination Start Date:",
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
                  "${widget.nominationStartDate}",
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
                          .checkDateStarted(widget.nominationStartDate) ==
                      "After"
                  ? false
                  : true,
              child: StyleButton(
                  description: "Update",
                  height: 55,
                  width: 85,
                  onTap: () {
                    updateDate("Update Start Date", "Start");
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
                      text: 'Round 1 Nominations have',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF174486))),
                  TextSpan(
                      text: CommonService()
                                  .checkDateStarted(widget.nominationEndDate) ==
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
          "Nomination End Date:",
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
                  "${widget.nominationEndDate}",
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
              visible:
                  CommonService().checkDateStarted(widget.nominationEndDate) ==
                          "After"
                      ? false
                      : true,
              child: StyleButton(
                  description: "Update",
                  height: 55,
                  width: 85,
                  onTap: () {
                    updateDate("Update End Date", "End");
                  }),
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
