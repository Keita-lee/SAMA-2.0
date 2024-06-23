import 'package:flutter/material.dart';
import 'package:sama/components/selectDuration.dart';

class SelectDurationPopup extends StatefulWidget {
  Function closeDialog;
  Function(String) getDuration;
  SelectDurationPopup(
      {super.key, required this.closeDialog, required this.getDuration});

  @override
  State<SelectDurationPopup> createState() => _SelectDurationPopupState();
}

class _SelectDurationPopupState extends State<SelectDurationPopup> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        width: 300,
        height: 250,
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
            "Please Select a duration",
            style: TextStyle(fontSize: 20, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          SelectDuration(getDuration: widget.getDuration),
          SizedBox(
            height: 15,
          ),
        ]));
  }
}
