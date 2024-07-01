import 'package:flutter/material.dart';

class MyDropDownButton extends StatefulWidget {
  Function(String) getDropDownValue;
  MyDropDownButton({super.key, required this.getDropDownValue});

  @override
  State<MyDropDownButton> createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  


  
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, left: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Type',
              style: const  TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.black),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  focusColor: Colors.white,
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  value: _selectedValue,
                  hint: Text('Select a product type'),
                  items:
                      <String>['Digital Product', 'Coding Product'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedValue = newValue;
                      widget.getDropDownValue(newValue!);
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
