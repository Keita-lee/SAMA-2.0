import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../components/styleButton.dart';

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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StyleButton(
                buttonColor: const Color.fromARGB(255, 219, 219, 219),
                description: "PREVIOUS",
                height: 55,
                width: 125,
                onTap: () {
                  widget.nextSection(1);
                }),
            Spacer(),
            StyleButton(
                description: "CONTINUE",
                height: 55,
                width: 125,
                onTap: () {
                  widget.nextSection(3);
                })
          ],
        )
      ],
    );
  }
}
