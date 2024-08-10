import 'package:flutter/material.dart';
import 'package:sama/member/communities/sections/forums/ui/forumHeaderStyle.dart';

import '../ui/forumSectionsStyle.dart';

class YourCommunity extends StatefulWidget {
  String resourceType;
  List communityTypeList;
  String yourCommunityTitle;
  String yourCommunityDescription;
  Function(int, String) changePageIndex;
  YourCommunity(
      {super.key,
      required this.resourceType,
      required this.communityTypeList,
      required this.yourCommunityDescription,
      required this.yourCommunityTitle,
      required this.changePageIndex});

  @override
  State<YourCommunity> createState() => _YourCommunityState();
}

class _YourCommunityState extends State<YourCommunity> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ForumHeaderStyle(title: "Your Community"),
        InkWell(
          onTap: () {
            widget.changePageIndex(3, widget.resourceType);
          },
          child: ForumSectionTypeStyle(
            title: widget.yourCommunityTitle,
            description: widget.yourCommunityDescription,
          ),
        ),
      ],
    );
  }
}
