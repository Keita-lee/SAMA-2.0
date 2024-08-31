import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../commonColors/SamaColors.dart';
import '../../../../PostLoginLandingPage.dart';
import '../dasboardInfoContainers.dart';
import '../dashboardTextButton.dart';

class DashCommunity extends StatefulWidget {
  const DashCommunity({super.key});

  @override
  State<DashCommunity> createState() => _DashCommunityState();
}

class _DashCommunityState extends State<DashCommunity> {
  var latestTopic = "";

  getResourceTypes() async {
    final data = await FirebaseFirestore.instance
        .collection('communityForum')
        .where("title",
            isEqualTo: "Student, Intern and Community Service Doctors")
        .get();

    if (data.docs.isNotEmpty) {
      setState(() {
        latestTopic = data.docs[0]['discussions']
            [data.docs[0]['discussions'].length - 1]['subject'];
      });
    }
  }

  @override
  void initState() {
    getResourceTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardInfoContainers(
      height: 180,
      topBarColor: SamaColors().lightBlue,
      image: "images/icon_categories.svg",
      header: 'Community Discussions',
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New Topics :',
              style: GoogleFonts.openSans(
                  fontSize: 12, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            DashboardTextButton(
                text: latestTopic,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Material(
                                child: PostLoginLandingPage(
                                    pageIndex: 16,
                                    userId: FirebaseAuth.instance.currentUser !=
                                            null
                                        ? FirebaseAuth.instance.currentUser!.uid
                                        : "",
                                    activeIndex: 8),
                              )));
                }),
          ],
        ),
      ),
    );
  }
}
