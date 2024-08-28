import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../commonColors/SamaColors.dart';
import '../dasboardInfoContainers.dart';
import '../dashboardTextButton.dart';

class DashCommunity extends StatefulWidget {
  const DashCommunity({super.key});

  @override
  State<DashCommunity> createState() => _DashCommunityState();
}

class _DashCommunityState extends State<DashCommunity> {
  @override
  Widget build(BuildContext context) {
    return DashboardInfoContainers(
      height: 180,
      topBarColor: SamaColors().lightBlue,
      image: "images/icon_categories.svg",
      header: 'Community Discussions',
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New Topics',
              style: GoogleFonts.openSans(
                  fontSize: 12, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            DashboardTextButton(text: 'This is a new topic', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
