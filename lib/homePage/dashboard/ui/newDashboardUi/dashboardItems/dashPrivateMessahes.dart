import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/mobile/components/Themes/font_text.dart';

import '../../../../../commonColors/SamaColors.dart';
import '../../../../../components/myutility.dart';
import '../dasboardInfoContainers.dart';
import '../dashboardTextButton.dart';

class DashPrivateMessages extends StatefulWidget {
  Function(int) changePageIndex;
  DashPrivateMessages({super.key, required this.changePageIndex});

  @override
  State<DashPrivateMessages> createState() => _DashPrivateMessagesState();
}

class _DashPrivateMessagesState extends State<DashPrivateMessages> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    if (isMobile) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        DashboardInfoContainers(
            customWidth: MyUtility(context).width,
            height: 75,
            headerTextButton: true,
            topBarColor: SamaColors().lightBlue,
            image: "images/icon_chat.svg",
            header: 'Private Messages',
            child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Coming soon!',
                        style: FontText(context).bodySmallBlack,
                      ),
                    ])))
      ]);
    } else {
      return DashboardInfoContainers(
        height: 180,
        headerTextButton: true,
        topBarColor: SamaColors().lightBlue,
        image: "images/icon_chat.svg",
        header: 'Private Messages',
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Coming soon!',
                style: GoogleFonts.openSans(
                    fontSize: 12, fontWeight: FontWeight.w600),
              ),
              /*  InkWell(
                onTap: () {
                  widget.changePageIndex(1);
                },
                child: DashboardTextButton(
                    text: 'You have 10 new messages',
                    onTap: () {
                      widget.changePageIndex(1);
                    })),*/
            ],
          ),
        ),
      );
    }
  }
}
