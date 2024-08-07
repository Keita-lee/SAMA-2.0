import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class CommunityListItemStyle extends StatefulWidget {
  final String title;
  final String type;
  final List communities;
  final bool isActive;
  final Function()? onTapEdit;
  final Function()? onTapDelete;
  final Color itemColor;

  CommunityListItemStyle({
    super.key,
    required this.title,
    required this.type,
    required this.communities,
    required this.isActive,
    this.onTapEdit,
    this.onTapDelete,
    required this.itemColor,
  });

  @override
  State<CommunityListItemStyle> createState() => _CommunityListItemStyleState();
}

class _CommunityListItemStyleState extends State<CommunityListItemStyle> {
  var communityList = [];
  final List<String> communitiesNames = [
    'A - Student, Intern and Community Service Doctors',
    'B - Employed Private and Public Medical Practitioners',
    'C - Private Practice Medical Practitioners',
    'D - Registrars',
    'E - Specialist',
    'F - Corporate and Self Employed Doctors',
    'G - Research and Academia',
    'H - Retirees'
  ];

  listCommunityItems() {
    for (int i = 0; i < widget.communities.length; i++) {
      switch (widget.communities[i]) {
        case "A - Student, Intern and Community Service Doctors":
          communityList.add("A");
          break;
        case "B - Employed Private and Public Medical Practitioners":
          communityList.add("B");
          break;
        case "C - Private Practice Medical Practitioners":
          communityList.add("C");
          break;
        case "D - Registrars":
          communityList.add("D");
          break;
        case "E - Specialist":
          communityList.add("E");
          break;
        case 'F - Corporate and Self Employed Doctors':
          communityList.add("F");
          break;
        case "A - Student, Intern and Community Service Doctors":
          communityList.add("A");
          break;
        case 'G - Research and Academia':
          communityList.add("G");
          break;
        default:
          communityList.add("H");
      }
    }
  }

  @override
  void initState() {
    listCommunityItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.itemColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: widget.isActive
                        ? Color(0xFF174486)
                        : Colors.grey, // Update this line
                  ),
                  child: Align(
                    alignment: widget.isActive
                        ? Alignment.centerRight
                        : Alignment.centerLeft, // Update this line
                    child: Container(
                      width: 20,
                      height: 20,
                      margin: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MyUtility(context).width * 0.18,
              height: 30,
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF3D3D3D),
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
                width: MyUtility(context).width * 0.28,
                height: 30,
                child: Row(
                  children: [
                    for (int i = 0; i < communityList.length; i++)
                      Text(
                        "${communityList[i]}   ",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF3D3D3D),
                        ),
                      ),
                  ],
                )),
            SizedBox(
              width: MyUtility(context).width * 0.18,
              height: 30,
              child: Text(
                widget.type,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF3D3D3D),
                ),
              ),
            ),
            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: widget.onTapEdit,
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      )),
                  Text('|'),
                  TextButton(
                      onPressed: widget.onTapDelete,
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
