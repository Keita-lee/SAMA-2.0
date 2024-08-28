import 'package:flutter/material.dart';

class QuizAnswerCheckBox extends StatefulWidget {
  

  const QuizAnswerCheckBox({
    super.key,
    
  });

  @override
  State<QuizAnswerCheckBox> createState() => _QuizAnswerCheckBoxState();
}

class _QuizAnswerCheckBoxState extends State<QuizAnswerCheckBox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isChecked = !_isChecked;
          });
        },
        child: Container(
          width: 20.0,
          height: 20.0,
          decoration: ShapeDecoration(
            shape: CircleBorder(
              side: BorderSide(color: Colors.grey)
            )),
          child: _isChecked
              ? Center(child: Icon(Icons.circle , color: Colors.grey, size: 16,))
              : null,
        ),
      ),
    );
  }
}
