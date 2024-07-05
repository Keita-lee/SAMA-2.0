import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/admin/products/UI/myProductButtons.dart';
import 'package:sama/components/myutility.dart';

class ProductDisplayItem extends StatelessWidget {
  final String productName;
  final String productDescription;
  final String price;
  final String priceInfo;
  final String productImage;
  VoidCallback readMore;
  ProductDisplayItem(
      {super.key,
      required this.productName,
      required this.price,
      required this.priceInfo,
      required this.productDescription,
      required this.productImage,
      required this.readMore});

  bool isDigital = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          visible: productImage == "" ? true : false,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/imageIcon.png"),
                fit: BoxFit.cover,
              ),
            ),
            width: MyUtility(context).width / 7,
            height: 200,
          ),
        ),
        Visibility(
          visible: productImage != "" ? true : false,
          child: ImageNetwork(
            fitWeb: BoxFitWeb.cover,
            image: productImage,
            width: MyUtility(context).width / 7,
            height: 200,
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
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: MyUtility(context).width / 3.5,
                height: 30,
                child: Text(
                  productDescription,
                  maxLines: 3,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                'R ${price}',
                style: const TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 8, 55, 145)),
              ),
              Text(
                priceInfo,
                style: const TextStyle(
                  fontSize: 22,
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
          textColor: Colors.black,
          onTap: () {
            readMore();
          },
        ),
        const SizedBox(
          width: 15,
        ),
        Visibility(
          visible: isDigital,
          child: MyProductButtons(
            buttonText: 'Buy Now',
            buttonColor: Color.fromARGB(255, 8, 55, 145),
            borderColor: Color.fromARGB(255, 8, 55, 145),
            textColor: Colors.white,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
