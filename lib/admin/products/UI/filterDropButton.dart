import 'package:flutter/material.dart';

class FilterDropButton extends StatefulWidget {
  
  const FilterDropButton({super.key, });

  @override
  State<FilterDropButton> createState() => _FilterDropButtonState();
}

class _FilterDropButtonState extends State<FilterDropButton> {
  


  
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
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
                hint: Text('Filter by Product Type'),
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
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
