import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../components/myutility.dart';
import '../../../../components/styleButton.dart';
import '../../../../components/yesNoDialog.dart';

class FriedRequestItemStyle extends StatefulWidget {
  String name;
  String id;
  String type;
  List friendRequest;
  String profilePic;
  String email;
  FriedRequestItemStyle(
      {super.key,
      required this.name,
      required this.id,
      required this.type,
      required this.friendRequest,
      required this.profilePic,
      required this.email});

  @override
  State<FriedRequestItemStyle> createState() => _FriedRequestItemStyleState();
}

class _FriedRequestItemStyleState extends State<FriedRequestItemStyle> {
  String name = "";
  String email = "";
  String profilePic = "";

  acceptFriend() async {
    //user Who Accepted ////////////
    final dataWhoAccepted = await FirebaseFirestore.instance
        .collection('chat')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (dataWhoAccepted.exists) {
      var friends = [];
      var friendDetails = {
        'name': widget.name,
        'email': widget.email,
        'id': widget.id,
        'profilePic': widget.profilePic,
        "chat": []
      };

      setState(() {
        name = dataWhoAccepted.get('name');
        email = dataWhoAccepted.get('email');
        profilePic = dataWhoAccepted.get('profilePic');
      });

      friends.addAll(dataWhoAccepted.get('friends'));

      friends.add(friendDetails);

      await FirebaseFirestore.instance
          .collection('chat')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"friends": friends}); /**/
    }
    //User Who sent request///////////////////
    final dataSentRequest = await FirebaseFirestore.instance
        .collection('chat')
        .doc(widget.id)
        .get();

    if (dataSentRequest.exists) {
      var friends = [];
      var friendDetails = {
        'name': name,
        'email': email,
        'id': FirebaseAuth.instance.currentUser!.uid,
        'profilePic': profilePic,
        "chat": []
      };

      friends.addAll(dataSentRequest.get('friends'));

      friends.add(friendDetails);
      await FirebaseFirestore.instance
          .collection('chat')
          .doc(widget.id)
          .update({"friends": friends});
    }
    await declineFriend();
  }

  declineFriend() async {
    //user Who Accepted ////////////
    final dataWhoAccepted = await FirebaseFirestore.instance
        .collection('chat')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (dataWhoAccepted.exists) {
      var friendReq = [];

      friendReq.addAll(dataWhoAccepted.get('friendRequest'));
      var friendReqIndex =
          (friendReq).indexWhere((item) => item["id"] == widget.id);
      friendReq.removeAt(friendReqIndex);

      await FirebaseFirestore.instance
          .collection('chat')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"friendRequest": friendReq});
    }
    //User Who sent request///////////////////
    final dataSentRequest = await FirebaseFirestore.instance
        .collection('chat')
        .doc(widget.id)
        .get();

    if (dataSentRequest.exists) {
      var friendReq = [];
      friendReq.addAll(dataSentRequest.get('friendRequest'));
      var friendReqIndex = (friendReq).indexWhere(
          (item) => item["id"] == FirebaseAuth.instance.currentUser!.uid);
      friendReq.removeAt(friendReqIndex);

      await FirebaseFirestore.instance
          .collection('chat')
          .doc(widget.id)
          .update({"friendRequest": friendReq});
    }
  }

  //Dialog for password Validate
  Future acceptDeclineFriend(description) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: YesNoDialog(
          description: description,
          closeDialog: () => Navigator.pop(context!),
          callFunction: () {},
        ));
      });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Container(
        width: MyUtility(context).width * 0.62,
        height: 60,
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
            Visibility(
              visible: widget.type != "sender",
              child: Text(
                "Pending",
                style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            Visibility(
              visible: widget.type == "sender",
              child: Column(
                children: [
                  StyleButton(
                      buttonColor: Colors.teal,
                      description: "+",
                      height: 25,
                      width: 40,
                      onTap: () {
                        acceptFriend();
                      }),
                  SizedBox(
                    height: 5,
                  ),
                  StyleButton(
                      buttonColor: Colors.teal,
                      description: "-",
                      height: 25,
                      width: 40,
                      onTap: () {}),
                ],
              ),
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
