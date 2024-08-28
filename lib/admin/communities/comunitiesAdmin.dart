import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/communities/sections/add/addText.dart';
import 'package:sama/components/CustomSearchBar.dart';

import '../../components/myutility.dart';
import '../../components/styleButton.dart';
import 'sections/add/addPdf.dart';
import 'sections/communityList/communityList.dart';
import 'sections/communityList/ui/communityListHeader.dart';

class CommunitiesAdmin extends StatefulWidget {
  const CommunitiesAdmin({super.key});

  @override
  State<CommunitiesAdmin> createState() => _CommunitiesAdminState();
}

class _CommunitiesAdminState extends State<CommunitiesAdmin> {
  final List<String> communitiesNames = [
    'Show All',
    'A - Student, Intern and Community Service Doctors',
    'B - Employed Private and Public Medical Practitioners',
    'C - Private Practice Medical Practitioners',
    'D - Registrars',
    'E - Specialist',
    'F - Corporate and Self Employed Doctors',
    'G - Research and Academia',
    'H - Retirees'
  ];
  //var
  final GlobalKey _menuKey = GlobalKey();
  var pageIndex = 0;
  var communityId = "";
  var searchText = "";
  var querySearchText = "";
  TextEditingController selectedFilter = TextEditingController();
  bool isLoading = true;
  List communitiesList = [];
  final _firebase = FirebaseFirestore.instance;

  void onSearchChanged(String text) {
    setState(() {
      searchText = text;
    });
  }

  void onSearch() {
    setState(() {
      querySearchText = searchText;
    });
  }

//change page and update id
  changePageIndex(value, id) {
    setState(() {
      pageIndex = value;
      communityId = id;
    });
  }

  @override
  void initState() {
    setState(() {
      selectedFilter.text = communitiesNames[0];
    });
    _getCommunitiesList();
    super.initState();
  }

  void _getCommunitiesList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> communitiesSnapshot =
          await _firebase.collection('communities').get();

      if (communitiesSnapshot.docs.isEmpty) return;

      setState(() {
        communitiesList = communitiesSnapshot.docs
            .map((community) => community.data())
            .toList();
      });

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('error fetching communities: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0),
      child: Column(
        children: [
          Visibility(
            visible: pageIndex == 0 ? true : false,
            child: Center(
              child: SizedBox(
                width: MyUtility(context).width * 0.8,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Communities - List Resources',
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          PopupMenuButton(
                              key: _menuKey,
                              onSelected: (value) {
                                if (value == "pdf") {
                                  changePageIndex(1, "");
                                } else if (value == "text") {
                                  changePageIndex(2, "");
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry>[
                                    PopupMenuItem(
                                      height: 35,
                                      value: "pdf",
                                      child: const Text(
                                        'PDF',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Color.fromARGB(255, 85, 85, 85),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      height: 35,
                                      value: "text",
                                      child: const Text(
                                        'TEXT',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Color.fromARGB(255, 85, 85, 85),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                              child: StyleButton(
                                  description: "+ Add new",
                                  height: 55,
                                  width: 125,
                                  onTap: () {
                                    dynamic state = _menuKey.currentState;
                                    state.showButtonMenu();
                                  }))
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomSearchBar(
                              onSearch: onSearchChanged,
                              width: 220,
                              backgroundColor: Colors.white,
                              borderColor: Colors.black,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            StyleButton(
                              description: "Search",
                              height: 55,
                              width: 160,
                              onTap: onSearch,
                            ),
                            Spacer(),
                            Container(
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: DropdownMenu(
                                onSelected: (value) => {
                                  setState(() {
                                    selectedFilter.text =
                                        value ?? communitiesNames[0];
                                  })
                                },
                                controller: selectedFilter,
                                width: MyUtility(context).width / 4,
                                hintText: 'Filter by Community',
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF3D3D3D),
                                  fontWeight: FontWeight.bold,
                                ),
                                dropdownMenuEntries: communitiesNames
                                    .map(
                                      (communityName) => DropdownMenuEntry(
                                        value: communityName,
                                        label: communityName,
                                      ),
                                    )
                                    .toList(),
                              ),
                            )
                          ]),
                      CommunityListHeader(),
                      CommunityList(
                        changePageIndex: changePageIndex,
                        communitiesList: communitiesList,
                        searchText: querySearchText,
                        communityFilter: selectedFilter.text,
                        waiting: isLoading,
                      ),
                    ]),
              ),
            ),
          ),
          Visibility(
            visible: pageIndex == 1 ? true : false,
            child: AddPdf(
              pdfId: communityId,
              changePageIndex: changePageIndex,
            ),
          ),
          Visibility(
            visible: pageIndex == 2 ? true : false,
            child: AddText(
              textId: communityId,
              changePageIndex: changePageIndex,
            ),
          ),
        ],
      ),
    );
  }
}
