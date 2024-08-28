import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/styleButton.dart';

import '../components/email/sendBugReport.dart';
import '../components/myutility.dart';
import '../components/profileTextField.dart';

class BugReport extends StatefulWidget {
  Function closeDialog;
  BugReport({super.key, required this.closeDialog});

  @override
  State<BugReport> createState() => _BugReportState();
}

class _BugReportState extends State<BugReport> {
  //Controllers
  final whoReportedBug = TextEditingController();
  final issue = TextEditingController();
  final reportedBug = TextEditingController();
  final page = TextEditingController();

  savereport() async {
    var reportData = {
      "id": "",
      "releaseDate": "",
      "whoReportedBug": whoReportedBug.text,
      "issue": issue.text,
      "reportedBug": "",
      "page": page.text,
      "howResolved": "",
      "status": "Pending"
    };

    var myNewDoc =
        await FirebaseFirestore.instance.collection("bugs").add(reportData);

    await sendReportIssueEmail(
        email: 'info@barefootbytes.com',
        reportType: 'Bug in system - ${page.text}',
        description: issue.text);

    await sendReportIssueEmail(
        email: 'kevin@vertopia.net',
        reportType: 'Bug in system - ${page.text}',
        description: issue.text);

    FirebaseFirestore.instance.collection("bugs").doc(myNewDoc.id).update({
      "id": myNewDoc.id,
      "releaseDate": DateTime.now()
    }).whenComplete(() => widget.closeDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MyUtility(context).width / 3,
        height: MyUtility(context).height / 1.8,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color(0xFFD1D1D1),
            )),
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    Text(
                      "Report a Bug",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3D3D3D),
                      ),
                    ),
                    Spacer(),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          widget.closeDialog();
                        },
                        child: Icon(Icons.cancel),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 28,
              ),
              ProfileTextField(
                  customSize: MyUtility(context).width / 4,
                  description: "Who Reported Bug:",
                  textfieldController: whoReportedBug,
                  textFieldType: "stringType"),
              SizedBox(
                height: 15,
              ),
              ProfileDropDownField(
                customSize: 300,
                description: 'Please Select a Page',
                items: [
                  'Dashboard',
                  'Centre of Excellence',
                  "Media & Webinars",
                  "Coding Academy",
                  "Professional Development",
                  "E-Store",
                  "Events",
                  "Communities",
                  "Member Benefits",
                  "Branch Voting",
                  "Profile"
                ],
                textfieldController: page,
              ),
              SizedBox(
                height: 15,
              ),
              ProfileTextField(
                  lines: 5,
                  customHeight: 100,
                  customSize: MyUtility(context).width / 4,
                  description: "What is the issue:",
                  textfieldController: issue,
                  textFieldType: "stringType"),
              SizedBox(
                height: 15,
              ),
              StyleButton(
                  description: "Add Report",
                  height: 50,
                  width: 125,
                  onTap: () {
                    savereport();
                  })
            ]))));
  }
}
