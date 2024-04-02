import 'package:flutter/material.dart';

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
      color: Colors.white,
      width: 300,
      height: 150,
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "X",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Text(
            widget.description!,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
