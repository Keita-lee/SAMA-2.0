import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sama/components/myutility.dart';

class MyDatePicker extends StatefulWidget {
  final String hintText;
  final TextEditingController textfieldController;
  final Function refresh;
  MyDatePicker(
      {super.key,
      required this.textfieldController,
      required this.hintText,
      required this.refresh});

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  @override
  Widget build(BuildContext context) {
    //Select a date popup
    openDatePicker({required BuildContext context}) async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        lastDate: DateTime.now(),
        firstDate: DateTime(1900),
        initialDate: DateTime.now(),
      );
      if (pickedDate == null) return;
      DateFormat('yyyy-MM-dd').format(pickedDate);
      widget.textfieldController.text =
          DateFormat('yyyy-MM-dd').format(pickedDate);
      widget.refresh!();
    }

    return Container(
      width:
          MyUtility(context).width < 600 ? MyUtility(context).width / 1.1 : 300,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextField(
          //Text controller
          controller: widget.textfieldController,
          /////
          readOnly: true,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: widget.hintText),
          onTap: () => openDatePicker(context: context),
        ),
      ),
    );
  }
}
