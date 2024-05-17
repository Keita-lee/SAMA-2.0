import 'package:flutter/material.dart';
import 'package:sama/components/ReuseableButton.dart';
import 'package:sama/components/myutility.dart';

class GeneralInfoContainer extends StatefulWidget {
  final String headline;
  final String text;
  final String buttonText;
  final VoidCallback onPressed;

  const GeneralInfoContainer(
      {super.key,
      required this.headline,
      required this.text,
      required this.buttonText,
      required this.onPressed});

  @override
  State<GeneralInfoContainer> createState() => _GeneralInfoContainerState();
}

class _GeneralInfoContainerState extends State<GeneralInfoContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width / 5.5,
      height: MyUtility(context).height * 0.28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Color(0xFFD1D1D1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.headline,
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF174486),
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: MyUtility(context).height * 0.03,
            ),
            Text(
              widget.text,
              style: TextStyle(
                  color: Colors.grey.shade600,
                  letterSpacing: -0.05,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: ReuseableButton(
                  buttontext: widget.buttonText, onPressed: widget.onPressed),
            ),
            SizedBox(
              height: MyUtility(context).height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
