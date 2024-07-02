import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CodingQuantityWidget extends StatefulWidget {
  const CodingQuantityWidget({super.key});

  @override
  State<CodingQuantityWidget> createState() => _CodingQuantityWidgetState();
}

class _CodingQuantityWidgetState extends State<CodingQuantityWidget> {

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            focusColor: Colors.white,
            value: selectedValue,
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(6),
            hint: Text('Quantity'),
            items: <String>[
              '01 - Free',
              '02 + R1260.00',
              '03 + R2520.00',
              '04 + R3780.00'
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: ( newValue) {
              setState(() {
                selectedValue = newValue;
              });
            },
          ),
        ),
      ),
    );
  }
}
