import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:sama/member/productDisplay/ui/ProductFullView.dart';
import 'package:sama/member/productDisplay/ui/digitalQuantityWidget.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/utils/cartUtils.dart';
import 'package:sama/utils/quillUtils.dart';

class PriceUtils {
  Function(double) addToTotalPrice;
  Function subtractFromPrice;
  Function(int) updateActivePriceIndex;

  PriceUtils(
      {required this.addToTotalPrice,
      required this.subtractFromPrice,
      required this.updateActivePriceIndex});
}

class ProductFullViewDigital extends StatefulWidget {
  String title;
  String? price;
  List<Map<String, dynamic>> priceList;
  String priceInfo;

  String description;
  String productImage;

  Function(int, String) changePageIndex;
  Function(Map<String, dynamic>, int, double) buyProduct;
  Function(String, int) getProductQuantity;
  int productQuantity;
  Function(String) updatePrice;
  String productType;
  Function resetQuantity;
  String productId;
  ProductFullViewDigital(
      {super.key,
      required this.title,
      this.price,
      required this.updatePrice,
      required this.priceList,
      required this.priceInfo,
      required this.description,
      required this.productImage,
      required this.changePageIndex,
      required this.buyProduct,
      required this.productQuantity,
      required this.getProductQuantity,
      required this.productType,
      required this.resetQuantity,
      required this.productId});

  @override
  State<ProductFullViewDigital> createState() => _ProductFullViewDigitalState();
}

class _ProductFullViewDigitalState extends State<ProductFullViewDigital> {
  var myJSON;
  QuillController quillController = QuillController.basic();
  Map<String, dynamic> product = {};
  Map<String, dynamic> priceList = {};
  List<double> totalPriceData = [];
  final auth = FirebaseAuth.instance;
  bool productAlreadyPurchased = false;
  String priceInfo = '';
  bool isLoading = true;
  int activePriceIndex = 0;
  int initalActiveIndex = 0;
  String cartInfo = '';
  @override
  void initState() {
    print('price list: ${widget.priceList}');
    // myJSON = jsonDecode(widget.description);
    quillController = handleDescription(widget.description, true, false);
    super.initState();

    if (auth.currentUser != null) {
      checkHasPurchased();
    }

    checkCartQuantity();

    Map<String, dynamic> tempProducts = product;
    product = {
      ...tempProducts,
      "name": widget.title,
      "productPrice": 'Member Price. Includes VAT',
      "quantity": widget.productQuantity,
      "id": widget.productId,
      "imageUrl": widget.productImage,
      "productType": widget.productType,
    };
  }

