import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DigitalQuantityWidget extends StatefulWidget {
  const DigitalQuantityWidget({super.key});

  @override
  State<DigitalQuantityWidget> createState() => _DigitalQuantityWidgetState();
}

class _DigitalQuantityWidgetState extends State<DigitalQuantityWidget> {
  int _amount = 1;

  void _incrementAmount() {
    setState(() {
      _amount++;
    });
  }

  void _decrementAmount() {
    if (_amount > 1) {
      setState(() {
        _amount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Qty',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: _decrementAmount,
                  child: Center(
                    child: Icon(Icons.remove),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  '$_amount',
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(
                  width: 30,
                ),
                InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: _incrementAmount,
                    child: Icon(Icons.add)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
