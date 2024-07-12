import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDatePicker extends StatefulWidget {
  final TextEditingController textfieldController;
  const MyDatePicker({super.key , required this.textfieldController});

  

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

openDatePicker({required BuildContext context}) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    lastDate: DateTime.now(),
    firstDate: DateTime(1900),
    initialDate: DateTime.now(),
  );
  if (pickedDate == null) return;
  DateFormat('yyyy-MM-dd').format(pickedDate);
}


class _MyDatePickerState extends State<MyDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
          decoration:
              const InputDecoration(border: InputBorder.none, hintText: "Select Date"),
          onTap: () => openDatePicker(context: context),
        ),
      ),
    );
  }
}
