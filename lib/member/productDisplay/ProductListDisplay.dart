import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/banner/samaBlueBanner.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/member/productDisplay/cart/cartPage.dart';
import 'package:sama/member/productDisplay/models/cartProduct.dart';
import 'package:sama/member/productDisplay/productFullViewCoding.dart';
import 'package:sama/member/productDisplay/productFullViewDigital.dart';
import 'package:sama/member/productDisplay/purchaseHistory/purchaseHistory.dart';
import 'package:sama/member/productDisplay/ui/productDisplayItem.dart';
import 'package:sama/components/myutility.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sama/utils/cartUtils.dart';
import '../../components/email/sendPaymentConfirmation.dart';
import 'checkout/checkout.dart';

class ProductListDisplay extends StatefulWidget {
  String userType;
  int? pageIndex;
  ProductListDisplay({super.key, required this.userType, this.pageIndex});

  @override
  State<ProductListDisplay> createState() => _ProductListDisplayState();
}

class _ProductListDisplayState extends State<ProductListDisplay> {
  final auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> allProduct = [];
  List cartProducts = [];
  String userType = "";
  int pageIndex = 0;
  String productType = "";
  String title = "";
  String price = "";
  List<Map<String, dynamic>> priceList = [];
  String priceInfo = "";
  String description = "";
  String productImage = "";
  bool isLoading = false;
  String id = '';
  var productQuantity = 1;
  var total = 0.0;

  changePageIndex(value, type) {
    setState(() {
      pageIndex = value;
      productType = type;
    });
  }

  getProductQuantity(productName, amount) async {
    List cart = await getCart();
    var productIndex =
        (cart).indexWhere((item) => item["productName"] == productName);

    if (amount == 0) {
      if (productIndex == -1) {
        productQuantity = 0;
      } else {
        productQuantity = cart[productIndex]['quantity'];
      }
    } else {
      if (productIndex == -1) {
        productQuantity = amount;
      } else {
        productQuantity = amount;
      }
    }

    setState(() {
      cartProducts = cart;
    });
  }

  getTotal(value, cart) async {
    setState(() {
      cartProducts = cart;
      total = value;
    });
  }

  deleteItem(String name) async {
    await deleteProduct(name, getProductQuantity);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product removed from cart')),
    );

