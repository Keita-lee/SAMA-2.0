import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class TextField3 extends StatefulWidget {
  final String textfieldheader1;
  final String textfieldheader2;
  final String textfieldheader3;

  const TextField3(
      {super.key,
      required this.textfieldheader1,
      required this.textfieldheader2,
      required this.textfieldheader3});

  @override
  State<TextField3> createState() => _TextField3State();
}

class _TextField3State extends State<TextField3> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.textfieldheader1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF6A6A6A),
              ),
            ),
            SizedBox(
                height:
                    8), // Add some space between the title and the text field
            Container(
              width: MyUtility(context).width * 0.195,
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
              widget.textfieldheader2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF6A6A6A),
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: MyUtility(context).width * 0.195,
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
          width: MyUtility(context).width * 0.016,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.textfieldheader3,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF6A6A6A),
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: MyUtility(context).width * 0.195,
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
