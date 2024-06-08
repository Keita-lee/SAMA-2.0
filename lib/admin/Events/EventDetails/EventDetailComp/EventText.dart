import 'package:flutter/material.dart';
import 'package:sama/components/utility.dart';

class EventText extends StatelessWidget {
  final String title;
  final String date;
  final String timeFrom;
  final String timeTill;
  const EventText(
      {super.key,
      required this.title,
      required this.date,
      required this.timeFrom,
      required this.timeTill});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Title: ' + title,
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF3D3D3D),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Date: ' + date,
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF3D3D3D),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Time: ' + timeFrom + ' - ' + timeTill,
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF3D3D3D),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
