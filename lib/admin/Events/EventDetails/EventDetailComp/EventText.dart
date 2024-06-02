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
    return SizedBox(
      height: MyUtility(context).height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Text(
                'Title: ',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3D3D3D),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3D3D3D),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Date: ',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3D3D3D),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3D3D3D),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Time: ',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3D3D3D),
                  fontWeight: FontWeight.bold,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: timeFrom,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF3D3D3D),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: ' - ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF3D3D3D),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: timeTill,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF3D3D3D),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
