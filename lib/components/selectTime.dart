import 'package:flutter/material.dart';
import 'package:sama/components/styleButton.dart';

class SelectTime extends StatefulWidget {
  Function(String) getTime;

  SelectTime({super.key, required this.getTime});

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay? selectedTime;
  TimePickerEntryMode entryMode = TimePickerEntryMode.inputOnly;
  Orientation? orientation;
  TextDirection textDirection = TextDirection.ltr;
  MaterialTapTargetSize tapTargetSize = MaterialTapTargetSize.padded;
  bool use24HourTime = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        StyleButton(
          description: 'Select Time',
          onTap: () async {
            final TimeOfDay? time = await showTimePicker(
              context: context,
              initialTime: selectedTime ?? TimeOfDay.now(),
              initialEntryMode: entryMode,
              orientation: orientation,
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    materialTapTargetSize: tapTargetSize,
                  ),
                  child: Directionality(
                    textDirection: textDirection,
                    child: MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        alwaysUse24HourFormat: use24HourTime,
                      ),
                      child: child!,
                    ),
                  ),
                );
              },
            );
            setState(() {
              selectedTime = time;
              widget.getTime(time!.format(context));
            });
          },
          height: 55,
          width: 150,
        ),
        if (selectedTime != null) Text('${selectedTime!.format(context)}'),
      ],
    );
  }
}
