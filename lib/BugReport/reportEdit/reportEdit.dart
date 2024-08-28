import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../admin/products/UI/myProductTextField.dart';
import '../../components/email/sendBugReport.dart';
import '../../components/myutility.dart';
import '../../components/styleButton.dart';

class ReportEdit extends StatefulWidget {
  String reportId;
  Function(int, String) changePageIndex;
  ReportEdit(
      {super.key, required this.reportId, required this.changePageIndex});

  @override
  State<ReportEdit> createState() => _ReportEditState();
}

class _ReportEditState extends State<ReportEdit> {
  final issue = TextEditingController();
  final page = TextEditingController();
  final releaseDate = TextEditingController();
  final whoBugReported = TextEditingController();
  final howResolved = TextEditingController();

  //get details for cpd item
  getReportDetails() async {
    DocumentSnapshot reportData = await FirebaseFirestore.instance
        .collection('bugs')
        .doc(widget.reportId)
        .get();

    if (reportData.exists) {
      setState(() {
        issue.text = reportData.get("issue");

        page.text = reportData.get("page");
        whoBugReported.text = reportData.get("whoReportedBug");
      });
    }
  }

//Save to DB
  saveReport(status) async {
    var reportData = {
      "id": widget.reportId,
      "whoReportedBug": whoBugReported.text,
      "issue": issue.text,
      "reportedBug": "",
      "page": page.text,
      "howResolved": howResolved.text,
      "status": status
    };

    FirebaseFirestore.instance
        .collection("bugs")
        .doc(widget.reportId)
        .update(reportData)
        .whenComplete(() => widget.changePageIndex(0, ""));
  }

  @override
  void initState() {
    getReportDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MyUtility(context).width / 1.3,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    StyleButton(
                      description: "Back",
                      height: 55,
                      width: 125,
                      onTap: () {
                        widget.changePageIndex(0, "");
                      },
                      buttonColor: Color.fromARGB(255, 212, 210, 210),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    StyleButton(
                      description: "Pending",
                      height: 55,
                      width: 125,
                      onTap: () {
                        saveReport("Pending");
                        //  saveQuestionnaire("Active");
                      },
                      buttonColor: Color.fromARGB(255, 212, 210, 210),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    StyleButton(
                      description: "Complete",
                      height: 55,
                      width: 125,
                      onTap: () {
                        saveReport("Complete");
                        sendReportIssueEmail(
                            email: 'info@barefootbytes.com',
                            reportType: 'Bug Fixed - ${page.text}',
                            description: issue.text);

                        sendReportIssueEmail(
                            email: 'kevin@vertopia.net',
                            reportType: 'Bug Fixed - ${page.text}',
                            description: issue.text);
                        //  saveQuestionnaire("Active");
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                MyProductTextField(
                  lines: 4,
                  hintText: 'Issue',
                  textfieldController: issue,
                  textFieldWidth: MyUtility(context).width * 0.75,
                  topPadding: 0,
                  header: 'Issue',
                ),
                Row(
                  children: [
                    MyProductTextField(
                      hintText: 'page',
                      textfieldController: page,
                      textFieldWidth: MyUtility(context).width * 0.35,
                      topPadding: 0,
                      header: 'page',
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    MyProductTextField(
                      hintText: 'Who reported bug',
                      textfieldController: whoBugReported,
                      textFieldWidth: MyUtility(context).width * 0.35,
                      topPadding: 0,
                      header: 'Who Reported bug',
                    ),
                  ],
                ),
                MyProductTextField(
                  hintText: 'How was the issue resolved',
                  textfieldController: howResolved,
                  textFieldWidth: MyUtility(context).width * 0.75,
                  topPadding: 0,
                  lines: 4,
                  header: 'How Resolved',
                ),
              ]),
            ])));
  }
}
