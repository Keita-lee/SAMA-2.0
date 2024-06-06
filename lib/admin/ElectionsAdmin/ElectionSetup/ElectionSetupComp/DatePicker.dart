import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final String dateHeadline;
  const DatePicker({super.key, required this.dateHeadline});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            widget.dateHeadline,
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF3D3D3D),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDateButton(
              onPressed: () async {
                final DateTime? dateTime = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(3000),
                  initialDate: startDate ?? DateTime.now(),
                );
                if (dateTime != null) {
                  setState(() {
                    startDate = dateTime;
                  });
                }
              },
              date: startDate,
              label: 'Starting Date',
            ),
            _buildDateButton(
              onPressed: () async {
                final DateTime? dateTime = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(3000),
                  initialDate: endDate ?? DateTime.now(),
                );
                if (dateTime != null) {
                  setState(() {
                    endDate = dateTime;
                  });
                }
              },
              date: endDate,
              label: 'Ending Date',
            ),
            _buildDaysLeftContainer(endDate: endDate),
          ],
        ),
      ],
    );
  }

  Widget _buildDateButton({
    required VoidCallback onPressed,
    required DateTime? date,
    required String label,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Color.fromARGB(255, 8, 55, 145),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          date != null ? '${date.day}/${date.month}/${date.year}' : label,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDaysLeftContainer({DateTime? endDate}) {
    if (endDate == null) {
      return Container(
        width: 175,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 8, 55, 145),
        ),
        padding: EdgeInsets.all(8),
        child: Center(
          child: Text(
            'No end date',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    final daysLeft = endDate.difference(DateTime.now()).inDays;
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 175,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 8, 55, 145),
        ),
        padding: EdgeInsets.all(8),
        child: Center(
          child: Text(
            '$daysLeft days left',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
