import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/yesNoDialog.dart';

class NotificationList extends StatefulWidget {
  Function closeDialog;
  List notificationsList;
  NotificationList(
      {super.key, required this.closeDialog, required this.notificationsList});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  List electionCount = [];

  String _formatDateTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String dayNumber = DateFormat('dd').format(dateTime);

    String month = DateFormat('MMMM').format(dateTime);
    String year = DateFormat('yyyy').format(dateTime);

    return '$dayNumber $month $year ';
  }

//update notification if type = nomination
  updateNotificationNomination(id) async {
    final doc = await FirebaseFirestore.instance
        .collection('notifications')
        .doc(id)
        .update({"data.accept": true});
  }

//popup for notification
  Future openAcceptNomination(notificationId) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: YesNoDialog(
          closeDialog: () => Navigator.pop(context),
          callFunction: () {
            updateNotificationNomination(notificationId);
          },
          description: 'Do you accept this nomination ?',
        ));
      });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MyUtility(context).width / 5.2,
        height: MyUtility(context).height / 2.5,
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
                      "Notifications List",
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
              for (int i = 0; i < widget.notificationsList.length; i++)
                InkWell(
                  onTap: () {
                    if (widget.notificationsList[i]['type'] == "Nomination") {
                      //    openAcceptNomination(widget.notificationsList[i]['id']);
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatDateTime(widget.notificationsList[i]['date']),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF174486),
                        ),
                      ),
                      Text(
                        (widget.notificationsList[i]['message']),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3D3D3D),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 1,
                        width: MyUtility(context).width / 5.2,
                        color: Color(0xFF174486),
                      )
                    ],
                  ),
                )
            ]))));
  }
}
