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
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Container(
          width: MyUtility(context).width / 1.3,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 8, 55, 145),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    '${widget.title}',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.start,
                  ),
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
