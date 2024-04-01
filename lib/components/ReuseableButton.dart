import 'package:flutter/material.dart';

class ReuseableButton extends StatefulWidget {
  final String buttontext;
  final VoidCallback onPressed;

  const ReuseableButton(
      {super.key, required this.buttontext, required this.onPressed});

  @override
  State<ReuseableButton> createState() => _ReuseableButtonState();
}

class _ReuseableButtonState extends State<ReuseableButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF174486)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        child: Text(
          widget.buttontext,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
