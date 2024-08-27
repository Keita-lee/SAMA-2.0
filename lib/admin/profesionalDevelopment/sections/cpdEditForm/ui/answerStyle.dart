import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../components/myutility.dart';

class AnswerStyle extends StatefulWidget {
  String answerValue;
  bool answerTrueFalse;
  int index;
  Function(int) updateAnswerStatus;
  AnswerStyle(
      {super.key,
      required this.answerValue,
      required this.answerTrueFalse,
      required this.index,
      required this.updateAnswerStatus});

  @override
  State<AnswerStyle> createState() => _AnswerStyleState();
}

class _AnswerStyleState extends State<AnswerStyle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width * 0.62,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Color(0xFFD1D1D1),
          )),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            child: Checkbox(
              activeColor: Color.fromARGB(255, 8, 55, 145),
              value: widget.answerTrueFalse,
              onChanged: (bool? value) {
                setState(() {
                  widget.updateAnswerStatus(widget.index);
                });
              },
            ),
          ),
          SizedBox(
            width: MyUtility(context).width * 0.52,
            child: Text(
              widget.answerValue,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
