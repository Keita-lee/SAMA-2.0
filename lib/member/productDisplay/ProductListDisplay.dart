import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/banner/samaBlueBanner.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/member/productDisplay/cart/cartPage.dart';
import 'package:sama/member/productDisplay/productFullViewCoding.dart';
import 'package:sama/member/productDisplay/productFullViewDigital.dart';
import 'package:sama/member/productDisplay/purchaseHistory/purchaseHistory.dart';
import 'package:sama/member/productDisplay/ui/productDisplayItem.dart';
import 'package:sama/components/myutility.dart';

import 'checkout/checkout.dart';

class ProductListDisplay extends StatefulWidget {
  String userType;
  ProductListDisplay({super.key, required this.userType});

  @override
  State<ProductListDisplay> createState() => _ProductListDisplayState();
}

class _ProductListDisplayState extends State<ProductListDisplay> {
  //var
  List allProduct = [];
  List cartProducts = [];
  String userType = "";
  int pageIndex = 0;
  String productType = "";
  String title = "";
  String price = "";
  String priceInfo = "";
  String description = "";
  String productImage = "";

  var productQuantity = 0;
  var total = 0.0;

  changePageIndex(value, type) {
    setState(() {
      pageIndex = value;
      productType = type;
    });
  }

  getProductQuantity(productName, amount) {
    var productIndex =
        (cartProducts).indexWhere((item) => item["productName"] == productName);

    if (amount == 0) {
      if (productIndex == -1) {
        productQuantity = 0;
      } else {
        productQuantity = cartProducts[productIndex]['quantity'];
      }
    } else {
      if (productIndex == -1) {
        productQuantity = amount;
      } else {
        productQuantity = amount;
      }
    }

    setState(() {});
  }

  getTotal(value) {
    setState(() {
      total = value;
    });
  }

//Get all products from firebase
  getAllProducts() async {
    setState(() {});
    allProduct.clear();
    final data = await FirebaseFirestore.instance.collection('store').get();
    setState(() {
      for (var i = 0; i < data.docs.length; i++) {
        if (data.docs[i]['isActive'] == "Active") {
          allProduct.add(data.docs[i]);
        }
      }
    });
  }

  // Add a product to the cart list
  addProductToList(product, quantity) {
    print(product);
    print(quantity);
    var productSelected = {
      "name": product['name'],
      "productPrice": 'Member Price. Includes VAT',
      "quantity": quantity != "" ? quantity : 1,
      "price": '${double.parse(product['price'])}',
      "total":
          '${double.parse(product['price']) * (quantity != "" ? quantity : 1)}',
      "id": product['id'],
      "productImage": product['imageUrl'],
    };

    setState(() {
      var productIndex = (cartProducts)
          .indexWhere((item) => item["productName"] == product['name']);

      if (productIndex == -1) {
        cartProducts.add(productSelected);
      } else {
        if (quantity == "") {
          cartProducts[productIndex]['quantity'] =
              cartProducts[productIndex]['quantity'] + 1;

          cartProducts[productIndex]['total'] =
              '${double.parse(cartProducts[productIndex]['total']) * cartProducts[productIndex]['quantity']}';
        } else {
          cartProducts[productIndex]['quantity'] = quantity;

          cartProducts[productIndex]['total'] =
              '${double.parse(cartProducts[productIndex]['total']) * quantity}';
        }
      } /* */
      getProductQuantity(product['name'], 0);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added to Cart')),
    );
  }

  @override
  void initState() {
    getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MyUtility(context).width - MyUtility(context).width / 6.5,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SamaBlueBanner(pageName: 'E - STORE'),
              SizedBox(
                height: MyUtility(context).height * 0.08,
              ),
              Visibility(
                visible: pageIndex == 0 ? true : false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        Visibility(
                          visible: widget.userType != "NonMember",
                          child: StyleButton(
                              description: "View Purchase History",
                              height: 55,
                              width: 125,
                              onTap: () {
                                changePageIndex(3, "");
                              }),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    for (int i = 0; i < allProduct.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProductDisplayItem(
                            productName: allProduct[i]['name'],
                            price: allProduct[i]['price'],
                            priceInfo: 'Member Price. Includes VAT',
                            productDescription: allProduct[i]['description'],
                            productImage: allProduct[i]['imageUrl'],
                            readMore: () {
                              /**/ changePageIndex(1, allProduct[i]['type']);
                              setState(() {
                                title = allProduct[i]['name'];
                                price = allProduct[i]['price'];
                                priceInfo = 'Member Price. Includes VAT';
                                description = allProduct[i]['description'];
                                productImage = allProduct[i]['imageUrl'];
                              });
                            },
                            buyProduct: () {
                              addProductToList(allProduct[i], "");
                              changePageIndex(2, allProduct[i]['type']); /**/
                            }),
                      ), /* */
                  ],
                ),
              ), //&& productType == "Digital Product"
              Visibility(
                visible: pageIndex == 1 ? true : false,
                child: ProductFullViewDigital(
                  title: title,
                  price: price,
                  priceInfo: priceInfo,
                  description: description,
                  productImage: productImage,
                  changePageIndex: changePageIndex,
                  buyProduct: addProductToList,
                  productQuantity: productQuantity,
                  getProductQuantity: getProductQuantity,
                ),
              ),
              /*  Visibility(
                visible: pageIndex == 1 && productType == "Coding Product"
                    ? true
                    : false,
                child: ProductFullViewCoding(
                  title: title,
                  price: price,
                  priceInfo: priceInfo,
                  description: description,
                  productImage: productImage,
                  changePageIndex: changePageIndex,
                ),
              ),*/
              Visibility(
                visible: pageIndex == 2 ? true : false,
                child: CartPage(
                    products: cartProducts,
                    changePageIndex: changePageIndex,
                    getTotal: getTotal),
              ),

              Visibility(
                visible: pageIndex == 3 ? true : false,
                child: PurchaseHistory(changePageIndex: changePageIndex),
              ),

              Visibility(
                visible: pageIndex == 4 ? true : false,
                child: Checkout(
                  products: cartProducts,
                  total: total,
                  changePageIndex: changePageIndex,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
