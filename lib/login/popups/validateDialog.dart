import 'package:flutter/material.dart';
import 'package:sama/components/styleButton.dart';

class ValidateDialog extends StatefulWidget {
  Function? closeDialog;
  String? description;
  ValidateDialog(
      {super.key, required this.closeDialog, required this.description});

  @override
  State<ValidateDialog> createState() => _ValidateDialogState();
}

class _ValidateDialogState extends State<ValidateDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      width: 300,
      height: 200,
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "X",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Text(
            widget.description!,
            style: TextStyle(fontSize: 20, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: StyleButton(
                  description: "Ok",
                  height: 45,
                  width: 85,
                  onTap: () {
                    widget.closeDialog!();
                  })),
        ],
      ),
    );
  }
}
