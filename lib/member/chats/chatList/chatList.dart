import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../components/myutility.dart';
import 'ui/chatUiStyle.dart';

class ChatList extends StatefulWidget {
  List friends;
  Function(String, String, String, List) getMemberChat;
  ChatList({super.key, required this.friends, required this.getMemberChat});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  String friendSelected = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MyUtility(context).height / 1.8,
        child: Container(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chats",
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    for (int i = 0; i < widget.friends.length; i++)
                      InkWell(
                        onTap: () {
                          setState(() {
                            friendSelected = widget.friends[i]['id'];
                            widget.getMemberChat(
                              widget.friends[i]['profilePic'],
                              widget.friends[i]['name'],
                              widget.friends[i]['id'],
                              widget.friends[i]['chat'],
                            );
                          });
                        },
                        child: ChatUiStyle(
                          name: widget.friends[i]['name'],
                          chat: widget.friends[i]['chat'],
                          id: widget.friends[i]['id'],
                          profilePic: widget.friends[i]['profilePic'],
                          customColor: friendSelected != widget.friends[i]['id']
                              ? Colors.white
                              : Colors.teal,
                          customText: friendSelected != widget.friends[i]['id']
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                  ],
                )))));
  }
}
