import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../homePage/dashboard/ui/newDashboardUi/dashboardItems/dashCommunity.dart';
import '../homePage/dashboard/ui/newDashboardUi/dashboardItems/dashPrivateMessahes.dart';
import '../homePage/dashboard/ui/newDashboardUi/dashboardItems/dashProfessionalDev.dart';

class ProfileHome extends StatefulWidget {
  const ProfileHome({super.key});

  @override
  State<ProfileHome> createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
        DashPrivateMessages(changePageIndex: (int) {}),
      ],
    );
  }
}
