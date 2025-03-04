import 'package:flutter/material.dart';
import 'package:sama/components/mobile/components/Themes/font_text.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this import

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(5), // Adjust the radius as needed
            child: Image.asset(
              'images/bannerBackground.jpg',
              fit: BoxFit.fitWidth,
              width: width, // Add this line to set the width
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Copyright © ${DateTime.now().year} The South African Medical Association',
              style: FontText(context).footerSmallBlack,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8.0, // Horizontal space between items
            runSpacing: 8.0, // Vertical space between lines
            children: [
              InkWell(
                onTap: () async {
                  const url = 'https://southafricanmedical.org/contact-us/';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Text('Contact SAMA', style: FontText(context).linksBlue),
              ),
              _verticalDivider(),
              InkWell(
                onTap: () async {
                  const url = 'https://samedical.org/privacy-policy/';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Text('SAMA Privacy', style: FontText(context).linksBlue),
              ),
              _verticalDivider(),
              InkWell(
                onTap: () async {
                  const url = 'https://samedical.org/paia-policy/';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Text('PAIA Policy', style: FontText(context).linksBlue),
              ),
              _verticalDivider(),
              InkWell(
                onTap: () async {
                  const url = 'https://vertopia.co.za/';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Text('Solution by Vertopia',
                    style: FontText(context).linksBlue),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Container(
        height: 15,
        width: 2,
        color: Colors.grey[500],
      ),
    );
  }
}
