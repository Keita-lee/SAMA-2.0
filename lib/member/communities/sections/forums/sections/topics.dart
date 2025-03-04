import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/CustomSearchBar.dart';
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
  String _searchText = "";

  void _onSearch(String value) {
    setState(() {
      _searchText = value;
    });
  }

  //update pageindex and get Id type
  changePageIndex(value) {
    setState(() {
      pageIndex = value;
    });
  }

  @override
  void initState() {
    setState(() {
      var data = widget.resourceType.split(" - ");

      var typeIndex = (widget.communityTypeList)
          .indexWhere((item) => item["title"] == data[1]);

      communityTitle = widget.communityTypeList[typeIndex]['title'];
      communityId = widget.communityTypeList[typeIndex]['id'];
      communityDiscussion
          .addAll(widget.communityTypeList[typeIndex]['discussions']);
      communityDiscussion.sort((b, a) => a["date"].compareTo(b["date"]));
    });

    super.initState();
  }

  List get _filteredDiscussions {
    if (_searchText.isEmpty) {
      return communityDiscussion;
    } else {
      return communityDiscussion
          .where((item) =>
              item['subject'].toLowerCase().contains(_searchText.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
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
            width: isMobile
                ? MyUtility(context).width
                : MyUtility(context).width * 0.77,
            child: Row(
              mainAxisAlignment: isMobile
                  ? MainAxisAlignment.spaceEvenly
                  : MainAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: isMobile
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.end,
                  children: [
                    CustomSearchBar(
                      onSearch: _onSearch,
                      width: 250,
                    ),
                  ],
                ),
                SizedBox(
                  width: 20.0,
                ),
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
              for (var i = 0; i < _filteredDiscussions.length; i++)
                InkWell(
                  onTap: () {
                    setState(() {
                      title = _filteredDiscussions[i]['subject'];
                      description = _filteredDiscussions[i]['description'];
                      createdBy = _filteredDiscussions[i]['createdBy'];
                      commentDiscussions =
                          _filteredDiscussions[i]['discussions'];

                      date = CommonService().getDateInTextTimeStamp(
                          _filteredDiscussions[i]['date']);

                      changePageIndex(2);
                    });
                  },
                  child: Padding(
                    padding: MediaQuery.of(context).size.width < 600
                        ? EdgeInsets.zero
                        : const EdgeInsets.all(8),
                    child: ForumSectionTypeStyle(
                      title: _filteredDiscussions[i]['subject'],
                      description: _filteredDiscussions[i]['createdBy']['name'],
                      postText: CommonService().getDateInTextTimeStamp(
                          _filteredDiscussions[i]['date']),
                      userImageUrl: _filteredDiscussions[i]['createdBy']
                              ['profileImage'] ??
                          '',
                      postTime: _filteredDiscussions[i]['createdBy']['name'] ??
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
