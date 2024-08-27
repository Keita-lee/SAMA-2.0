import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/communities/sections/forums/sections/otherCommunities.dart';
import 'package:sama/components/CustomSearchBar.dart';
import 'dart:convert';

import 'package:sama/member/communities/sections/forums/sections/yourCommunity.dart'; // For JSON decoding

class Forums extends StatefulWidget {
  String resourceType;
  Function(int, String) changePageIndex;
  List communityTypeList;

  Forums({
    super.key,
    required this.resourceType,
    required this.changePageIndex,
    required this.communityTypeList,
  });

  @override
  State<Forums> createState() => _ForumsState();
}

class _ForumsState extends State<Forums> {
  String youCommunityTitle = "";
  String yourCommunityDescription = "";
  List otherCommunityTypes = [];

  // Variables to hold the latest post information
  String latestPostText = '';
  String latestUserImageUrl = '';
  String latestPostTime = '';
  String latestUserName = '';

  @override
  void initState() {
    var data = widget.resourceType.split(" - ");
    var typeIndex =
        widget.communityTypeList.indexWhere((item) => item["title"] == data[1]);

    youCommunityTitle = widget.communityTypeList[typeIndex]['title'];
    yourCommunityDescription =
        widget.communityTypeList[typeIndex]['description'];

    // Find the latest post data
    var communityDiscussions =
        widget.communityTypeList[typeIndex]['discussions'] ?? [];
    if (communityDiscussions.isNotEmpty) {
      // Correct sorting logic here
      communityDiscussions.sort((a, b) {
        Timestamp dateA = a['date'];
        Timestamp dateB = b['date'];
        return dateB.compareTo(dateA); // Sorting by date descending
      });

      var latestDiscussion = communityDiscussions.first;
      latestPostText = extractPlainText(
          latestDiscussion['description']); // Extract plain text
      latestUserImageUrl = latestDiscussion['createdBy']['profileImage'] ?? '';
      latestPostTime = getDateInTextTimeStamp(
          latestDiscussion['date']); // Use the local method
      latestUserName = latestDiscussion['createdBy']['name'] ?? 'Anonymous';
    }

    for (var i = 0; i < widget.communityTypeList.length; i++) {
      if (youCommunityTitle != widget.communityTypeList[i]['title']) {
        setState(() {
          otherCommunityTypes.add(widget.communityTypeList[i]);
        });
      }
    }
    super.initState();
  }

  // Local method for date formatting
  String getDateInTextTimeStamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return "${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}";
  }

  // Method to extract plain text from JSON string
  String extractPlainText(String jsonString) {
    try {
      var decoded = jsonDecode(jsonString);
      if (decoded is List && decoded.isNotEmpty) {
        var firstInsert = decoded.first['insert'];
        return firstInsert.toString();
      }
    } catch (e) {
      print('Error parsing description: $e');
    }
    return jsonString; // Return original if parsing fails
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*Row(
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
          ),*/
          SizedBox(
            height: 0,
          ),
          YourCommunity(
            resourceType: widget.resourceType,
            communityTypeList: widget.communityTypeList,
            changePageIndex: widget.changePageIndex,
            yourCommunityTitle: youCommunityTitle,
            yourCommunityDescription: yourCommunityDescription,
            postText: latestPostText,
            userImageUrl: latestUserImageUrl,
            postTime: latestPostTime,
            userName: latestUserName,
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
