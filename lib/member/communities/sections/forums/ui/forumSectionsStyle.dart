import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sama/member/communities/sections/forums/ui/LastPost.dart';

import '../../../../../components/myutility.dart';

class ForumSectionTypeStyle extends StatefulWidget {
  String title;
  String description;
  final String postText;
  final String userImageUrl;
  final String postTime;
  final String userName;
  ForumSectionTypeStyle({
    super.key,
    required this.title,
    required this.description,
    required this.postText,
    required this.userImageUrl,
    required this.postTime,
    required this.userName,
  });

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
        child: Row(
          children: [
            Container(
              width: MyUtility(context).width * 0.06,
              child: Icon(
                FontAwesomeIcons.commentMedical,
                size: 45.0,
                color: Colors.black,
              ),
            ),
            Column(
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
                          height: 5,
                        ),
                        SizedBox(
                          height: MyUtility(context).height * 0.065,
                          width: MyUtility(context).width * 0.5,
                          child: Text(
                            '${widget.description}',
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 90, 90, 90),
                                fontWeight: FontWeight.w100),
                            textAlign: TextAlign.start,
                            softWrap: true,
                          ),
                        ),
                        SizedBox(
                          height: 10,
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
            LastPost(
              text: widget.postText,
              userImageUrl: widget.userImageUrl,
              postTime: widget.postTime,
              userName: widget.userName,
            ),
          ],
        ),
      ),
    );
  }
}
