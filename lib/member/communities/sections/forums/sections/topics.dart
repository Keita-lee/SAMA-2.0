import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/utility.dart';
import 'package:sama/member/communities/sections/forums/sections/viewTopic/viewTopic.dart';

import '../../../../../components/service/commonService.dart';
import '../../../../../components/styleButton.dart';
import '../ui/forumHeaderStyle.dart';
import '../ui/forumSectionsStyle.dart';
import 'addTopic.dart';

class Topics extends StatefulWidget {
  String resourceType;
  Function(int, String) changePageIndex;
  List communityTypeList;
  Topics(
      {super.key,
      required this.resourceType,
      required this.changePageIndex,
      required this.communityTypeList});

  @override
  State<Topics> createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  String communityTitle = "";
  String communityId = "";
  List communityDiscussion = [];
  List commentDiscussions = [];
  var pageIndex = 0;
  int discussionIndex = 0;
  String title = "";
  String description = "";
  String date = "";
  var createdBy = {};
  List discussions = [];
  String subject = "";

  //update pageindex and get Id type
  changePageIndex(value) {
    setState(() {
      pageIndex = value;
    });
  }

  @override
  void initState() {
    var data = widget.resourceType.split(" - ");

    var typeIndex = (widget.communityTypeList)
        .indexWhere((item) => item["title"] == data[1]);

    communityTitle = widget.communityTypeList[typeIndex]['title'];
    communityId = widget.communityTypeList[typeIndex]['id'];
    communityDiscussion
        .addAll(widget.communityTypeList[typeIndex]['discussions']);
    communityDiscussion.sort((b, a) => a["date"].compareTo(b["date"]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            communityTitle,
            style: TextStyle(
                fontSize: 32,
                color: Colors.grey[800],
                fontWeight: FontWeight.normal),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Visibility(
          visible: pageIndex == 0 ? true : false,
          child: SizedBox(
            width: MyUtility(context).width / 1.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                StyleButton(
                    description: "New Topic",
                    height: 55,
                    width: 125,
                    onTap: () {
                      changePageIndex(1);
                    })
              ],
            ),
          ),
        ),
        Visibility(
            visible: pageIndex == 1 ? true : false,
            child: AddTopic(
                changePageIndex: changePageIndex,
                communityId: communityId,
                communityDiscussion: communityDiscussion)),
        Visibility(
            visible: pageIndex == 2 ? true : false,
            child: ViewTopic(
                title: title,
                description: description,
                date: date,
                createdBy: createdBy,
                discussions: communityDiscussion,
                commentDiscussions: commentDiscussions,
                discussionIndex: discussionIndex,
                communityId: communityId,
                subject: subject)),
        SizedBox(
          height: 15,
        ),
        Visibility(
          visible: pageIndex == 0 ? true : false,
          child: Column(
            children: [
              ForumHeaderStyle(title: "Topics"),
              for (var i = 0; i < communityDiscussion.length; i++)
                InkWell(
                  onTap: () {
                    setState(() {
                      title = communityDiscussion[i]['subject'];
                      description = communityDiscussion[i]['description'];
                      createdBy = communityDiscussion[i]['createdBy'];
                      commentDiscussions =
                          communityDiscussion[i]['discussions'];

                      date = CommonService().getDateInTextTimeStamp(
                          communityDiscussion[i]['date']);

                      changePageIndex(2);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ForumSectionTypeStyle(
                      title: communityDiscussion[i]['subject'],
                      description: communityDiscussion[i]['createdBy']['name'],
                      postText: CommonService().getDateInTextTimeStamp(
                          communityDiscussion[i]['date']),
                      userImageUrl: communityDiscussion[i]['createdBy']
                              ['profileImage'] ??
                          '',
                      postTime: communityDiscussion[i]['createdBy']['name'] ??
                          'Anonymous',
                      userName: '',
                    ),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
