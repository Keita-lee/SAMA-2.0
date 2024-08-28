import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../commonColors/SamaColors.dart';
import '../dasboardInfoContainers.dart';
import '../dashboardTextButton.dart';

class DashEvents extends StatefulWidget {
  const DashEvents({super.key});

  @override
  State<DashEvents> createState() => _DashEventsState();
}

class _DashEventsState extends State<DashEvents> {
  @override
  Widget build(BuildContext context) {
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
            DashboardTextButton(text: 'CPD | Golding Institute = Cognitive', onTap: () {}),
            DashboardTextButton(text: 'Decline | 30 Clinical Points', onTap: () {}),
          ],
        ),
      ),
    );
  }
}