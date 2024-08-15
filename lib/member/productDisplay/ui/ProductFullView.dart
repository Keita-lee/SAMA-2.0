import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/admin/products/UI/myProductButtons.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/productDisplay/cart/cartPage.dart';

class ProductFullView extends StatefulWidget {
  final String productTitle;
  final String price;
  final String priceInfo;
  final Widget qtyWidget;
  final String productImage;
  Function(int, String) changePageIndex;
  Function(Map, int) buyProduct;
  final int productQuantity;
  Map product;
  ProductFullView(
      {super.key,
      required this.productTitle,
      required this.price,
      required this.priceInfo,
      required this.qtyWidget,
      required this.productImage,
      required this.changePageIndex,
      required this.buyProduct,
      required this.productQuantity,
      required this.product});

  @override
  State<ProductFullView> createState() => _ProductFullViewState();
}

class _ProductFullViewState extends State<ProductFullView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: widget.productImage == "" ? true : false,
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
              visible: widget.productImage != "" ? true : false,
              child: ImageNetwork(
                fitWeb: BoxFitWeb.contain,
                image: widget.productImage,
                width: MyUtility(context).width / 7,
                height: 200,
              ),
            ),
            /*  Container(
              height: 250,
              width: 320,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/imageIcon.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),*/
            const SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productTitle,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.price,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                Text(
                  widget.priceInfo,
                  style: const TextStyle(fontSize: 12, height: 1),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget.qtyWidget,
                    SizedBox(
                      width: MyUtility(context).width * 0.09,
                    ),
                    MyProductButtons(
                      buttonText: 'Add to Cart',
                      buttonColor: Color.fromARGB(255, 212, 210, 210),
                      borderColor: Color.fromARGB(255, 212, 210, 210),
                      textColor: Colors.black,
                      onTap: () {
                        print(widget.product);

                        widget.buyProduct(
                            widget.product, widget.productQuantity);

                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartPage()),
                        );*/
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    MyProductButtons(
                      buttonText: 'Buy Now',
                      buttonColor: Colors.teal,
                      borderColor: Colors.teal,
                      textColor: Colors.white,
                      onTap: () {
                        widget.buyProduct(
                            widget.product, widget.productQuantity);

                        widget.changePageIndex(2, "");
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    MyProductButtons(
                      buttonText: 'Back',
                      buttonColor: Colors.teal,
                      borderColor: Colors.teal,
                      textColor: Colors.white,
                      onTap: () {
                        widget.changePageIndex(0, "");
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
