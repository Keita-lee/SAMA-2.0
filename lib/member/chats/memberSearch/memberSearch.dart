import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  checkIfInFriendRequestList(email, firstname, lastname) {
    var friendIndex =
        (widget.friendRequestList).indexWhere((item) => item["email"] == email);

    if (friendIndex == -1) {
      return true;
    } else {
      if (search.text.contains(email) ||
          search.text.contains(firstname) ||
          search.text.contains(lastname)) {
        return true;
      } else {
        return false;
      }
    }
  }

  searchFunction() {}

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
                Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      maxLines: 1,
                      controller: search,
                      style: GoogleFonts.openSans(
                        color: Color(0xFF6A6A6A),
                        fontSize: 16,
                        //fontWeight: FontWeight.normal,
                        fontWeight: FontWeight.w500,
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.only(left: 12.0),
                        border: InputBorder.none,
                        hintText: "Search for members",
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 199, 199, 199),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                for (int i = 0; i < members.length; i++)
                  Visibility(
                    visible: checkIfInFriendRequestList(members[i]['email'],
                        members[i]['firstName'], members[i]['lastName']),
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
