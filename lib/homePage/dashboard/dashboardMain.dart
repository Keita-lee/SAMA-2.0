import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/homePage/dashboard/ui/EventDate.dart';
import 'package:sama/homePage/dashboard/ui/GeneralInfoContainer.dart';
import 'package:sama/components/Morecontainers.dart';
import 'package:sama/components/ReuseableButton.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/homePage/dashboard/ui/newDashboardUi/addBlockPlaceHolder.dart';
import 'package:sama/homePage/dashboard/ui/newDashboardUi/dasboardInfoContainers.dart';
import 'package:sama/homePage/dashboard/ui/newDashboardUi/dashboardMidSection.dart';
import 'package:sama/homePage/dashboard/ui/newDashboardUi/welcomeToPortal.dart';
import 'package:sama/homePage/dashboard/ui/samaNotificationsBox.dart';

import '../../member/chats/chat.dart';
import '../../member/helpBot/helpBot.dart';
import 'nonMemberDashboard.dart';

class DashboardMain extends StatefulWidget {
  List userNotification;
  String userType;
  DashboardMain(
      {super.key, required this.userNotification, required this.userType});

  @override
  State<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  var pageIndex = 0;
  //Dialog for benifits
  Future openHelpBotPopup() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.topRight,
          child: HelpBot(
            closeDialog: () => Navigator.pop(context!),
          ),
        );
      });

  changePageIndex(value) {
    setState(() {
      pageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MyUtility(context).width / 1.31,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Spacer(),
                Visibility(
                    visible: widget.userType != "NonMember",
                    child: InkWell(
                        onTap: () {
                          openHelpBotPopup();
                        },
                        child: SvgPicture.asset(
                            width: 40, height: 40, 'images/helpbot.svg'))),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Visibility(
            visible: pageIndex == 1,
            child: Chat(),
          ),
          Visibility(
            visible: widget.userType != "NonMember" && pageIndex == 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    WelcomeToPortal(),
                    const SizedBox(
                      width: 20,
                    ),
                    DashboardInfoContainers(
                      height: 250,
                      topBarColor: Color.fromRGBO(24, 69, 126, 1),
                      image: 'images/icon_bell.svg',
                      header: 'Notices',
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            Text(
                              'Our Member Portal is currently in beta. While we’re excited for you to explore, please note that some features are still being developed. We appreciate your patience and feedback as we work to enhance your experience.',
                              style: GoogleFonts.openSans(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                DashboardMidSection(changePageIndex: changePageIndex),
                const SizedBox(
                  height: 30,
                ),
                AddBlockPlaceHolder()
              ],
            ),
          ),
          Visibility(
            visible: widget.userType == "NonMember",
            child: NonMemberDashboard(),
          ),
          SizedBox(
            height: MyUtility(context).height * 0.045,
          ),
        ],
      ),
    );
  }
}
