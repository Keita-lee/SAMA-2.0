import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/BugReport/reportEdit/reportEdit.dart';

import '../../components/myutility.dart';
import 'ui/reportHeader.dart';
import 'ui/reportItemStyle.dart';

class BugReportList extends StatefulWidget {
  const BugReportList({super.key});

  @override
  State<BugReportList> createState() => _BugReportListState();
}

class _BugReportListState extends State<BugReportList> {
  var pageIndex = 0;
  var reportItemId = "";

  //change page index state
  changePageIndex(value, id) {
    print(id);
    setState(() {
      pageIndex = value;
      reportItemId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Visibility(
              visible: pageIndex == 0,
              child: Column(
                children: [
                  ReportHeader(),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('bugs')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: snapshot error');
                      }
                      if (!snapshot.hasData) {
                        return const Text('Loading...');
                      }

                      final List<DocumentSnapshot> documents =
                          snapshot.data!.docs;
                      if (documents.isEmpty) {
                        return Center(child: Text('No bugs yet'));
                      }

                      return Container(
                        color: Colors.white,
                        width: MyUtility(context).width -
                            (MyUtility(context).width * 0.25),
                        height: MyUtility(context).height / 2.2,
                        child: ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            final DocumentSnapshot document = documents[index];
                            final data =
                                document.data() as Map<String, dynamic>?;

                            return ReportItemStyle(
                              itemColor: (index % 2 == 1)
                                  ? Colors.white
                                  : const Color.fromARGB(38, 158, 158, 158),
                              issue: data?["issue"] ?? '',
                              isActive:
                                  data?['status'] == "Active" ? true : false,
                              onTapEdit: () {
                                changePageIndex(1, document.id);
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Visibility(
                visible: pageIndex == 1,
                child: ReportEdit(
                    reportId: reportItemId, changePageIndex: changePageIndex))
          ],
        ),
      ),
    );
  }
}
