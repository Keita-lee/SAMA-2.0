import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/service/commonService.dart';
import 'package:sama/components/utility.dart';

import '../../../../../../components/styleButton.dart';
import 'sections/addComment.dart';
import 'ui/discusStyle.dart';

class ViewTopic extends StatefulWidget {
  String title;
  String description;
  String date;
  Map createdBy;
  List discussions;
  List commentDiscussions;
  int discussionIndex;
  String communityId;
  String subject;
  ViewTopic(
      {super.key,
      required this.title,
      required this.description,
      required this.date,
      required this.createdBy,
      required this.discussions,
      required this.commentDiscussions,
      required this.discussionIndex,
      required this.communityId,
      required this.subject});

  @override
  State<ViewTopic> createState() => _ViewTopicState();
}

class _ViewTopicState extends State<ViewTopic> {
  var pageIndex = 0;

  changePageIndex(value) {
    setState(() {
      pageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.commentDiscussions);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MyUtility(context).width / 1.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                StyleButton(
                    description: "Reply",
                    height: 55,
                    width: 125,
                    onTap: () {
                      setState(() {
                        pageIndex = 1;
                      });
                    }),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Visibility(
            visible: pageIndex == 1 ? true : false,
            child: AddComment(
              changePageIndex: changePageIndex,
              communityId: widget.communityId,
              communityDiscussion: widget.discussions,
              commentDiscussions: widget.commentDiscussions,
              discussionIndex: widget.discussionIndex,
              subject: widget.title,
            ),
          ),
          /*Text(
            widget.title,
            style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 87, 87, 87),
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),*/
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: DiscusStyle(
              profileUrl: widget.createdBy['profileImage'],
              name: widget.createdBy['name'],
              date: widget.date,
              description: widget.description,
            ),
          ),
          for (var i = 0; i < widget.commentDiscussions.length; i++)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DiscusStyle(
                profileUrl: widget.commentDiscussions[i]['createdBy']
                    ['profileImage'],
                name: widget.commentDiscussions[i]['createdBy']['name'],
                date: CommonService().getDateInTextTimeStamp(
                    widget.commentDiscussions[i]['date']),
                description: widget.commentDiscussions[i]['description'],
              ),
            ),
        ],
      ),
    );
  }
}
