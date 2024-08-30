import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/homePage/dashboard/ui/newDashboardUi/dashboardTextButton.dart';

import '../../../../../commonColors/SamaColors.dart';
import '../dasboardInfoContainers.dart';

class DashProfessionalDev extends StatefulWidget {
  final String cpdPoints;
  const DashProfessionalDev({super.key, required this.cpdPoints});

  @override
  State<DashProfessionalDev> createState() => _DashProfessionalDevState();
}

class _DashProfessionalDevState extends State<DashProfessionalDev> {
  @override
  Widget build(BuildContext context) {
    return DashboardInfoContainers(
      height: 180,
      activeTopBar: false,
      topBarColor: SamaColors().yellow,
      image: 'images/icon_prof_dev.svg',
      header: 'Professional Development',
      svgColor: Colors.black,
      extendedTopBarColor: SamaColors().yellow,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*   Align(
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'My SAMA CPD points: ',
                      style: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                        text: widget.cpdPoints,
                        style: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),*/
            const SizedBox(
              height: 20,
            ),
            //DashboardTextButton(text: 'View CPD Quizes', onTap: () {}),
            DashboardTextButton(text: 'List and find CPD Quizes', onTap: () {})
          ],
        ),
      ),
    );
  }
}
