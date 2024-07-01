import 'package:flutter/material.dart';
import 'package:sama/admin/products/UI/myProductButtons.dart';
import 'package:sama/components/myutility.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 35,
        ),
        const Text(
          'Product Image',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
            ),
          ),
          width: MyUtility(context).width * 0.22,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/imageIcon.png',
                    height: 150,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 155,
                    child: MyProductButtons(
                        buttonText: 'Change Image',
                        buttonColor: Color.fromARGB(255, 8, 55, 145),
                        borderColor: Color.fromARGB(255, 8, 55, 145),
                        textColor: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
