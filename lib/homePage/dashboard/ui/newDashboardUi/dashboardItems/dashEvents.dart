import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/mobile/components/Themes/font_text.dart';
import 'package:sama/components/myutility.dart';

import '../../../../../commonColors/SamaColors.dart';
import '../../../../../member/Events/MemberEventDetails/MemberEventDetails.dart';
import '../dasboardInfoContainers.dart';
import '../dashboardTextButton.dart';

class DashEvents extends StatefulWidget {
  const DashEvents({super.key});

  @override
  State<DashEvents> createState() => _DashEventsState();
}

class _DashEventsState extends State<DashEvents> {
  var latestEvent = "";
  var secondEvent = "";
  var latestEventId = "";
  var secondEventId = "";
  getEvents() async {
    final data = await FirebaseFirestore.instance.collection('events').get();

    if (data.docs.isNotEmpty) {
      setState(() {
        latestEvent = data.docs[0]['title'];
        latestEventId = data.docs[0]['id'];
        secondEvent = data.docs[1]['title'];
        secondEventId = data.docs[1]['id'];
      });
    }
  }

  //Open dialog for media
  Future openEventDetails(id) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: MemberEventDetails(
          popup: true,
          id: id,
          closeDialog: () => Navigator.pop(context!),
        ));
      });

  @override
  void initState() {
    getEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;

    if (isMobile) {
      return DashboardInfoContainers(
        customWidth: MyUtility(context).width,
        height: 160,
        topBarColor: SamaColors().teal,
        image: "images/icon_events.svg",
        header: 'Events',
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Latest',
                style: FontText(context).bodySmallBlack,
              ),
              const SizedBox(
                height: 8,
              ),
              DashboardTextButton(
                  text: latestEvent,
                  onTap: () {
                    openEventDetails(latestEventId);
                  }),
              DashboardTextButton(
                  text: secondEvent,
                  onTap: () {
                    openEventDetails(secondEventId);
                  }),
            ],
          ),
        ),
      );
    } else {
      return DashboardInfoContainers(
        height: 180,
        topBarColor: SamaColors().teal,
        image: "images/icon_events.svg",
        header: 'Events',
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Latest',
                style: GoogleFonts.openSans(
                    fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              DashboardTextButton(
                  text: latestEvent,
                  onTap: () {
                    openEventDetails(latestEventId);
                  }),
              DashboardTextButton(
                  text: secondEvent,
                  onTap: () {
                    openEventDetails(secondEventId);
                  }),
            ],
          ),
        ),
      );
    }
  }
}
