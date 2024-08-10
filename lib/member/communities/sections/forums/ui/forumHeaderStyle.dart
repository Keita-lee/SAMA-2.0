import 'package:flutter/material.dart';

import '../../../../../components/myutility.dart';

class ForumHeaderStyle extends StatefulWidget {
  String title;
  ForumHeaderStyle({super.key, required this.title});

  @override
  State<ForumHeaderStyle> createState() => _ForumHeaderStyleState();
}

class _ForumHeaderStyleState extends State<ForumHeaderStyle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MyUtility(context).width / 1.2,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 8, 55, 145),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Color(0xFFD1D1D1),
              )),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  '${widget.title}',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                Spacer(),
                Text(
                  '',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ));
  }
}
