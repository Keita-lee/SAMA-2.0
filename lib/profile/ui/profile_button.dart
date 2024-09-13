import 'package:flutter/material.dart';

import '../../components/mobile/components/Themes/custom_colors.dart';
import '../../components/mobile/components/Themes/font_text.dart';

class ProfileDropdownButton extends StatefulWidget {
  final Function(String) onOptionSelected;
  final Function(int) changePageIndex;

  const ProfileDropdownButton(
      {super.key,
      required this.onOptionSelected,
      required this.changePageIndex});

  @override
  State<ProfileDropdownButton> createState() => _ProfileDropdownButtonState();
}

class _ProfileDropdownButtonState extends State<ProfileDropdownButton> {
  String? _selectedOption;
  final List<String> _options = [
    'PROFILE HOME',
    'MY DETAILS',
    'MY BIOGRAPHY',
    'SECURITY',
  ];

  @override
  void initState() {
    super.initState();
    _selectedOption = _options.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 8, vertical: 4), // Added vertical padding
      decoration: BoxDecoration(
        color: CustomColors.blue,
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton<String>(
        value: _selectedOption,
        icon: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Icon(Icons.arrow_drop_down, color: Colors.white),
        ),
        iconSize: 18, // Reduced icon size
        elevation: 16,
        style: FontText(context).bodySmallBlack.copyWith(color: Colors.white),
        isDense: true, // Makes the button more compact
        underline: Container(
          height: 0,
        ),
        onChanged: (String? newValue) {
          setState(() {
            _selectedOption = newValue;
            if (newValue == "PROFILE HOME") {
              widget.changePageIndex(0);
            } else if (newValue == "MY DETAILS") {
              widget.changePageIndex(1);
            } else if (newValue == "MY BIOGRAPHY") {
              widget.changePageIndex(2);
            } else if (newValue == "SECURITY") {
              widget.changePageIndex(3);
            }
          });
          if (newValue != null) {
            widget.onOptionSelected(newValue);
          }
        },
        items: _options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(value),
            ),
          );
        }).toList(),
        borderRadius: BorderRadius.circular(8),
        dropdownColor: const Color.fromARGB(255, 82, 145, 196),
      ),
    );
  }
}
