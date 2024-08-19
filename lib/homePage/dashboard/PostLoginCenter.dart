import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sama/homePage/dashboard/ui/EventDate.dart';
import 'package:sama/homePage/dashboard/ui/GeneralInfoContainer.dart';
import 'package:sama/components/Morecontainers.dart';
import 'package:sama/components/ReuseableButton.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/homePage/dashboard/ui/samaNotificationsBox.dart';

import 'nonMemberDashboard.dart';

class PostLoginCenter extends StatefulWidget {
  List userNotification;
  String userType;
  PostLoginCenter(
      {super.key, required this.userNotification, required this.userType});

  @override
  State<PostLoginCenter> createState() => _PostLoginCenterState();
}

class _PostLoginCenterState extends State<PostLoginCenter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: widget.userType != "NonMember",
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: SamaNotificationsBox(
                    userNotification: widget.userNotification),
              ),
            ])),
        Visibility(
          visible: widget.userType == "NonMember",
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 50),
            child: NonMemberDashboard(),
          ),
        ),
        SizedBox(
          height: MyUtility(context).height * 0.045,
        ),
      ],
    );
  }
}
