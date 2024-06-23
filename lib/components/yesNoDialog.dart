import 'package:flutter/material.dart';
import 'package:sama/components/styleButton.dart';

class YesNoDialog extends StatefulWidget {
  Function? closeDialog;
  Function? callFunction;
  String? description;
  YesNoDialog(
      {super.key,
      required this.closeDialog,
      required this.callFunction,
      required this.description});

  @override
  State<YesNoDialog> createState() => _YesNoDialogState();
}

class _YesNoDialogState extends State<YesNoDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      width: 300,
      height: 185,
      child: Column(
        children: [
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: StyleButton(
                      description: "Yes",
                      height: 45,
                      width: 85,
                      onTap: () {
                        widget.callFunction!();
                        widget.closeDialog!();
                      })),
              SizedBox(
                width: 5,
              ),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: StyleButton(
                      description: "No",
                      height: 45,
                      width: 85,
                      onTap: () {
                        widget.closeDialog!();
                      })),
            ],
          ),
        ],
      ),
    );
  }
}
