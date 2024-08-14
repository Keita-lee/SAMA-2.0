import 'package:flutter/material.dart';
import '../ui/forumHeaderStyle.dart';
import '../ui/forumSectionsStyle.dart';

class YourCommunity extends StatefulWidget {
  String resourceType;
  List communityTypeList;
  String yourCommunityTitle;
  String yourCommunityDescription;
  Function(int, String) changePageIndex;

  final String postText;
  final String userImageUrl;
  final String postTime;
  final String userName;

  YourCommunity({
    Key? key,
    required this.resourceType,
    required this.communityTypeList,
    required this.yourCommunityDescription,
    required this.yourCommunityTitle,
    required this.changePageIndex,
    required this.postText, // <- Pass the data here
    required this.userImageUrl,
    required this.postTime,
    required this.userName,
  }) : super(key: key);

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
            postText: widget.postText,
            userImageUrl: widget.userImageUrl,
            postTime: widget.postTime,
            userName: widget.userName,
          ),
        ),
      ],
    );
  }
}
