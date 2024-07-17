import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/myutility.dart';

import '../../../components/yesNoDialog.dart';

class SamaNotificationsBox extends StatefulWidget {
  List userNotification;
  SamaNotificationsBox({super.key, required this.userNotification});

  @override
  State<SamaNotificationsBox> createState() => _SamaNotificationsBoxState();
}

class _SamaNotificationsBoxState extends State<SamaNotificationsBox> {
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
      width: MyUtility(context).width / 5.5,
      height: MyUtility(context).height * 0.6,
      decoration: BoxDecoration(
        color: Color.fromRGBO(174, 204, 236, 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15, top: 10),
                child: Text(
                  'SAMA Notifications',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF174486),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              for (int i = 0; i < widget.userNotification.length; i++)
                Column(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: widget.userNotification[i]['type'],
                            style: GoogleFonts.openSans(
                                color: Color(0xFF174486),
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          TextSpan(
                            text: (widget.userNotification[i]['message']),
                            style: TextStyle(
                                color: Color(0xFF174486), fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            if (widget.userNotification[i]['type'] ==
                                "Nomination") {
                              openAcceptNomination(
                                  widget.userNotification[i]['id']);
                            }
                          },
                          child: Text(
                            'Read More',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF174486),
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFF174486),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
