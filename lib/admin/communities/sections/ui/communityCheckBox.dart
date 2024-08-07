import 'package:flutter/material.dart';

class CommunityCheckBox extends StatefulWidget {
  String description;
  bool checkboxValue;
  Function(String) addRemoveCommunity;
  CommunityCheckBox(
      {super.key,
      required this.description,
      required this.checkboxValue,
      required this.addRemoveCommunity});

  @override
  State<CommunityCheckBox> createState() => _CommunityCheckBoxState();
}

class _CommunityCheckBoxState extends State<CommunityCheckBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450,
      child: CheckboxListTile(
        title: Text(widget.description,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 128, 128, 128))),
        value: widget.checkboxValue,
        activeColor: Color.fromARGB(255, 0, 0, 0),
        onChanged: (bool? value) {
          setState(() {
            widget.checkboxValue = !widget.checkboxValue;
            widget.addRemoveCommunity(widget.description);
          });
        },
      ),
    );
  }
}
