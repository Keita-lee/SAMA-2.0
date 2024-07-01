import 'package:flutter/material.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/previewElection/ui/dateUpdate.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/service/commonService.dart';

class PreviewAcceptanceRound extends StatefulWidget {
  String nominateAcceptStartDate;
  String nominateAcceptEndDate;

  PreviewAcceptanceRound({
    super.key,
    required this.nominateAcceptStartDate,
    required this.nominateAcceptEndDate,
  });

  @override
  State<PreviewAcceptanceRound> createState() => _PreviewAcceptanceRoundState();
}

class _PreviewAcceptanceRoundState extends State<PreviewAcceptanceRound> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 25,
      ),
      Text(
        "Nomination Acceptance Round  ",
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
            "The Collection round is from  ",
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFF174486),
                fontWeight: FontWeight.w400),
          ),
          Text(
            "${CommonService().getDateInText(widget.nominateAcceptStartDate)}  ",
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFF174486),
                fontWeight: FontWeight.bold),
          ),
          Text(
            "until",
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFF174486),
                fontWeight: FontWeight.w400),
          ),
          Text(
            "${CommonService().getDateInText(widget.nominateAcceptEndDate)}",
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFF174486),
                fontWeight: FontWeight.bold),
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
    ]);
  }
}
