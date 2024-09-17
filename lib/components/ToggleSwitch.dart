import 'package:flutter/material.dart';

class ToggleSwitch extends StatefulWidget {
  final bool isActive;
  final ValueChanged<bool> onToggle;

  const ToggleSwitch({
    Key? key,
    required this.isActive,
    required this.onToggle,
  }) : super(key: key);

  @override
  _ToggleSwitchState createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _isActive = widget.isActive; // Initialize with the passed isActive value
  }

  void _toggleSwitch() {
    widget.onToggle(
        !widget.isActive); // Call the callback to notify the parent widget
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSwitch, // Handle tap to toggle
      child: Container(
        width: 60,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: widget.isActive ? const Color(0xFF174486) : Colors.grey,
        ),
        child: Align(
          alignment:
              widget.isActive ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.all(5.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
