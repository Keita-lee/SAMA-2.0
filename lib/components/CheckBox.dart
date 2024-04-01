import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  final String name;
  final String discription;

  const CheckBox({super.key, required this.name, required this.discription});

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                borderRadius: BorderRadius.circular(6.0),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF6A6A6A),
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                widget.discription,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6A6A6A),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
