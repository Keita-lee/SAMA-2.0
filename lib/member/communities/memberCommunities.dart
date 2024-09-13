import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/ui/pleaseLogin.dart';
import 'package:sama/member/communities/sections/forums/sections/topics.dart';
import 'package:sama/member/communities/sections/resources/resources.dart';

import '../../components/banner/samaBlueBanner.dart';
import '../../components/myutility.dart';
import 'sections/comTypes/comTypes.dart';
import 'sections/forums/forums.dart';

class MemberCommunities extends StatefulWidget {
  String userType;
  MemberCommunities({super.key, required this.userType});

  @override
  State<MemberCommunities> createState() => _MemberCommunitiesState();
}

class _MemberCommunitiesState extends State<MemberCommunities> {
  int pageIndex = 0;
  String resourceType = "";
  List communityTypeList = [];
//update pageindex and get Id type
  changePageIndex(value, type) {
    setState(() {
      pageIndex = value;
      resourceType = type;
    });
  }

//Call resource type form firebase
  getResourceTypes() async {
    final data =
        await FirebaseFirestore.instance.collection('communityForum').get();

    if (data.docs.isNotEmpty) {
      setState(() {
        communityTypeList.addAll(data.docs);
      });
    }
  }

  @override
  void initState() {
    getResourceTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SamaBlueBanner(pageName: 'COMMUNITIES'),
        SizedBox(
          height: 30,
        ),
        Visibility(
            visible: widget.userType == "NonMember",
            child: Padding(
                padding: isMobile
                    ? EdgeInsets.all(5)
                    : EdgeInsets.symmetric(horizontal: 50),
                child: PleaseLogin(
                  pleaseLoginText:
                      'Access to this content is restricted. Please log in to view or sign up for membership today.',
                ))),
        Visibility(
          visible: widget.userType != "NonMember",
          child: Padding(
            padding: isMobile
                ? EdgeInsets.all(0)
                : const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Visibility(
                    visible: pageIndex == 0 ? true : false,
                    child: ComTypes(changePageIndex: changePageIndex)),
                Visibility(
                    visible: pageIndex == 1 ? true : false,
                    child: Resources(
                      changePageIndex: changePageIndex,
                      resourceType: resourceType,
                    )),
                Visibility(
                    visible: pageIndex == 2 ? true : false,
                    child: Forums(
                        changePageIndex: changePageIndex,
                        resourceType: resourceType,
                        communityTypeList: communityTypeList)),
                Visibility(
                    visible: pageIndex == 3 ? true : false,
                    child: Topics(
                        changePageIndex: changePageIndex,
                        resourceType: resourceType,
                        communityTypeList: communityTypeList)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
