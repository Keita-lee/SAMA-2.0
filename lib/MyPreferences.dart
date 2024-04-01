import 'package:flutter/material.dart';
import 'package:sama/components/CheckCircle.dart';
import 'package:sama/components/myutility.dart';

class MyPreferences extends StatefulWidget {
  const MyPreferences({super.key});

  @override
  State<MyPreferences> createState() => _MyPreferencesState();
}

class _MyPreferencesState extends State<MyPreferences> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Preferences',
          style: TextStyle(
              fontSize: 26,
              color: Color(0xFF174486),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: MyUtility(context).height * 0.05,
        ),
        Text(
          'Your Profile',
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
            'Who can see your profile?',
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF6A6A6A),
                fontWeight: FontWeight.normal),
          ),
        ),
        CheckCircle(name: "Everyone (Public)"),
        CheckCircle(name: "Members Only"),
        CheckCircle(name: "Private"),
        SizedBox(
          height: MyUtility(context).height * 0.05,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'Who can see your profile picture?',
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF6A6A6A),
                fontWeight: FontWeight.normal),
          ),
        ),
        CheckCircle(name: "Everyone (Public)"),
        CheckCircle(name: "Members Only"),
        CheckCircle(name: "Private"),
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
