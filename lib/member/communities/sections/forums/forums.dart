import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'sections/otherCommunities.dart';
import 'sections/yourCommunity.dart';

class Forums extends StatefulWidget {
  String resourceType;
  Function(int, String) changePageIndex;
  List communityTypeList;
  Forums(
      {super.key,
      required this.resourceType,
      required this.changePageIndex,
      required this.communityTypeList});
  @override
  State<Forums> createState() => _ForumsState();
}

class _ForumsState extends State<Forums> {
  String youCommunityTitle = "";
  String yourCommunityDescription = "";
  List otherCommunityTypes = [];

  @override
  void initState() {
    var data = widget.resourceType.split(" - ");

    var typeIndex = (widget.communityTypeList)
        .indexWhere((item) => item["title"] == data[1]);

    youCommunityTitle = widget.communityTypeList[typeIndex]['title'];
    yourCommunityDescription =
        widget.communityTypeList[typeIndex]['description'];

    for (var i = 0; i < widget.communityTypeList.length; i++) {
      if (youCommunityTitle != widget.communityTypeList[i]['title']) {
        setState(() {
          otherCommunityTypes.add(widget.communityTypeList[i]);
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Forums',
                style: const TextStyle(
                    fontSize: 28,
                    color: Color.fromARGB(255, 8, 55, 145),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          YourCommunity(
            resourceType: widget.resourceType,
            communityTypeList: widget.communityTypeList,
            changePageIndex: widget.changePageIndex,
            yourCommunityTitle: youCommunityTitle,
            yourCommunityDescription: yourCommunityDescription,
          ),
          SizedBox(
            height: 25,
          ),
          OtherCommunities(
            otherCommunityTypes: otherCommunityTypes,
            changePageIndex: widget.changePageIndex,
            resourceType: widget.resourceType,
          ),
        ],
      ),
    );
  }
}
