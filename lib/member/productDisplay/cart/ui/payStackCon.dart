import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PayStackCon extends StatelessWidget {
  const PayStackCon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 60,
      color: Colors.white,
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: ' Secured by '),
                  TextSpan(
                      text: 'paystack',
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
