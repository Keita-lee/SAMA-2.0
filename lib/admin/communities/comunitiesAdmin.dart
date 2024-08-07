import 'package:flutter/material.dart';
import 'package:sama/admin/communities/sections/add/addText.dart';

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
    'A - Student, Inter and Community Service Doctors',
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

//change page and update id
  changePageIndex(value, id) {
    setState(() {
      pageIndex = value;
      communityId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: pageIndex == 0 ? true : false,
          child: Center(
            child: SizedBox(
              width: MyUtility(context).width * 0.80,
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
                        children: [
                          Container(
                            width: 200,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 51, 51, 51),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Center(
                              child: TextFormField(
                                controller: TextEditingController(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          StyleButton(
                            description: "Search",
                            height: 55,
                            width: 160,
                            onTap: () {},
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
                              width: MyUtility(context).width / 4,
                              hintText: 'Filter by Community',
                              textStyle: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF3D3D3D),
                                fontWeight: FontWeight.bold,
                              ),
                              enableFilter: true,
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
                    CommunityList(changePageIndex: changePageIndex),
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
    );
  }
}
