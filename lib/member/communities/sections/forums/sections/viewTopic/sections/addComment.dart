import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../../../../../components/myutility.dart';
import '../../../../../../../components/profileTextField.dart';
import '../../../../../../../components/styleButton.dart';
import '../../../ui/forumHeaderStyle.dart';

class AddComment extends StatefulWidget {
  Function(int) changePageIndex;
  String communityId;
  List communityDiscussion;
  List commentDiscussions;
  int discussionIndex;
  String subject;

  AddComment(
      {super.key,
      required this.changePageIndex,
      required this.communityId,
      required this.communityDiscussion,
      required this.commentDiscussions,
      required this.discussionIndex,
      required this.subject});

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  //var
  var name = "";
  var profileImage = "";

  //Controllers
  final subject = TextEditingController();

  var myJSON;
  QuillController quillController = QuillController.basic();

  addTopicToDatabase() {
    var topicData = {
      "date": Timestamp.now(),
      "description": jsonEncode(quillController.document.toDelta().toJson()),
      "createdBy": {
        "name": name,
        "id": FirebaseAuth.instance.currentUser!.uid,
        "profileImage": profileImage
      }
    };
/**/
    widget.commentDiscussions.add(topicData);
    var typeIndex = (widget.communityDiscussion)
        .indexWhere((item) => item["subject"] == widget.subject);

    widget.communityDiscussion[typeIndex]['discussions'] =
        widget.commentDiscussions;

    FirebaseFirestore.instance
        .collection('communityForum')
        .doc(widget.communityId)
        .update({"discussions": widget.communityDiscussion}).whenComplete(
            widget.changePageIndex(0)); /**/
  }

  getUserDetails() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (doc.exists) {
      setState(() {
        name = '${doc.get("firstName")} ${doc.get("lastName")}';
        profileImage = doc.get("profilePic");
      });
    }
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ForumHeaderStyle(title: "Post Reply:"),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MyUtility(context).width / 1.3,
            child: QuillToolbar.simple(
              configurations: QuillSimpleToolbarConfigurations(
                controller: quillController,
                sharedConfigurations: const QuillSharedConfigurations(),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MyUtility(context).width / 1.3,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: QuillEditor.basic(
            configurations: QuillEditorConfigurations(
              padding: EdgeInsets.all(8.0),
              controller: quillController,
              sharedConfigurations: const QuillSharedConfigurations(),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            StyleButton(
                description: "Cancel",
                height: 55,
                width: 125,
                onTap: () {
                  widget.changePageIndex(0);
                }),
            SizedBox(
              width: 15,
            ),
            StyleButton(
                description: "Submit",
                height: 55,
                width: 125,
                onTap: () {
                  addTopicToDatabase();
                })
          ],
        )
      ],
    );
  }
}
