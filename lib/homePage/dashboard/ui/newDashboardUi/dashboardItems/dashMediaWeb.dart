import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../commonColors/SamaColors.dart';
import '../dasboardInfoContainers.dart';
import '../dashboardTextButton.dart';

class DashMediaWeb extends StatefulWidget {
  const DashMediaWeb({super.key});

  @override
  State<DashMediaWeb> createState() => _DashMediaWebState();
}

class _DashMediaWebState extends State<DashMediaWeb> {
  @override
  Widget build(BuildContext context) {
    return DashboardInfoContainers(
      height: 180,
      topBarColor: SamaColors().teal,
      image: "images/icon_media.svg",
      header: 'Media & Webinars',
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
            DashboardTextButton(text: 'Transition to Private Practice - the', onTap: () {}),
            DashboardTextButton(text: 'mindset for success', onTap: () {}),
          ],
        ),
      ),
    );
  }
}