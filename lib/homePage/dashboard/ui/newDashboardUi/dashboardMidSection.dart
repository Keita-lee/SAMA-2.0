import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/commonColors/SamaColors.dart';
import 'package:sama/homePage/dashboard/ui/newDashboardUi/dasboardInfoContainers.dart';
import 'package:sama/homePage/dashboard/ui/newDashboardUi/dashboardItems/dashCentre.dart';
import 'package:sama/homePage/dashboard/ui/newDashboardUi/dashboardItems/dashCommunity.dart';
import 'package:sama/homePage/dashboard/ui/newDashboardUi/dashboardItems/dashEvents.dart';
import 'package:sama/homePage/dashboard/ui/newDashboardUi/dashboardItems/dashMediaWeb.dart';
import 'package:sama/homePage/dashboard/ui/newDashboardUi/dashboardItems/dashPrivateMessahes.dart';
import 'package:sama/homePage/dashboard/ui/newDashboardUi/dashboardItems/dashProfessionalDev.dart';

import '../../../../components/myutility.dart';

class DashboardMidSection extends StatefulWidget {
  Function(int) changePageIndex;
  DashboardMidSection({super.key, required this.changePageIndex});

  @override
  State<DashboardMidSection> createState() => _DashboardMidSectionState();
}

class _DashboardMidSectionState extends State<DashboardMidSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DashProfessionalDev(cpdPoints: '26.8'),
            const SizedBox(
              width: 25,
            ),
            DashCommunity(),
            const SizedBox(
              width: 25,
            ),
            DashPrivateMessages(changePageIndex: widget.changePageIndex)
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DashMediaWeb(),
            const SizedBox(
              width: 25,
            ),
            DashCentre(),
            const SizedBox(
              width: 25,
            ),
            DashEvents()
          ],
        ),
      ],
    );
  }
}
