import 'package:flutter/material.dart';

class CheckCircle extends StatefulWidget {
  final String name;
  final bool? isCircle;

  const CheckCircle({super.key, required this.name, this.isCircle});

  @override
  State<CheckCircle> createState() => _CheckCircleState();
}

class _CheckCircleState extends State<CheckCircle> {
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
                borderRadius: widget.isCircle == null
                    ? BorderRadius.circular(10.0)
                    : BorderRadius.circular(0),
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
