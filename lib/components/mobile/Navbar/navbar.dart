import 'package:flutter/material.dart';
// import 'package:sama_mobile/MainComponants/Navbar/profile_navbar_options.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sama/components/mobile/Navbar/Themes/custom_colors.dart';
import 'package:sama/components/mobile/Navbar/Themes/font_text.dart';
import 'package:sama/components/mobile/Navbar/login_button.dart';
import 'package:sama/components/mobile/Navbar/register_button.dart';

class Navbar extends StatelessWidget {
  final bool visible;
  final Function(String) onButton1Pressed;
  final Function(String) onButton2Pressed;
  final Function(String?) onDropdownChanged;

  const Navbar({
    super.key,
    required this.visible,
    required this.onButton1Pressed,
    required this.onButton2Pressed,
    required this.onDropdownChanged,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Material(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'images/sama_logo.png',
                height: height * 0.14,
                width: width * 0.32,
                fit: BoxFit.fill,
              ),
              Text(
                'Member Portal',
                style: FontText(context).headingLarge,
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // const ProfileNavbarOptions(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, top: 32.0),
                child:
                    LoginButton(onPressed: () => onButton1Pressed('Button 1')),
              ),
              RegisterButton(onPressed: () => onButton2Pressed('Button 2')),
              const SizedBox(height: 8),

              Visibility(
                visible: visible,
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.menu),
                  onSelected: onDropdownChanged,
                  itemBuilder: (BuildContext context) {
                    List<PopupMenuEntry<String>> menuItems = [
                      {
                        'image': 'images/icon_dashboard.svg',
                        'text': 'Dashboard'
                      },
                      {
                        'image': 'images/icon_centre_of.svg',
                        'text': 'Centre of Excellence'
                      },
                      {
                        'image': 'images/icon_media.svg',
                        'text': 'Media & Webinars'
                      },
                      {
                        'image': 'images/icon_prof_dev.svg',
                        'text': 'Professional Development'
                      },
                      {'image': 'images/icon_estore.svg', 'text': 'E-Store'},
                      {'image': 'images/icon_events.svg', 'text': 'Events'},
                      {
                        'image': 'images/icon_categories.svg',
                        'text': 'Communities'
                      },
                      {
                        'image': 'images/icon_benefits.svg',
                        'text': 'Member Benefits'
                      },
                      {
                        'image': 'images/icon_voting.svg',
                        'text': 'Branch Voting'
                      },
                    ].map((item) {
                      return PopupMenuItem<String>(
                        value: item['text'] as String,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              item['image'] as String,
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(item['text'] as String),
                          ],
                        ),
                      );
                    }).toList();

                    // Update the "Back to website" button
                    menuItems.add(
                      PopupMenuItem<String>(
                        value: 'Yellow Button',
                        child: Container(
                          width: double.infinity,
                          color: CustomColors.yellow,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: const Center(
                            child: Text(
                              'Back to website',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    );

                    // Add the new "Contact Us" button
                    menuItems.add(
                      PopupMenuItem<String>(
                        value: 'Blue Button',
                        child: Container(
                          width: double.infinity,
                          color: CustomColors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: const Center(
                            child: Text(
                              'LOGOUT',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );

                    return menuItems;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
