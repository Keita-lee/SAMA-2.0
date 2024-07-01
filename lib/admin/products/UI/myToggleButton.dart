import 'package:flutter/material.dart';

class MyToggleButton extends StatefulWidget {
  const MyToggleButton({super.key});

  @override
  State<MyToggleButton> createState() => _MyToggleButtonState();
}

class _MyToggleButtonState extends State<MyToggleButton> {
  List<bool> _isSelected = [true, false];

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
      // Define the button tap behavior
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < _isSelected.length; i++) {
            _isSelected[i] = i == index;
          }
        });
      },

      children: const <Widget>[
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
          child: Text(
            'Active',
            style: TextStyle(fontSize: 16, letterSpacing: 1.1),
          ),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
          child: Text('Inactive',
              style: TextStyle(fontSize: 16, letterSpacing: 1.1)),
        ),
      ],
    );
  }
}
