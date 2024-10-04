import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/mobile/components/Themes/font_text.dart';
import 'package:sama/components/mobile/components/infoDropdown.dart';
import 'package:sama/homePage/dashboard/ui/EventDate.dart';
import 'package:sama/homePage/dashboard/ui/GeneralInfoContainer.dart';
import 'package:sama/components/Morecontainers.dart';
import 'package:sama/components/ReuseableButton.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/homePage/dashboard/ui/newDashboardUi/addBlockPlaceHolder.dart';
import 'package:sama/homePage/dashboard/ui/newDashboardUi/dasboardInfoContainers.dart';
import 'package:sama/homePage/dashboard/ui/newDashboardUi/dashboardItems/dashProfessionalDev.dart';
import 'package:sama/homePage/dashboard/ui/newDashboardUi/dashboardMidSection.dart';
import 'package:sama/homePage/dashboard/ui/newDashboardUi/welcomeToPortal.dart';
import 'package:sama/homePage/dashboard/ui/samaNotificationsBox.dart';

import '../../member/chats/chat.dart';
import '../../member/helpBot/helpBot.dart';
import 'nonMemberDashboard.dart';
import 'ui/newDashboardUi/dashboardItems/dashCentre.dart';
import 'ui/newDashboardUi/dashboardItems/dashCommunity.dart';
import 'ui/newDashboardUi/dashboardItems/dashEvents.dart';
import 'ui/newDashboardUi/dashboardItems/dashMediaWeb.dart';
import 'ui/newDashboardUi/dashboardItems/dashPrivateMessahes.dart';

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
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return Container(
      color: Colors.white,
      child: Padding(
        padding: isMobile
            ? EdgeInsets.only(top: 0)
            : const EdgeInsets.only(top: 10, left: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: isMobile
                  ? MyUtility(context).width
                  : MyUtility(context).width / 1.31,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //Spacer(),
                    Visibility(
                        visible: widget.userType == "user",
                        child: InkWell(
                            onTap: () {
                              openHelpBotPopup();
                            },
                            child: SvgPicture.asset(
                                width: 30, height: 30, 'images/helpbot.svg'))),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: pageIndex == 1,
              child: Chat(),
            ),
            Visibility(
              visible: widget.userType == "user" && pageIndex == 0 && !isMobile,
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
                visible:
                    widget.userType == "user" && pageIndex == 0 && isMobile,
                child: Container(
                  height: MyUtility(context).height / 1.27,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const InfoDropdown(
                              title: 'Welcome',
                              icon: '',
                              description: 'Notice Description',
                              content: WelcomeToPortal(),
                            ),
                            InfoDropdown(
                              title: 'Notices',
                              icon: 'images/icon_bell.svg',
                              description: 'Notice Description',
                              content: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: MyUtility(context).width - 25,
                                      child: Text(
                                          'Our Member Portal is currently in beta. While we’re excited for you to explore, please note that some features are still being developed. We appreciate your patience and feedback as we work to enhance your experience.',
                                          style:
                                              FontText(context).bodySmallBlack),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const InfoDropdown(
                              title: 'Professional Development',
                              icon: 'images/icon_prof_dev.svg',
                              description:
                                  'Professional Development Description',
                              content: DashProfessionalDev(cpdPoints: '26.8'),
                            ),
                            const InfoDropdown(
                              title: 'Community Discussions',
                              icon: 'images/icon_categories.svg',
                              description: 'Community Discussions Description',
                              content: DashCommunity(),
                            ),
                            InfoDropdown(
                              title: 'Private Messages',
                              icon: 'images/icon_chat.svg',
                              description: 'Private Messages Description',
                              content: DashPrivateMessages(
                                  changePageIndex: changePageIndex),
                            ),
                            const InfoDropdown(
                              title: 'Media & Webinars',
                              icon: 'images/icon_media.svg',
                              description: 'Media & Webinars Description',
                              content: DashMediaWeb(),
                            ),
                            const InfoDropdown(
                              title: 'Centre of Excellence',
                              icon: 'images/icon_centre_of.svg',
                              description: 'Centre of Excellence Description',
                              content: DashCentre(),
                            ),
                            const InfoDropdown(
                              title: 'Events',
                              icon: 'images/icon_events.svg',
                              description: 'Events Description',
                              content: DashEvents(),
                            ),
                          ]),
                    ),
                  ),
                )),
            Visibility(
              visible: widget.userType == "NonMember",
              child: NonMemberDashboard(),
            ),
            SizedBox(
              height: MyUtility(context).height * 0.045,
            ),
          ],
        ),
      ),
    );
  }
}
