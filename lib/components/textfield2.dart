import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class TextField2 extends StatefulWidget {
  final String textfieldtitle;
  final String textfieldtitle2;
  

  const TextField2(
      {super.key, required this.textfieldtitle, required this.textfieldtitle2});

  @override
  State<TextField2> createState() => _TextField2State();
}

class _TextField2State extends State<TextField2> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.textfieldtitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF6A6A6A),
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: MyUtility(context).width * 0.3,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: MyUtility(context).width * 0.015,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.textfieldtitle2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF6A6A6A),
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: MyUtility(context).width * 0.3,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
