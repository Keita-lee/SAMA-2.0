import 'package:flutter/material.dart';
import 'package:sama/components/service/commonService.dart';

import '../../../components/electionTabStyle.dart';

class ElectionStatus extends StatefulWidget {
  String startDate;
  String endDate;
  String status;
  String statusClosingDate;
  String branch;
  ElectionStatus(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.status,
      required this.statusClosingDate,
      required this.branch});

  @override
  State<ElectionStatus> createState() => _ElectionStatusState();
}

class _ElectionStatusState extends State<ElectionStatus> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Text(
            '${widget.status} round open for ${widget.branch}',
            style: TextStyle(
              fontSize: 25,
              color: Color.fromARGB(255, 0, 159, 158),
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          ElectionTabStyle(
            changePage: () {},
            tabIndexNumber: 0,
            description: widget.status,
            customWidth: 150,
            customColor1: Color.fromARGB(255, 211, 210, 210),
            customColor2: Color.fromARGB(255, 0, 159, 158),
            pageIndex: 0,
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        'Period: ${CommonService().getDateInText(widget.startDate)} to ${CommonService().getDateInText(widget.endDate)}',
        style: TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 58, 65, 65),
          fontWeight: FontWeight.normal,
        ),
      ),
      SizedBox(
        height: 20,
      ),
    ]);
  }
}
