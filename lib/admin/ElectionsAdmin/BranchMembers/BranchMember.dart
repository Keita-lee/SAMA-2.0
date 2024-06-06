import 'package:flutter/material.dart';
import 'package:sama/admin/ElectionsAdmin/BranchMembers/BranchMemberComp/BoardMember.dart';
import 'package:sama/components/myutility.dart';

final List<String> memberNames = [
  'Branch Director',
  'Board Member 1',
  'Board Member 2',
  'Board Member 3',
  'Board Member 4',
  'Board Member 5',
  'Board Member 6',
  'Board Member 7',
];

class BranchMembers extends StatefulWidget {
  const BranchMembers({super.key});

  @override
  State<BranchMembers> createState() => _BranchMembersState();
}

class _BranchMembersState extends State<BranchMembers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width * 0.75,
      height: MyUtility(context).height * 0.85,
      child: Column(
        children: [
          SizedBox(
            width: MyUtility(context).width * 0.65  ,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'Search for Board Members',
                  style: TextStyle(
                    fontSize: 32,
                    color: Color(0xFF3D3D3D),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Container(
              width: MyUtility(context).width * 0.65,
              height: MyUtility(context).height * 0.1,
              decoration: ShapeDecoration(
                color: Color(0xFFFFF5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Search for Board Members',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF3D3D3D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: MyUtility(context).width * 0.65,
              child: ListView.builder(
                itemCount: memberNames.length,
                itemBuilder: (context, index) {
                  Color buttonColor = index == 0
                      ? Color(0xFFFFCD29)
                      : Color.fromARGB(255, 8, 55, 145);
                  return BoardMember(
                    name: memberNames[index],
                    buttonColor: buttonColor,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
