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
  VoidCallback buyProduct;
  ProductDisplayItem(
      {super.key,
      required this.productName,
      required this.price,
      required this.priceInfo,
      required this.productDescription,
      required this.productImage,
      required this.readMore,
      required this.buyProduct});

  bool isDigital = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width * 0.70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
              color: Color.fromARGB(255, 212, 210, 210), width: 1.5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
              width: MyUtility(context).width * 0.50,
              height: 200,
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
                  Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'R ${price}',
                            style: const TextStyle(
                                fontSize: 25, color: Colors.teal),
                          ),
                          Text(
                            priceInfo,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
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
                          buttonColor: Colors.teal,
                          borderColor: Colors.teal,
                          textColor: Colors.white,
                          onTap: () {
                            buyProduct();
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
