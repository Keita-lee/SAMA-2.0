import 'package:flutter/material.dart';

import '../../../../../components/myutility.dart';
import '../ui/forumHeaderStyle.dart';
import '../ui/forumSectionsStyle.dart';

class OtherCommunities extends StatefulWidget {
  List otherCommunityTypes;
  String resourceType;
  Function(int, String) changePageIndex;
  OtherCommunities(
      {super.key,
      required this.otherCommunityTypes,
      required this.changePageIndex,
      required this.resourceType});

  @override
  State<OtherCommunities> createState() => _OtherCommunitiesState();
}

class _OtherCommunitiesState extends State<OtherCommunities> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return Column(
      children: [
        ForumHeaderStyle(title: "Other Community"),
        for (var i = 0; i < widget.otherCommunityTypes.length; i++)
          InkWell(
              onTap: () {
                widget.changePageIndex(3, widget.resourceType);
              },
              child: Padding(
                padding:  EdgeInsets.only(bottom: isMobile ? 10 : 0),
                child: ForumSectionTypeStyle(
                  title: widget.otherCommunityTypes[i]['title'],
                  description: widget.otherCommunityTypes[i]['description'],
                  postText: '',
                  userImageUrl: '',
                  postTime: '',
                  userName: '',
                ),
              ))
      ],
    );
  }
}
