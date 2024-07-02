import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/products/UI/myProductButtons.dart';
import 'package:sama/components/myutility.dart';

class ProductDisplayItem extends StatelessWidget {
  final String productName;
  final String productDescription;
  final String price;
  final String priceInfo;
  
  ProductDisplayItem(
      {super.key,
      required this.productName,
      required this.price,
      required this.priceInfo,
      required this.productDescription,
      
      });

  bool isDigital = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 140,
          width: 180,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/imageIcon.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Container(
          //color: Colors.amber,
          width: MyUtility(context).width * 0.35,
          height: 140,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                productDescription,
                maxLines: 3,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                'R ${price}',
                style: const TextStyle(
                    fontSize: 22, color: Color.fromARGB(255, 8, 55, 145)),
              ),
              Text(
                priceInfo,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 25,
        ),

        MyProductButtons(
            buttonText: 'Read More',
            buttonColor: Color.fromARGB(255, 212, 210, 210),
            borderColor: Color.fromARGB(255, 212, 210, 210),
            textColor: Colors.black),
        const SizedBox(
          width: 15,
        ),
        Visibility(
          visible: isDigital,
          child: MyProductButtons(
              buttonText: 'Buy Now',
              buttonColor: Color.fromARGB(255, 8, 55, 145),
              borderColor: Color.fromARGB(255, 8, 55, 145),
              textColor: Colors.white),
        ),
      ],
    );
  }
}
