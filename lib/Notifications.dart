import 'package:flutter/material.dart';
import 'package:sama/components/CheckBox.dart';
import 'package:sama/components/CheckBoxCircle.dart';
import 'package:sama/components/CheckBoxExample.dart';
import 'package:sama/components/myutility.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notifications',
          style: TextStyle(
              fontSize: 26,
              color: Color(0xFF174486),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: MyUtility(context).height * 0.05,
        ),
        Text(
          'Media Feed',
          style: TextStyle(
              fontSize: 22,
              color: Color(0xFF174486),
              fontWeight: FontWeight.normal),
        ),
        SizedBox(
          height: MyUtility(context).height * 0.05,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'What type of media content do you want to see?',
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF6A6A6A),
                fontWeight: FontWeight.normal),
          ),
        ),
        CheckBox(
            name: "Medical News",
            discription:
                "Medical News Show news articles, updates, and research relevant to the medical profession."),
        CheckBox(
            name: "Events and Announcements",
            discription:
                "Display information about upcoming events, conferences, and important announcements."),
        CheckBox(
            name: "Member Updates",
            discription:
                "Highlight posts and updates from other members within the users network."),
        CheckBox(
            name: "Educational Content",
            discription: "Educational resources, courses, and publications."),
        SizedBox(
          height: MyUtility(context).height * 0.05,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'The following categories interest me the most',
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF6A6A6A),
                fontWeight: FontWeight.normal),
          ),
        ),
        CheckBoxExample(name: 'Example'),
        CheckBoxExample(name: 'Example'),
        CheckBoxExample(name: 'Example'),
        SizedBox(
          height: MyUtility(context).height * 0.05,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'Email Notifications',
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF6A6A6A),
                fontWeight: FontWeight.normal),
          ),
        ),
        CheckBoxCircle(
            header: 'Daily Digest',
            discription:
                "Receive a daily summary of website activity and updates."),
        CheckBoxCircle(
            header: 'Weekly Updates',
            discription:
                "Get a weekly email with highlights and important information."),
        CheckBoxCircle(
            header: 'Custom Alerts',
            discription: "Only notify me of the following:"),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CheckBoxExample(name: 'Example'),
                CheckBoxExample(name: 'Example'),
              ],
            ),
            SizedBox(
              width: MyUtility(context).width * 0.05,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CheckBoxExample(name: 'Example'),
                CheckBoxExample(name: 'Example'),
              ],
            ),
            SizedBox(
              width: MyUtility(context).width * 0.05,
            ),
            CheckBoxExample(name: 'Example'),
          ],
        ),
        CheckBoxCircle(
            header: 'No Email',
            discription:
                "Notifications Opt out of email notifications entirely."),
        SizedBox(
          height: MyUtility(context).height * 0.05,
        ),
        SizedBox(
          width: MyUtility(context).width / 1.62,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: MyUtility(context).width * 0.05,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF174486),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: MyUtility(context).height * 0.1,
        )
      ],
    );
  }
}
