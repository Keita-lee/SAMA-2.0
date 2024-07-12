import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyDidiver extends StatelessWidget {
  const MyDidiver({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:  EdgeInsets.only(bottom: 15),
      child:  Divider(
        height: 1.5,
        color: Colors.grey,
      ),
    );
  }
}
