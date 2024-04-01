import 'package:flutter/material.dart';
import 'package:sama/components/NewsContainer.dart';
import 'package:sama/components/myutility.dart';

class CenterOfExcellence extends StatefulWidget {
  const CenterOfExcellence({super.key});

  @override
  State<CenterOfExcellence> createState() => _CenterOfExcellenceState();
}

class _CenterOfExcellenceState extends State<CenterOfExcellence> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Center of Excellence',
            style: TextStyle(
                fontSize: 32,
                color: Color(0xFF3D3D3D),
                fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: MyUtility(context).height * 0.05,
          ),
          Row(
            children: [
              NewsContainer(
                  image: 'images/news1.jpg',
                  category: 'Category ',
                  date: '13 March 2024',
                  header: 'Header',
                  onPressed: () {}),
              SizedBox(
                width: MyUtility(context).width * 0.025,
              ),
              NewsContainer(
                  image: 'images/news2.jpg',
                  category: 'Med-e-mail',
                  date: '13 March 2024',
                  header:
                      'WEBINAR | JUDASA - Reviving a Junior Doctors Movement',
                  onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