    List cart = await getCart();
    setState(() {
      cartProducts = cart;
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
          allProduct.add({id: data.docs[i].id, ...data.docs[i].data()});
        }
      }
    });
  }

  // Add a product to the cart list
  addProductToList(Map<String, dynamic> product, int quantity,
      double totalProductPrice) async {
    print(product);
    print(quantity);
    await addProduct(product, quantity, getProductQuantity, totalProductPrice);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to Cart')),
    );
    List cart = await getCart();
    setState(() {
      cartProducts = cart;
    });

    // var productSelected = {
    //   "name": product['name'],
    //   "productPrice": 'Member Price. Includes VAT',
    //   "quantity": quantity != "" ? quantity : 1,
    //   "price": '${double.parse(product['price'])}',
    //   "total":
    //       '${double.parse(product['price']) * (quantity != "" ? quantity : 1)}',
    //   "id": product['id'],
    //   "productImage": product['imageUrl'],
    // };

    // setState(() {
    //   var productIndex = (cartProducts)
    //       .indexWhere((item) => item["productName"] == product['name']);

    //   if (productIndex == -1) {
    //     cartProducts.add(productSelected);
    //   } else {
    //     if (quantity == "") {
    //       cartProducts[productIndex]['quantity'] =
    //           cartProducts[productIndex]['quantity'] + 1;

    //       cartProducts[productIndex]['total'] =
    //           '${double.parse(cartProducts[productIndex]['total']) * cartProducts[productIndex]['quantity']}';
    //     } else {
    //       cartProducts[productIndex]['quantity'] = quantity;

    //       cartProducts[productIndex]['total'] =
    //           '${double.parse(cartProducts[productIndex]['total']) * quantity}';
    //     }
    //   } /* */

    //   getProductQuantity(product['name'], 0);
    // });

    // Store the updated cart in secure storage
    // await _storage.write(key: 'cart', value: jsonEncode(cartProducts));
  }

  updatePrice(String newPrice) {
    print('new price $newPrice');
    setState(() {
      price = newPrice;
    });
  }

  List<Map<String, dynamic>> setPrices(Map<String, dynamic> productData) {
    List<Map<String, dynamic>> productPriceList = [];
    print(productData);
    bool isMember = auth.currentUser != null;
    setState(() {
      isLoading = true;
    });
    if (productData['type'] == 'Licensed Product') {
      if (isMember) {
        productPriceList.add(
            {'description': 'First License', 'price': productData['price']});
      } else {
        productPriceList.add({
          'description': 'First License',
          'price': productData['firstLicensePrice']
        });
      }

      if (productData['secondTierPrice'] != '') {
        productPriceList.add({
          'description': productData['secondTierRange'],
          'price': productData['secondTierPrice']
        });
      }
      if (productData['thirdTierPrice'] != '') {
        productPriceList.add({
          'description': productData['thirdTierRange'],
          'price': productData['thirdTierPrice']
        });
      }
    } else {
      if (isMember) {
        productPriceList.add(
            {'description': 'First License', 'price': productData['price']});
        productPriceList.add({
          'description': 'Second License and more',
          'price': productData['nonMemberPrice']
        });
      } else {
        productPriceList.add({
          'description': 'License Price',
          'price': productData['nonMemberPrice']
        });
      }
    }

    print(productPriceList);

    return productPriceList;
  }

  @override
  void initState() {
    if (widget.pageIndex != null) {
      print("redirect");
      changePageIndex(widget.pageIndex, "");
      return;
    }
    getAllProducts();
    super.initState();
  }

  void onReadMoreClick(Map<String, dynamic> productData) async {
    List<Map<String, dynamic>> newPriceList = setPrices(productData);
    setState(() {
      priceList = newPriceList;
      title = productData['name'];
      priceInfo = 'Member Price. Includes VAT';
      description = productData['description'];
      productImage = productData['imageUrl'];
      pageIndex = 1;
      productType = productData['type'];
      id = productData['id'];
    });

    print(priceList);
  }

  void resetQuanitity() {
    setState(() {
      productQuantity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return SizedBox(
      width: isMobile
          ? MyUtility(context).width
          : MyUtility(context).width - MyUtility(context).width / 6.5,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SamaBlueBanner(pageName: 'E-STORE'),
            SizedBox(
              height: isMobile ? 10 : 30,
            ),
            Visibility(
                visible: pageIndex == 0 ? true : false,
                child: Padding(
                  padding: isMobile
                      ? EdgeInsets.all(0)
                      : EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      isMobile
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Visibility(
                                  visible: widget.userType != "NonMember",
                                  child: InkWell(
                                    onTap: () {
                                      sendPaymentConfirmation(
                                          email: "ChrisPotgieter145@gmail.com",
                                          customerName: "Customer Nme",
                                          totalPrice: "123",
                                          refNo: "rft");
                                      //    changePageIndex(3, "");
                                    },
                                    child: Text(
                                      'View Purchase History',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(
                              width: MyUtility(context).width -
                                  MyUtility(context).width / 3.5,
                              child: Row(
                                children: [
                                  Spacer(),
                                  Visibility(
                                    visible: widget.userType != "NonMember",
                                    child: StyleButton(
                                        description: "View Purchase History",
                                        height: 55,
                                        width: 125,
                                        onTap: () {
                                          sendPaymentConfirmation(
                                              email:
                                                  "ChrisPotgieter145@gmail.com",
                                              customerName: "Customer Nme",
                                              totalPrice: "123",
                                              refNo: "rft");
                                          //    changePageIndex(3, "");
                                        }),
                                  )
                                ],
                              ),
                            ),
                      const SizedBox(
                        height: 35,
                      ),
                      Container(
                        height: isMobile
                            ? MyUtility(context).height / 1.45
                            : MyUtility(context).height * 1.25,
                        width: isMobile
                            ? MyUtility(context).width
                            : MyUtility(context).width -
                                MyUtility(context).width / 3.5,
                        child: GridView.builder(
                          padding: const EdgeInsets.all(8.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isMobile ? 1 : 3,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio:
                                1.5 / 1.9, // Adjust the aspect ratio as needed
                          ),
                          itemCount: allProduct.length,
                          itemBuilder: (context, index) {
                            return Visibility(
                              visible:
                                  allProduct[index]['isActive'] == "Active",
                              child: ProductDisplayItem(
                                downloadLink: allProduct[index]['downloadLink'],
                                productName: allProduct[index]['name'],
                                price: allProduct[index]['price'],
                                priceInfo: 'Member Price. Includes VAT',
                                productDescription: allProduct[index]
                                    ['description'],
                                productImage: allProduct[index]['imageUrl'],
                                readMore: () async {
                                  onReadMoreClick(allProduct[index]);
                                },
                                buyProduct: () {},
                              ),
                            );
                          },
                        ),
                      ), /* */
                    ],
                  ),
                )), //&& productType == "Digital Product"
            Visibility(
              visible: pageIndex == 1,
              child: ProductFullViewDigital(
                title: title,
                price: price,
                productType: productType,
                productId: id,
                priceList: priceList,
                priceInfo: priceInfo,
                description: description,
                productImage: productImage,
                changePageIndex: changePageIndex,
                buyProduct: addProductToList,
                productQuantity: productQuantity,
                getProductQuantity: getProductQuantity,
                resetQuantity: resetQuanitity,
                updatePrice: updatePrice,
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
                  delete: deleteItem,
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
    );
  }
}
