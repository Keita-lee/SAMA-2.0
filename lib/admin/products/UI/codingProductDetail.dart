import 'package:flutter/material.dart';
import 'package:sama/admin/products/UI/myProductTextField.dart';
import 'package:sama/components/myutility.dart';

class CodingProductDetail extends StatelessWidget {
  const CodingProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Coding Product Detail',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          'Add prices inclusive of VAT. Price is per license',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            MyProductTextField(
                hintText: 'Price in ZAR',
                textfieldController: TextEditingController(),
                textFieldWidth: MyUtility(context).width * 0.19,
                topPadding: 0,
                header: 'First License Price'),
            const SizedBox(
              width: 20,
            ),
            MyProductTextField(
                hintText: 'Price in ZAR',
                textfieldController: TextEditingController(),
                textFieldWidth: MyUtility(context).width * 0.19,
                topPadding: 0,
                header: '2-10 License Price'),
            const SizedBox(
              width: 20,
            ),
            MyProductTextField(
                hintText: 'Price in ZAR',
                textfieldController: TextEditingController(),
                textFieldWidth: MyUtility(context).width * 0.19,
                topPadding: 0,
                header: '11 + License Price'),
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
