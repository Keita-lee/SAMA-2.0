import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/myutility.dart';

class SamaBlueBanner extends StatefulWidget {
  final String pageName;
  const SamaBlueBanner({super.key, required this.pageName});

  @override
  State<SamaBlueBanner> createState() => _SamaBlueBannerState();
}

class _SamaBlueBannerState extends State<SamaBlueBanner> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return Container(
      width: isMobile
          ? MyUtility(context).width
          : MyUtility(context).width - MyUtility(context).width / 6.5,
      height: isMobile ? 60 : 90,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/bannerBackground.jpg'), fit: BoxFit.fill),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            widget.pageName,
            style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: isMobile ? 20 : 27,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2),
          ),
        ),
      ),
    );
  }
}
