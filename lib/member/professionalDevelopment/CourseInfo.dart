import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/professionalDevelopment/professionalDevelopmentMainCon.dart';

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
    return SizedBox(
      width: MyUtility(context).width * 0.68,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Color(0xFF3D3D3D),
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