  void checkCartQuantity() async {
    setState(() {
      isLoading = true;
    });
    try {
      int quantity = await getProductQuantity(widget.title);
      print('quantity: $quantity');
      if (quantity > 0) {
        String lowerBound = '0';
        String upperBound = '1';

        for (int i = 0; i < widget.priceList.length; i++) {
          if (widget.priceList[i]['description'].contains(' - ')) {
            upperBound = widget.priceList[i]['description'].split(' - ')[1];
            lowerBound = widget.priceList[i]['description'].split(' - ')[0];
            print('upperbound:  $upperBound, lowerBound: $lowerBound,');
            if (upperBound == 'unlimited') {
              if (quantity + 1 >= int.parse(lowerBound)) {
                setState(() {
                  activePriceIndex = i;
                  cartInfo =
                      'You already have $quantity of this product in you cart';
                  isLoading = false;
                });
                totalPriceData.add(double.parse(widget.priceList[i]['price']));
                break;
              }
            } else if (quantity >= int.parse(lowerBound) &&
                quantity <= int.parse(upperBound)) {
              print('upperbound:  $upperBound, lowerBound: $lowerBound,');
              setState(() {
                activePriceIndex = i;
                cartInfo =
                    'You already have $quantity of this product in you cart';
                isLoading = false;
              });
              totalPriceData.add(double.parse(widget.priceList[i]['price']));
              break;
            }
          }
        }
      } else {
        totalPriceData
            .add(double.parse(widget.priceList[activePriceIndex]['price']));
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('error: $e');
    }
  }

  void checkHasPurchased() async {
    QuerySnapshot purchases = await FirebaseFirestore.instance
        .collection('storeHistory')
        .where('user', isEqualTo: auth.currentUser!.uid)
        .get();

    bool hasAlreadyPurchased =
        purchases.docs.any((doc) => doc['productName'] == widget.title);
    setState(() {
      priceInfo = hasAlreadyPurchased
          ? 'You have already purchased this product'
          : 'SAMA member first license price';
      activePriceIndex = hasAlreadyPurchased ? 1 : 0;
      initalActiveIndex = activePriceIndex;
    });
  }

  void updateActivePriceIndex(int newIndex) {
    setState(() {
      activePriceIndex = newIndex;
    });
  }

  void addToTotalPrice(double price) {
    print('price $price');
    setState(() {
      totalPriceData.add(price);
    });
  }

  void subtractFromPrice() {
    if (totalPriceData.length >= 2) {
      setState(() {
        totalPriceData.removeLast();
      });
    }
  }

  // void checkUser() async {
  //   if (widget.productType == 'Licensed Product') {
  //     getPriceListForCodingProduct();
  //   } else {
  //     User is signed in
  //     if (auth.currentUser != null) {
  //       product['priceList'] = [
  //         {
  //           'description': 'First License',
  //           'price': widget.priceList['memberPrice']
  //         },
  //         {
  //           'description': '2nd License and more',
  //           'price': widget.priceList['nonMemberPrice']
  //         },
  //       ];

  //       product['priceInfo'] = 'Member Licenses Price. Incl VAT';
  //       product['price'] = widget.priceList['secondTierPrice'];
  //     } else {}
  //   }
  // }

  // void getPriceListForCodingProduct() async {
  //   try {
  //     User is signed in
  //     if (auth.currentUser != null) {
  //       DocumentSnapshot? user = await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(auth.currentUser!.uid)
  //           .get();
  //       User is a member
  //       if (user.exists && user.get('userType') != 'Admin') {
  //         List<Map<String, dynamic>> productPriceList = [
  //           {
  //             'description': 'First License',
  //             'price': widget.priceList['firstLicensePriceMember']
  //           },
  //         ];
  //         setState(() {
  //           product['priceList'] = [
  //             {
  //               'description': 'First License',
  //               'price': widget.priceList['firstLicensePriceMember']
  //             },
  //             {
  //               'description': widget.priceList['secondTierRange'],
  //               'price': widget.priceList['secondTierPrice']
  //             },
  //             {
  //               'description': widget.priceList['thirdTierRange'],
  //               'price': widget.priceList['thirdTierPrice']
  //             },
  //           ];
  //         });

  //         QuerySnapshot purchases = await FirebaseFirestore.instance
  //             .collection('storeHistory')
  //             .where('user', isEqualTo: auth.currentUser!.uid)
  //             .get();

  //         String newPrice = '';
  //         productAlreadyPurchased =
  //             purchases.docs.any((doc) => doc['productName'] == widget.title);
  //         setState(() {
  //           if (productAlreadyPurchased) {
  //             product['priceInfo'] =
  //                 '${widget.priceList['secondTierRange']} Licenses Price. Incl VAT';
  //             product['price'] = widget.priceList['secondTierPrice'];
  //           } else {
  //             product['priceInfo'] = 'SAMA Member\'s First License is Free.';
  //             product['price'] = '0.00';
  //           }
  //         });
  //       }
  //     }
  //     User is not a member
  //     else {
  //       product['priceList'] = [
  //         {
  //           'description': 'First License',
  //           'price': widget.priceList['firstLicensePriceNonMember']
  //         },
  //         {
  //           'description': widget.priceList['secondTierRange'],
  //           'price': widget.priceList['secondTierPrice']
  //         },
  //         {
  //           'description': widget.priceList['thirdTierRange'],
  //           'price': widget.priceList['thirdTierPrice']
  //         },
  //       ];
  //       product['priceInfo'] = 'SAMA Non-Member First License Price. Incl VAT';
  //       product['price'] = widget.priceList['firstLicensePrice'];
  //       widget.updatePrice(newPrice);
  //     }
  //     setState(() {
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     print('error: $e');
  //   }
  // }

  void buyProduct() async {
    double totalPrice =
        totalPriceData.reduce((value, element) => value + element);
    widget.buyProduct(product, widget.productQuantity, totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MyUtility(context).width * 1.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: MyUtility(context).width > 600,
              child: SizedBox(
                height: MyUtility(context).height * 0.08,
              ),
            ),
            // isLoading
            //     ? SizedBox(
            //         width: MyUtility(context).width * 0.745,
            //         height: MyUtility(context).height * 0.5,
            //         child: const Center(
            //           child: SizedBox(
            //             width: 50.0,
            //             height: 50.0,
            //             child: CircularProgressIndicator(
            //               color: Colors.teal,
            //             ),
            //           ),
            //         ),
            //       )
            //     :
            isLoading
                ? const CircularProgressIndicator(
                    color: Colors.teal,
                  )
                : ProductFullView(
                    productTitle: widget.title,
                    priceList: widget.priceList,
                    priceIndex: activePriceIndex,
                    //price: "R ${product['price']}",
                    price: totalPriceData
                        .reduce((value, element) => value + element)
                        .toStringAsFixed(2),
                    priceInfo: auth.currentUser != null
                        ? priceInfo
                        : 'Login to get special discounts on your first license',
                    cartInfo: cartInfo,
                    productQuantity: widget.productQuantity,
                    qtyWidget: DigitalQuantityWidget(
                      utils: PriceUtils(
                          addToTotalPrice: addToTotalPrice,
                          subtractFromPrice: subtractFromPrice,
                          updateActivePriceIndex: updateActivePriceIndex),
                      initialActivePriceIndex: initalActiveIndex,
                      priceList: widget.priceList,
                      productQuantity: widget.productQuantity,
                      getProductQuantity: widget.getProductQuantity,
                      title: widget.title,
                    ),
                    productImage: widget.productImage,
                    changePageIndex: widget.changePageIndex,
                    buyProduct: buyProduct,
                    product: product,
                    reset: widget.resetQuantity),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: MyUtility(context).width / 1.5,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: QuillEditor.basic(
                controller: quillController,
                configurations: const QuillEditorConfigurations(
                  sharedConfigurations: QuillSharedConfigurations(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
