import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelecter extends StatefulWidget {
  double customSize;
  TextEditingController controller;
  Function refresh;
  String description;
  DateSelecter(
      {super.key,
      required this.customSize,
      required this.controller,
      required this.refresh,
      required this.description});

  @override
  State<DateSelecter> createState() => _DateSelecterState();
}

class _DateSelecterState extends State<DateSelecter> {
  //Select a date popup
  onTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime(2500),
      firstDate: DateTime(1900),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    widget.controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    widget.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF6A6A6A),
            ),
          ),
          Container(
            width: widget.customSize,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: TextField(
              textAlign: TextAlign.center,
              controller: widget.controller,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Click here to select date",
                border: InputBorder.none,
              ),
              onTap: () => onTapFunction(context: context),
            ),
          )
        ]);
  }
}
