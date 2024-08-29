import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/member/chats/friendRequest/ui/friendRequestItemStyle.dart';

import '../../../components/myutility.dart';
import '../memberSearch/ui/meberSearchItemStyle.dart';

class FriendRequest extends StatefulWidget {
  List friendRequestList;
  FriendRequest({super.key, required this.friendRequestList});

  @override
  State<FriendRequest> createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MyUtility(context).height / 1.8,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < widget.friendRequestList.length; i++)
                  FriedRequestItemStyle(
                      name: '${widget.friendRequestList[i]['name']}',
                      type: widget.friendRequestList[i]['type'],
                      id: widget.friendRequestList[i]['id'],
                      profilePic: widget.friendRequestList[i]['profilePic'],
                      email: widget.friendRequestList[i]['email'],
                      friendRequest: widget.friendRequestList),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
