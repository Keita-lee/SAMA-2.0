import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/admin/products/UI/myProductButtons.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/productDisplay/cart/cartPage.dart';

class ProductFullView extends StatefulWidget {
  final String productTitle;
  List<Map<String, dynamic>> priceList;
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
      required this.priceList,
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
  bool hasAddedToCart = false;
  @override
  void initState() {
    print(widget.productQuantity);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: MyUtility(context).width < 600,
          child: Column(children: [
            Visibility(
              visible: widget.productImage == "" ? true : false,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/imageIcon.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                width: MyUtility(context).width,
                height: 175,
              ),
            ),
            Visibility(
              visible: widget.productImage != "" ? true : false,
              child: ImageNetwork(
                fitWeb: BoxFitWeb.contain,
                image: widget.productImage,
                width: MyUtility(context).width,
                height: 170,
              ),
            )
          ]),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: MyUtility(context).width > 600,
              child: Row(
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
                ],
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
                (MyUtility(context).width >= 600)
                    ? SizedBox(
                        child: Text(
                          widget.productTitle,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      )
                    : SizedBox(
                        width: MyUtility(context).width * 0.95,
                        child: Text(
                          widget.productTitle,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                ...widget.priceList.map((price) {
                  final index = widget.priceList.indexOf(price);
                  String description = '';
                  if (index == 0) {
                    description =
                        '${price['description']}: R ${price['price']}';
                  } else {
                    description =
                        '${price['description']} Licenses: R ${price['price']} ';
                  }
                  return Text(
                    description,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  );
                }).toList(),
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
                if (MediaQuery.of(context).size.width > 600)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      widget.qtyWidget,
                      SizedBox(
                        width: MyUtility(context).width * 0.09,
                      ),
                      hasAddedToCart == false
                          ? MyProductButtons(
                              buttonText: 'Add to Cart',
                              buttonColor: Color.fromARGB(255, 212, 210, 210),
                              borderColor: Color.fromARGB(255, 212, 210, 210),
                              textColor: Colors.black,
                              onTap: () async {
                                print(widget.product);

                                await widget.buyProduct(
                                    widget.product, widget.productQuantity);
                                setState(() {
                                  hasAddedToCart = true;
                                });
                                /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartPage()),
                        );*/
                              },
                            )
                          : MyProductButtons(
                              buttonText: 'Go to Cart',
                              buttonColor: Color.fromARGB(255, 212, 210, 210),
                              borderColor: Color.fromARGB(255, 212, 210, 210),
                              textColor: Colors.black,
                              onTap: () async {
                                widget.changePageIndex(2, "");
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
                        onTap: () async {
                          await widget.buyProduct(
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
                else
                  // For mobile view
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MyUtility(context).width * 0.95,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widget.qtyWidget,
                              SizedBox(
                                width: MyUtility(context).width * 0.09,
                              ),
                              hasAddedToCart == false
                                  ? MyProductButtons(
                                      buttonText: 'Add to Cart',
                                      buttonColor:
                                          Color.fromARGB(255, 212, 210, 210),
                                      borderColor:
                                          Color.fromARGB(255, 212, 210, 210),
                                      textColor: Colors.black,
                                      onTap: () async {
                                        await widget.buyProduct(widget.product,
                                            widget.productQuantity);
                                        setState(() {
                                          hasAddedToCart = true;
                                        });
                                      },
                                    )
                                  : MyProductButtons(
                                      buttonText: 'Go to Cart',
                                      buttonColor:
                                          Color.fromARGB(255, 212, 210, 210),
                                      borderColor:
                                          Color.fromARGB(255, 212, 210, 210),
                                      textColor: Colors.black,
                                      onTap: () async {
                                        widget.changePageIndex(2, "");
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15), // Space between rows
                      SizedBox(
                        width: MyUtility(context).width * 0.95,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyProductButtons(
                              buttonText: 'Buy Now',
                              buttonColor: Colors.teal,
                              borderColor: Colors.teal,
                              textColor: Colors.white,
                              onTap: () async {
                                await widget.buyProduct(
                                    widget.product, widget.productQuantity);
                                widget.changePageIndex(2, "");
                              },
                            ),
                            const SizedBox(width: 15),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: MyProductButtons(
                                buttonText: 'Back',
                                buttonColor: Colors.teal,
                                borderColor: Colors.teal,
                                textColor: Colors.white,
                                onTap: () {
                                  widget.changePageIndex(0, "");
                                },
                              ),
                            ),
                          ],
                        ),
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
