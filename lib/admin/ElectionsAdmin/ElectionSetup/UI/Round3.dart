import 'package:flutter/material.dart';
import 'package:sama/admin/ElectionsAdmin/ElectionSetup/ElectionSetupComp/DatePicker.dart';
import 'package:sama/components/myutility.dart';

class Round3 extends StatefulWidget {
  const Round3({super.key});

  @override
  State<Round3> createState() => _Round3State();
}

class _Round3State extends State<Round3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width * 0.65,
      height: MyUtility(context).height * 0.17,
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
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: MyUtility(context).width * 0.55,
            child: Text(
              'Round 3 - Branch Chairperson',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF3D3D3D),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: MyUtility(context).width * 0.55,
            child: DatePicker(
              dateHeadline: 'Branch Chairperson Voting Dates',
            ),
          ),
        ],
      ),
    );
  }
}
