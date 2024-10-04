import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/mobile/components/Themes/font_text.dart';
import 'package:sama/components/myutility.dart';

class WelcomeToPortal extends StatefulWidget {
  const WelcomeToPortal({super.key});

  @override
  State<WelcomeToPortal> createState() => _WelcomeToPortalState();
}

class _WelcomeToPortalState extends State<WelcomeToPortal> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: MyUtility(context).height / 8,
                  width: MyUtility(context).width / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                    image: DecorationImage(
                        image: AssetImage('images/dashboarImg.png'),
                        fit: BoxFit.fill),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text('Welcome to the \nSAMA Member Potral',
                    style: FontText(context).mediumBlue),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MyUtility(context).width - 25,
              child: Text(
                'Here, you can access valuable resources, connect with fellow professionals, and explore opportunities to contribute to our shared mission of advancing healthcare in South Africa. Enjoy all the benefits of your membership and connect with our community!',
                style: FontText(context).bodySmallBlack,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 250,
        width: 628,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color.fromARGB(255, 190, 190, 190)),
        ),
        child: Row(
          children: [
            Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8)),
                image: DecorationImage(
                    image: AssetImage('images/dashboarImg.png'),
                    fit: BoxFit.fill),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to the \nSAMA Member Potral',
                    style: GoogleFonts.openSans(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 250,
                    child: Text(
                      'Here, you can access valuable resources, connect with fellow professionals, and explore opportunities to contribute to our shared mission of advancing healthcare in South Africa. Enjoy all the benefits of your membership and connect with our community!',
                      style: GoogleFonts.openSans(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
