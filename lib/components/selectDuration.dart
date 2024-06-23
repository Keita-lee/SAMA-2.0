import 'package:flutter/material.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/components/styleButton.dart';

class SelectDuration extends StatefulWidget {
  Function(String) getDuration;
  SelectDuration({super.key, required this.getDuration});

  @override
  State<SelectDuration> createState() => _SelectDurationState();
}

class _SelectDurationState extends State<SelectDuration> {
  //var
  List seconds = [];
  List minutes = [];
  List hours = [];

  // Text controllers
  final hoursText = TextEditingController();
  final minText = TextEditingController();
  final secText = TextEditingController();

  getTime() {
    for (int s = 0; s < 60; s++) {
      setState(() {
        seconds.add(s.toString());
        minutes.add(s.toString());
      });
    }
    for (int h = 0; h < 24; h++) {
      setState(() {
        hours.add(h.toString());
      });
    }
  }

  @override
  void initState() {
    getTime();
    hoursText.text = "00";
    minText.text = "00";
    secText.text = "00";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileDropDownField(
              customSize: 80,
              description: 'Hours',
              items: hours,
              textfieldController: hoursText,
            ),
            SizedBox(
              width: 6,
            ),
            ProfileDropDownField(
              customSize: 80,
              description: 'Minutes',
              items: minutes,
              textfieldController: minText,
            ),
            SizedBox(
              width: 6,
            ),
            ProfileDropDownField(
              customSize: 80,
              description: 'Seconds',
              items: seconds,
              textfieldController: secText,
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StyleButton(
                description: "Select Duration",
                height: 55,
                width: 125,
                onTap: () {
                  widget.getDuration(
                      "${hoursText.text} : ${minText.text} : ${secText.text}");
                }),
            SizedBox(
              width: 15,
            ),
          ],
        ),
      ],
    );
  }
}
