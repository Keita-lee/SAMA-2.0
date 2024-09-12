import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../commonColors/SamaColors.dart';
import '../../../../../components/myutility.dart';
import '../../../../../member/media/mediaPopup/mediaPopup.dart';
import '../dasboardInfoContainers.dart';
import '../dashboardTextButton.dart';

class DashMediaWeb extends StatefulWidget {
  const DashMediaWeb({super.key});

  @override
  State<DashMediaWeb> createState() => _DashMediaWebState();
}

class _DashMediaWebState extends State<DashMediaWeb> {
  var title = "";
  var id = "";

  //Open dialog for media
  Future openMediaDialog(id) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: MediaPopup(
          id: id,
          closeDialog: () => Navigator.pop(context!),
        ));
      });

  getMedia() async {
    final data = await FirebaseFirestore.instance.collection('media').get();

    if (data.docs.isNotEmpty) {
      setState(() {
        title = data.docs[0]['title'];
        id = data.docs[0]['id'];
      });
    }
  }

  @override
  void initState() {
    getMedia();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Latest',
            style:
                GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8,
          ),
          DashboardTextButton(
              text: title,
              onTap: () {
                openMediaDialog(id);
              }),
        ],
      );
    } else {
      return DashboardInfoContainers(
        height: 180,
        topBarColor: SamaColors().teal,
        image: "images/icon_media.svg",
        header: 'Media & Webinars',
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Latest',
                style: GoogleFonts.openSans(
                    fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              DashboardTextButton(
                  text: title,
                  onTap: () {
                    openMediaDialog(id);
                  }),
            ],
          ),
        ),
      );
    }
  }
}
