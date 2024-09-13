import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../commonColors/SamaColors.dart';
import '../../../../../components/myutility.dart';
import '../../../../PostLoginLandingPage.dart';
import '../dasboardInfoContainers.dart';
import '../dashboardTextButton.dart';

class DashCentre extends StatefulWidget {
  const DashCentre({super.key});

  @override
  State<DashCentre> createState() => _DashCentreState();
}

class _DashCentreState extends State<DashCentre> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;

    if (isMobile) {
      return DashboardInfoContainers(
          customWidth: MyUtility(context).width,
          height: 125,
          topBarColor: SamaColors().teal,
          image: "images/icon_centre_of.svg",
          header: 'Centre of Excellence',
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
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Become a contributor',
                    style: GoogleFonts.openSans(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DashboardTextButton(
                      text: 'Learn more',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Material(
                                      child: PostLoginLandingPage(
                                          pageIndex: 1,
                                          userId: FirebaseAuth
                                                      .instance.currentUser !=
                                                  null
                                              ? FirebaseAuth
                                                  .instance.currentUser!.uid
                                              : "",
                                          activeIndex: 1),
                                    )));
                      }),
                ],
              )));
    } else {
      return DashboardInfoContainers(
        height: 180,
        topBarColor: SamaColors().teal,
        image: "images/icon_centre_of.svg",
        header: 'Centre of Excellence',
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
              const SizedBox(
                height: 15,
              ),
              Text(
                'Become a contributor',
                style: GoogleFonts.openSans(
                    fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              DashboardTextButton(
                  text: 'Learn more',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Material(
                                  child: PostLoginLandingPage(
                                      pageIndex: 1,
                                      userId:
                                          FirebaseAuth.instance.currentUser !=
                                                  null
                                              ? FirebaseAuth
                                                  .instance.currentUser!.uid
                                              : "",
                                      activeIndex: 1),
                                )));
                  }),
            ],
          ),
        ),
      );
    }
  }
}
