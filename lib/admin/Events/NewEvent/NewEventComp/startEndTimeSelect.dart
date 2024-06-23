import 'package:flutter/material.dart';
import 'package:sama/components/selectTime.dart';
import 'package:sama/components/styleButton.dart';

class StartEndTimeSelect extends StatefulWidget {
  Function closeDialog;
  Function(String) getTimes;
  StartEndTimeSelect(
      {super.key, required this.closeDialog, required this.getTimes});

  @override
  State<StartEndTimeSelect> createState() => _StartEndTimeSelectState();
}

class _StartEndTimeSelectState extends State<StartEndTimeSelect> {
  String startTime = "";
  String endTime = "";

  getStartTime(value) {
    setState(() {
      startTime = value;
    });
  }

  getEndTime(value) {
    setState(() {
      endTime = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        width: 400,
        height: 350,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Spacer(),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      widget.closeDialog!();
                    },
                    child: Icon(Icons.cancel),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Please Select Start and End Time",
            style: TextStyle(fontSize: 18, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Start Time",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SelectTime(getTime: getStartTime),
          SizedBox(
            height: 15,
          ),
          Text(
            "End Time",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SelectTime(getTime: getEndTime),
          SizedBox(
            height: 15,
          ),
          StyleButton(
            description: 'Save Times',
            onTap: () {
              widget.getTimes("${startTime} - ${endTime}");
              widget.closeDialog();
            },
            height: 55,
            width: 150,
          ),
          SizedBox(
            height: 15,
          ),
        ]));
  }
}
