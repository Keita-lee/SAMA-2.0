import 'package:flutter/material.dart';
import 'package:sama/member/communities/sections/resources/resources.dart';

import 'sections/comTypes/comTypes.dart';

class MemberCommunities extends StatefulWidget {
  const MemberCommunities({super.key});

  @override
  State<MemberCommunities> createState() => _MemberCommunitiesState();
}

class _MemberCommunitiesState extends State<MemberCommunities> {
  int pageIndex = 0;
  String resourceType = "";
//update pageindex and get Id type
  changePageIndex(value, type) {
    setState(() {
      pageIndex = value;
      resourceType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Communities',
          style: const TextStyle(
              fontSize: 35,
              color: Color.fromARGB(255, 8, 55, 145),
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: 25,
        ),
        Visibility(
            visible: pageIndex == 0 ? true : false,
            child: ComTypes(changePageIndex: changePageIndex)),
        Visibility(
            visible: pageIndex == 1 ? true : false,
            child: Resources(
              changePageIndex: changePageIndex,
              resourceType: resourceType,
            )),
      ],
    );
  }
}
