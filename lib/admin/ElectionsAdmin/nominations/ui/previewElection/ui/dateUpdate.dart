import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/dateSelecter.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';

class DateUpdate extends StatefulWidget {
  Function closeDialog;
  String description;
  Function(String) updateDate;
  DateUpdate(
      {super.key,
      required this.closeDialog,
      required this.description,
      required this.updateDate});

  @override
  State<DateUpdate> createState() => _DateUpdateState();
}

class _DateUpdateState extends State<DateUpdate> {
  final date = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        width: 300,
        height: 240,
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
            widget.description!,
            style: TextStyle(fontSize: 20, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          DateSelecter(
            customSize: MyUtility(context).width / 7,
            description: 'Change Date',
            controller: date,
            refresh: () {
              setState(() {});
            },
          ),
          SizedBox(
            height: 15,
          ),
          StyleButton(
              description: "Save Date",
              height: 55,
              width: 85,
              onTap: () {
                widget.updateDate(date.text);
                widget.closeDialog();
              }),
          SizedBox(
            height: 15,
          ),
        ]));
  }
}
