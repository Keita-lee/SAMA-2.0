import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../components/myutility.dart';
import '../../../components/profileTextField.dart';
import 'ui/meberSearchItemStyle.dart';

class MemberSearch extends StatefulWidget {
  Map userDetails;
  List friendRequestList;
  MemberSearch(
      {super.key, required this.userDetails, required this.friendRequestList});

  @override
  State<MemberSearch> createState() => _MemberSearchState();
}

class _MemberSearchState extends State<MemberSearch> {
  final search = TextEditingController();
  var members = [];

  getAllMembers() async {
    final doc = await FirebaseFirestore.instance.collection('users').get();
    if (doc.docs.isNotEmpty) {
      setState(() {
        members.addAll(doc.docs);
      });
    }
  }

  checkIfInFriendRequestList(email) {
    var friendIndex =
        (widget.friendRequestList).indexWhere((item) => item["email"] == email);

    if (friendIndex == -1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    getAllMembers();
    super.initState();
  }

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
                ProfileTextField(
                  customSize: 300,
                  textFieldType: '',
                  //Controller here
                  textfieldController: search,
                  ////
                  hintText: 'Search Member',
                ),
                for (int i = 0; i < members.length; i++)
                  Visibility(
                    visible: checkIfInFriendRequestList(members[i]['email']),
                    child: MemberSearchItemStyle(
                      friendRequestList: widget.friendRequestList,
                      userDetails: widget.userDetails,
                      name:
                          '${members[i]['firstName']} ${members[i]['lastName']}',
                      friendAdded: false,
                      id: members[i]['id'],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
