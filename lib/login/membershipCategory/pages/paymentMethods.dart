import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  String title;
  String applicationPrice;
  Function(int) nextSection;
  PaymentMethod(
      {super.key,
      required this.title,
      required this.applicationPrice,
      required this.nextSection});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
