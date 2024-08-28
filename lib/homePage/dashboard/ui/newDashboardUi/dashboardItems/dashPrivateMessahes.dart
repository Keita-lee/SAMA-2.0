import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../commonColors/SamaColors.dart';
import '../dasboardInfoContainers.dart';
import '../dashboardTextButton.dart';

class DashPrivateMessages extends StatefulWidget {
  const DashPrivateMessages({super.key});

  @override
  State<DashPrivateMessages> createState() => _DashPrivateMessagesState();
}

class _DashPrivateMessagesState extends State<DashPrivateMessages> {
  @override
  Widget build(BuildContext context) {
    return DashboardInfoContainers(
      height: 180,
      headerTextButton: true,
      topBarColor: SamaColors().lightBlue,
      image: "images/icon_chat.svg",
      header: 'Private Messages',
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            DashboardTextButton(text: 'You have 10 new messages', onTap: () {}),
          ],
        ),
      ),
    );;
  }
}