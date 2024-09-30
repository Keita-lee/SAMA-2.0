import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/myutility.dart';
import '../homePage/dashboard/ui/newDashboardUi/dashboardItems/dashCommunity.dart';
import '../homePage/dashboard/ui/newDashboardUi/dashboardItems/dashPrivateMessahes.dart';
import '../homePage/dashboard/ui/newDashboardUi/dashboardItems/dashProfessionalDev.dart';

class ProfileHome extends StatefulWidget {
  String userType;
  ProfileHome({super.key, required this.userType});

  @override
  State<ProfileHome> createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;

    if (isMobile) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DashProfessionalDev(cpdPoints: '26.8'),
          const SizedBox(
            height: 25,
          ),
          Visibility(
              visible: widget.userType != "NonMember", child: DashCommunity()),
          const SizedBox(
            height: 25,
          ),
          Visibility(
              visible: widget.userType != "NonMember",
              child: DashPrivateMessages(changePageIndex: (int) {})),
          const SizedBox(
            height: 15,
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DashProfessionalDev(cpdPoints: '26.8'),
          const SizedBox(
            width: 25,
          ),
          Visibility(
            visible: widget.userType != "NonMember",
            child: DashCommunity(),
          ),
          const SizedBox(
            width: 25,
          ),
          Visibility(
              visible: widget.userType != "NonMember",
              child: DashPrivateMessages(changePageIndex: (int) {})),
        ],
      );
    }
  }
}
