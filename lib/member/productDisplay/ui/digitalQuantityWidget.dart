import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/utils/cartUtils.dart';

class DigitalQuantityWidget extends StatefulWidget {
  int productQuantity;
  String title;
  bool? canDelete;
  Function(String, int) getProductQuantity;
  Function(String)? deleteProduct;
  DigitalQuantityWidget(
      {super.key,
      required this.productQuantity,
      required this.title,
      required this.getProductQuantity,
      this.canDelete,
      this.deleteProduct});

  @override
  State<DigitalQuantityWidget> createState() => _DigitalQuantityWidgetState();
}

class _DigitalQuantityWidgetState extends State<DigitalQuantityWidget> {
  int _amount = 1;
  bool _canDelete = false;

  void _incrementAmount() {
    setState(() {
      _amount++;
      widget.getProductQuantity(widget.title, _amount);
    });
  }

  void _decrementAmount() {
    if (_amount > 1) {
      setState(() {
        _amount--;
        widget.getProductQuantity(widget.title, _amount);
      });
    } else {
      if (_canDelete && widget.deleteProduct != null) {
        widget.deleteProduct!(widget.title);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    widget.canDelete != null
        ? _canDelete = widget.canDelete!
        : _canDelete = false;
    _amount = widget.productQuantity;
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
                  width: 10,
                ),
                Text(
                  '$_amount',
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(
                  width: 10,
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
