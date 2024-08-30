import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

import '../../../../components/myutility.dart';
import '../../../../components/service/commonService.dart';
import '../../../../components/styleButton.dart';
import '../../../../components/yesNoDialog.dart';

class ChatUiStyle extends StatefulWidget {
  String name;
  String profilePic;
  String id;
  Color customColor;
  Color customText;
  List chat;
  ChatUiStyle(
      {super.key,
      required this.name,
      required this.id,
      required this.profilePic,
      required this.customColor,
      required this.customText,
      required this.chat});

  @override
  State<ChatUiStyle> createState() => _ChatUiStyleState();
}

class _ChatUiStyleState extends State<ChatUiStyle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Container(
          width: MyUtility(context).width * 0.62,
          height: 55,
          decoration: BoxDecoration(
              color: widget.customColor,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Color(0xFFD1D1D1),
              )),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.transparent,
                      ),
                      child: ImageNetwork(
                        image: widget.profilePic,
                        fitWeb: BoxFitWeb.contain,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                color: widget.customText,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            child: Text(
                              CommonService().getTime(
                                  widget.chat[widget.chat.length - 1]['date']),
                              style: TextStyle(
                                color: widget.customText,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            widget.chat[widget.chat.length - 1]['message'],
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
