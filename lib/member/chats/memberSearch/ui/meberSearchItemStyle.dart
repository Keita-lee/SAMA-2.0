import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../components/myutility.dart';
import '../../../../components/styleButton.dart';
import '../../../../components/yesNoDialog.dart';

class MemberSearchItemStyle extends StatefulWidget {
  String name;
  bool friendAdded;
  String id;
  Map userDetails;
  List friendRequestList;
  MemberSearchItemStyle(
      {super.key,
      required this.name,
      required this.friendAdded,
      required this.id,
      required this.userDetails,
      required this.friendRequestList});

  @override
  State<MemberSearchItemStyle> createState() => _MemberSearchItemStyleState();
}

class _MemberSearchItemStyleState extends State<MemberSearchItemStyle> {
  String name = "";
  String profileImage = "";
  String email = "";
  var memberData = {
    "id": "",
    "friends": [],
    "friendRequest": [],
    "type": "receiver"
  };
  var sendRequest = {"request": "pending", "type": "requestSent"};
  @override
  Widget build(BuildContext context) {
    updateFriendRequestList() async {
      widget.friendRequestList.add(sendRequest);

      final doc = await FirebaseFirestore.instance
          .collection('chat')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"friendRequest": widget.friendRequestList});
    }

    getUserDetails() async {
      List friendRequestData = [];
      friendRequestData.add(widget.userDetails);
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.id)
          .get();

      if (doc.exists) {
        setState(() {
          memberData['name'] = '${doc.get("firstName")} ${doc.get("lastName")}';
          memberData['email'] = doc.get("email");
          memberData['id'] = doc.get("id");
          memberData['profilePic'] = doc.get("profilePic");
          memberData['friendRequest'] = friendRequestData;

          sendRequest['id'] = widget.id;
          sendRequest['name'] =
              '${doc.get("firstName")} ${doc.get("lastName")}';
          sendRequest['email'] = doc.get("email");
          sendRequest['profilePic'] = doc.get("profilePic");
          sendRequest['id'] = doc.get("id");
        });
        updateFriendRequestList();
      }
    }

    checkIfMemberHasFriendAccount() async {
      await getUserDetails();
      final data = await FirebaseFirestore.instance
          .collection('chat')
          .doc(widget.id)
          .get();

      if (!data.exists) {
        await FirebaseFirestore.instance
            .collection('chat')
            .doc(widget.id)
            .set(memberData);
      } else {
        var friendReq = [];
        final memberSelectData = await FirebaseFirestore.instance
            .collection('chat')
            .doc(widget.id)
            .get();

        if (memberSelectData.exists) {
          friendReq = memberSelectData.get("friendRequest");

          friendReq.add(widget.userDetails);
          final memberSelectData2 = await FirebaseFirestore.instance
              .collection('chat')
              .doc(widget.id)
              .update({"friendRequest": friendReq});
        }
      }
    }

    //Dialog for password Validate
    Future addFriendPopup() => showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: YesNoDialog(
            description: "Send ${widget.name} Friend Request",
            closeDialog: () => Navigator.pop(context!),
            callFunction: checkIfMemberHasFriendAccount,
          ));
        });

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Container(
        width: MyUtility(context).width * 0.62,
        height: 55,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color(0xFFD1D1D1),
            )),
        child: Row(
          children: [
            SizedBox(
              width: 5,
            ),
            SizedBox(
              child: Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Spacer(),
            StyleButton(
                buttonColor: Colors.teal,
                description: "Add",
                height: 40,
                width: 40,
                onTap: () {
                  addFriendPopup();
                }),
            SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
