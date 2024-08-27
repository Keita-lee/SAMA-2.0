import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../components/myutility.dart';

class CpdQuestionStyle extends StatefulWidget {
  String questionValue;
  VoidCallback editQuestion;
  CpdQuestionStyle(
      {super.key, required this.questionValue, required this.editQuestion});

  @override
  State<CpdQuestionStyle> createState() => _CpdQuestionStyleState();
}

class _CpdQuestionStyleState extends State<CpdQuestionStyle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Container(
        width: MyUtility(context).width * 0.62,
        height: 55,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color(0xFFD1D1D1),
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: MyUtility(context).width * 0.52,
                child: Text(
                  widget.questionValue,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    widget.editQuestion();
                  },
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  )),
              Text('|'),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
