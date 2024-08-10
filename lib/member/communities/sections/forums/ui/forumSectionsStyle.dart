import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../components/myutility.dart';

class ForumSectionTypeStyle extends StatefulWidget {
  String title;
  String description;
  ForumSectionTypeStyle(
      {super.key, required this.title, required this.description});

  @override
  State<ForumSectionTypeStyle> createState() => _ForumSectionTypeStyleState();
}

class _ForumSectionTypeStyleState extends State<ForumSectionTypeStyle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width / 1.2,
      height: 135,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Color(0xFFD1D1D1),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.title}',
                      style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 8, 55, 145),
                          fontWeight: FontWeight.w100),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '${widget.description}',
                      style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 90, 90, 90),
                          fontWeight: FontWeight.w100),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          'Topic',
                          style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 90, 90, 90),
                              fontWeight: FontWeight.w100),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Post',
                          style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 90, 90, 90),
                              fontWeight: FontWeight.w100),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
