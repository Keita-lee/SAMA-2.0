import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/professionalDevelopment/professionalDevelopmentMainCon.dart';
import 'package:sama/member/professionalDevelopment/ui/courseInfoContainer.dart';

class CourseInfo extends StatefulWidget {
  final CourseModel course;
  const CourseInfo({super.key, required this.course});

  @override
  State<CourseInfo> createState() => _CourseInfoState();
}

class _CourseInfoState extends State<CourseInfo> {
  @override
  Widget build(BuildContext context) {
    String title = widget.course.title;
    return Container(
      width: MyUtility(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Color(0xFF3D3D3D),
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          /**/ CourseInfoContainer(
            isAccessed: false,
            accreditationOrg: 'Health Professions Council of South Africa',
            accreditationId: 'MDB015/MPDP/038/206',
            accreditationPoints: '3 Clinical',
            courseImage: 'images/sama_logo.png',
            allowedAttempts: '2',
            passRate: '70',
            userType: 'NonMember',
            nonMemberPrice: 'R1500 inc VAT',
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            'Introduction',
            style: TextStyle(
                color: Color(0xFF3D3D3D),
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
