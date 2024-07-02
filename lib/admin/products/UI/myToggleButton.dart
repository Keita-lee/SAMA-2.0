import 'package:flutter/material.dart';

class MyToggleButton extends StatefulWidget {
  final bool initialValue;
  final Function(bool) onChanged;

  const MyToggleButton(
      {super.key, required this.initialValue, required this.onChanged});

  @override
  State<MyToggleButton> createState() => _MyToggleButtonState();
}

class _MyToggleButtonState extends State<MyToggleButton> {
  late List<bool> _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = [widget.initialValue, !widget.initialValue];
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: _isSelected,
      borderColor: Colors.grey,
      borderRadius: BorderRadius.circular(6.0),
      selectedBorderColor: Color.fromARGB(255, 8, 55, 145),
      selectedColor: Colors.white,
      fillColor: Color.fromARGB(255, 8, 55, 145),
      color: Colors.grey,
      splashColor: Color.fromARGB(186, 8, 56, 145),
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < _isSelected.length; i++) {
            _isSelected[i] = i == index;
          }
          widget.onChanged(_isSelected[0]);
        });
      },
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
          child: Text(
            'Active',
            style: TextStyle(fontSize: 16, letterSpacing: 1.1),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
          child: Text('Inactive',
              style: TextStyle(fontSize: 16, letterSpacing: 1.1)),
        ),
      ],
    );
  }
}
