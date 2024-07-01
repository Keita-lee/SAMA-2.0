import 'package:flutter/material.dart';
import 'package:sama/admin/products/UI/myProductTextField.dart';
import 'package:sama/components/myutility.dart';

class DigitalProductDeatail extends StatelessWidget {
  const DigitalProductDeatail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Digital Product Detail',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          'Add prices inclusive of VAT',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            MyProductTextField(
                hintText: 'Price in ZAR',
                textfieldController: TextEditingController(),
                textFieldWidth: MyUtility(context).width * 0.19,
                topPadding: 0,
                header: 'Member Price'),
            const SizedBox(width: 20,),
            MyProductTextField(
                hintText: 'Price in ZAR',
                textfieldController: TextEditingController(),
                textFieldWidth: MyUtility(context).width * 0.19,
                topPadding: 0,
                header: 'Non-Member Price'),
            const SizedBox(width: 20,),
            MyProductTextField(
                hintText: 'Price in ZAR',
                textfieldController: TextEditingController(),
                textFieldWidth: MyUtility(context).width * 0.19,
                topPadding: 0,
                header: 'Retailer Price'),
          ],
        ),
        MyProductTextField(
            hintText: 'Add full URL https://',
            textfieldController: TextEditingController(),
            textFieldWidth: MyUtility(context).width * 0.60,
            topPadding: 0,
            header: 'Download link'),
      ],
    );
  }
}
