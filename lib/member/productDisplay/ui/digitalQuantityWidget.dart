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
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 5.0),
              Text(
                '$_amount',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(width: 45.0),
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: _incrementAmount,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      '+',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: _decrementAmount,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      '--',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ],
    );
  }
}
