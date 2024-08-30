import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/member/chats/friendRequest/friendRequest.dart';

import '../../components/myutility.dart';
import '../../components/service/commonService.dart';
import '../../components/styleButton.dart';
import 'chatList/chatList.dart';
import 'memberSearch/memberSearch.dart';
import 'memberSearch/ui/chatTextField.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final message = TextEditingController();

  var pageIndex = 0;
  var chatType = "My Chats";
  var memberFriendData = {};
  var friendRequestList = [];
  var friends = [];
  var currentChat = [];

  var memberTalkingToName = "";
  var memberTalkingToProfile = "";
  var memberTalkingToId = "";

  var sendRequest = {
    "id": FirebaseAuth.instance.currentUser!.uid,
    "request": "pending",
    "type": "sender"
  };
  var memberData = {
    "id": FirebaseAuth.instance.currentUser!.uid,
    "friends": [],
    "friendRequest": [],
  };

  getUserDetails() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (doc.exists) {
      setState(() {
        memberData['name'] = '${doc.get("firstName")} ${doc.get("lastName")}';
        memberData['email'] = doc.get("email");
        memberData['profilePic'] = doc.get("profilePic");

        sendRequest['name'] = '${doc.get("firstName")} ${doc.get("lastName")}';
        sendRequest['email'] = doc.get("email");
        sendRequest['profilePic'] = doc.get("profilePic");
        sendRequest['id'] = doc.get("FirebaseAuth.instance.currentUser!.uid");
      });
    }
  }

  checkIfMemberHasFriendAccount() async {
    //
    final data = await FirebaseFirestore.instance
        .collection('chat')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    print(data.id);
    if (data.exists) {
      setState(() {
        friendRequestList.addAll(data.get('friendRequest'));
        friends.addAll(data.get('friends'));
      });
    } else {
      await FirebaseFirestore.instance
          .collection('chat')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(memberData);
    }
  }

  getMemberChat(profilePic, member, id, chat) {
    setState(() {
      currentChat.clear();
      memberTalkingToProfile = profilePic;
      memberTalkingToName = member;
      memberTalkingToId = id;
      currentChat.addAll(chat);
    });
  }

  sendMessage() async {
    // myId FirebaseAuth.instance.currentUser!.uid
    //IdSending to memberTalkingToId

    //Sent message
    final sendMessageData = await FirebaseFirestore.instance
        .collection('chat')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (sendMessageData.exists) {
      var friends = [];
      friends = sendMessageData.get("friends");
      var friendIndex =
          (friends).indexWhere((item) => item["id"] == memberTalkingToId);

      var messageData = {
        "sender": FirebaseAuth.instance.currentUser!.uid,
        "profile": memberData['profilePic'],
        "message": message.text,
        "date": DateTime.now()
      };
      var chat = [];
      chat = friends[friendIndex]["chat"];
      chat.add(messageData);
      friends[friendIndex]["chat"] = chat;

      await FirebaseFirestore.instance
          .collection('chat')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"friends": friends});
    }

    //Recieved message
    final recievedMessageData = await FirebaseFirestore.instance
        .collection('chat')
        .doc(memberTalkingToId)
        .get();

    if (recievedMessageData.exists) {
      var friends = [];
      friends = recievedMessageData.get("friends");
      var friendIndex = (friends).indexWhere(
          (item) => item["id"] == FirebaseAuth.instance.currentUser!.uid);

      var messageData = {
        "sender": FirebaseAuth.instance.currentUser!.uid,
        "message": message.text,
        "date": DateTime.now(),
        "profile": memberData['profilePic'],
      };
      var chat = [];
      chat = friends[friendIndex]["chat"];
      chat.add(messageData);
      friends[friendIndex]["chat"] = chat;

      await FirebaseFirestore.instance
          .collection('chat')
          .doc(memberTalkingToId)
          .update({"friends": friends});
      currentChat.add(messageData);
    }

    setState(() {
      message.text = "";
    });
  }

  @override
  void initState() {
    getUserDetails();
    checkIfMemberHasFriendAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(45.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    width: MyUtility(context).width / 5,
                    height: MyUtility(context).height / 1.5 + 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Wrap(
                            children: [
                              StyleButton(
                                  buttonColor: chatType == "My Chats"
                                      ? Colors.teal
                                      : Colors.grey,
                                  description: "My Chats",
                                  height: 40,
                                  width: 80,
                                  onTap: () {
                                    setState(() {
                                      chatType = "My Chats";
                                    });
                                  }),
                              SizedBox(
                                width: 8,
                              ),
                              StyleButton(
                                  buttonColor: chatType == "Add Member"
                                      ? Colors.teal
                                      : Colors.grey,
                                  description: "Add Member",
                                  height: 40,
                                  width: 80,
                                  onTap: () {
                                    setState(() {
                                      chatType = "Add Member";
                                    });
                                  }),
                            ],
                          ),
                        ),
                        StyleButton(
                            buttonColor: chatType == "Friend Request"
                                ? Colors.teal
                                : Colors.grey,
                            description: "Friend Request",
                            height: 40,
                            width: 80,
                            onTap: () {
                              setState(() {
                                chatType = "Friend Request";
                              });
                            }),
                        Visibility(
                          visible: chatType == "My Chats",
                          child: ChatList(
                              friends: friends, getMemberChat: getMemberChat),
                        ),
                        Visibility(
                          visible: chatType == "Add Member",
                          child: MemberSearch(
                              userDetails: sendRequest,
                              friendRequestList: friendRequestList),
                        ),
                        Visibility(
                          visible: chatType == "Friend Request",
                          child: FriendRequest(
                            friendRequestList: friendRequestList,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: MyUtility(context).width / 1.9,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Visibility(
                          visible: chatType == "My Chats",
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.transparent,
                              ),
                              child: memberTalkingToProfile == ""
                                  ? Container()
                                  : ImageNetwork(
                                      image: memberTalkingToProfile,
                                      fitWeb: BoxFitWeb.contain,
                                      width: 50,
                                      height: 50,
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Visibility(
                          visible: chatType == "My Chats",
                          child: Text(
                            memberTalkingToName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MyUtility(context).width / 1.9,
                    height: MyUtility(context).height / 1.5,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 221, 221, 221),
                      border: Border.all(
                          color: const Color.fromARGB(255, 223, 223, 223)),
                    ),
                    child: Visibility(
                      visible: chatType == "My Chats",
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: MyUtility(context).height / 2.2,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  for (int i = 0; i < currentChat.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: currentChat[i]
                                                    ["sender"] ==
                                                FirebaseAuth
                                                    .instance.currentUser!.uid
                                            ? CrossAxisAlignment.start
                                            : CrossAxisAlignment.end,
                                        mainAxisAlignment: currentChat[i]
                                                    ["sender"] ==
                                                FirebaseAuth
                                                    .instance.currentUser!.uid
                                            ? MainAxisAlignment.start
                                            : MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: currentChat[i]
                                                          ["sender"] ==
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid
                                                  ? MainAxisAlignment.start
                                                  : MainAxisAlignment.end,
                                              children: [
                                                Visibility(
                                                  visible: currentChat[i]
                                                          ["sender"] ==
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      child: ImageNetwork(
                                                        image: currentChat[i]
                                                            ['profile'],
                                                        fitWeb:
                                                            BoxFitWeb.contain,
                                                        width: 50,
                                                        height: 50,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width:
                                                      MyUtility(context).width *
                                                          0.35,
                                                  //  height: 55,
                                                  decoration: BoxDecoration(
                                                      color: currentChat[i]
                                                                  ["sender"] ==
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid
                                                          ? Colors.white
                                                          : Colors.teal,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xFFD1D1D1),
                                                      )),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Text(
                                                      currentChat[i]['message'],
                                                      style: TextStyle(
                                                          color: currentChat[i][
                                                                      "sender"] ==
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid
                                                              ? Colors.black
                                                              : Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: currentChat[i]
                                                          ["sender"] !=
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      child: ImageNetwork(
                                                        image: currentChat[i]
                                                            ['profile'],
                                                        fitWeb:
                                                            BoxFitWeb.contain,
                                                        width: 50,
                                                        height: 50,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: currentChat[i]
                                                        ["sender"] ==
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid
                                                ? MainAxisAlignment.start
                                                : MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                currentChat[i]['date'] != "" ||
                                                        currentChat[i]
                                                                ['date'] !=
                                                            null
                                                    ? CommonService().getTime(
                                                        currentChat[i]['date'])
                                                    : "",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: chatType == "My Chats",
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: MyUtility(context).width / 2.3,
                                    child: ChatTextField(
                                      hintText: 'Type your message here',
                                      textfieldController: message,
                                    ),
                                  ),
                                  StyleButton(
                                      buttonColor: Colors.teal,
                                      description: "SEND",
                                      height: 50,
                                      width: 80,
                                      onTap: () {
                                        sendMessage();
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
