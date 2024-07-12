import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/myutility.dart';

class SamaNotificationsBox extends StatefulWidget {
  const SamaNotificationsBox({super.key});

  @override
  State<SamaNotificationsBox> createState() => _SamaNotificationsBoxState();
}

class _SamaNotificationsBoxState extends State<SamaNotificationsBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width / 5.5,
      height: MyUtility(context).height * 0.6,
      decoration: BoxDecoration(
        color: Color.fromRGBO(174, 204, 236, 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only( bottom: 15, top: 10),
              child: Text(
                'SAMA Notifications',
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF174486),
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Elections: ',
                    style: GoogleFonts.openSans(
                        color: Color(0xFF174486),
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  TextSpan(
                    text:
                        'You have nominated for "Branch Council Member at Border Coastal(BCB) Branch"',
                    style: GoogleFonts.openSans(
                        color: Color(0xFF174486), fontSize: 16),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Read More',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF174486),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFF174486),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Announcement: ',
                    style: GoogleFonts.openSans(
                        color: Color(0xFF174486),
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  TextSpan(
                    text:
                        'The new SAMA Member Portal is now live. Learn more and discover resources availible to you.',
                    style: GoogleFonts.openSans(
                        color: Color(0xFF174486), fontSize: 16),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Read More',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF174486),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFF174486),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
