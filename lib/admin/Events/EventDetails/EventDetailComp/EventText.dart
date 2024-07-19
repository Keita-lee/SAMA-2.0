import 'package:flutter/material.dart';
import 'package:sama/components/utility.dart';

class EventText extends StatelessWidget {
  final String title;
  final String date;
  final String endDate;
  final String timeFrom;
  final String timeTill;
  const EventText(
      {super.key,
      required this.title,
      required this.date,
      required this.endDate,
      required this.timeFrom,
      required this.timeTill});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Title: ' + title,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3D3D3D),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Start Date: ' + date,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3D3D3D),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'End Date: ' + endDate,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3D3D3D),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            'Time: ' + timeFrom + ' - ' + timeTill,
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF3D3D3D),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
