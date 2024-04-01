import 'package:flutter/material.dart';

class CheckBoxExample extends StatefulWidget {
  final String name;

  const CheckBoxExample({super.key, required this.name});

  @override
  State<CheckBoxExample> createState() => _CheckBoxExampleState();
}

class _CheckBoxExampleState extends State<CheckBoxExample> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isChecked = !_isChecked;
              });
            },
            child: Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                ),
                color: _isChecked ? Color(0xFF174486) : Colors.transparent,
              ),
              child: _isChecked
                  ? Icon(
                      Icons.check,
                      size: 16.0,
                      color: Colors.white,
                    )
                  : null,
            ),
          ),
          SizedBox(width: 10.0),
          Text(
            widget.name,
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF6A6A6A),
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
