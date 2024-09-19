import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:sama/member/productDisplay/ui/ProductFullView.dart';
import 'package:sama/member/productDisplay/ui/digitalQuantityWidget.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/utils/quillUtils.dart';

class ProductFullViewDigital extends StatefulWidget {
  String title;
  String? price;
  Map<String, dynamic> priceList;
  String priceInfo;

  String description;
  String productImage;

  Function(int, String) changePageIndex;
  Function(Map, int) buyProduct;
  Function(String, int) getProductQuantity;
  int productQuantity;
  Function(String) updatePrice;
  ProductFullViewDigital({
    super.key,
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
  });

  @override
  State<ProductFullViewDigital> createState() => _ProductFullViewDigitalState();
}

class _ProductFullViewDigitalState extends State<ProductFullViewDigital> {
  var myJSON;
  QuillController quillController = QuillController.basic();
  Map<String, dynamic> product = {};
  Map<String, dynamic> priceList = {};
  final auth = FirebaseAuth.instance;
  bool productAlreadyPurchased = false;
  String priceInfo = '';
  @override
  void initState() {
    // myJSON = jsonDecode(widget.description);
    quillController = handleDescription(widget.description, true, false);
    super.initState();
    checkUser();
    Map<String, dynamic> tempProducts = product;
    product = {
      ...tempProducts,
      "name": widget.title,
      "productPrice": 'Member Price. Includes VAT',
      "quantity": widget.productQuantity,
      "id": "",
      "imageUrl": widget.productImage,
    };
  }

  void checkUser() async {
    // User is signed in
    if (auth.currentUser != null) {
      DocumentSnapshot? user = await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .get();
      // User is a member
      if (user.exists && user.get('userType') != 'Admin') {
        product['priceList'] = [
          {'description': 'First License', 'price': '0.00'},
          {
            'description': widget.priceList['secondTierRange'],
            'price': widget.priceList['secondTierPrice']
          },
          {
            'description': widget.priceList['thirdTierRange'],
            'price': widget.priceList['thirdTierPrice']
          },
        ];
        QuerySnapshot purchases = await FirebaseFirestore.instance
            .collection('storeHistory')
            .where('user', isEqualTo: auth.currentUser!.uid)
            .get();

        String newPrice = '';
        productAlreadyPurchased =
            purchases.docs.any((doc) => doc['productName'] == widget.title);

        if (productAlreadyPurchased) {
          product['priceInfo'] =
              '${widget.priceList['secondTierRange']} Licenses Price. Incl VAT';
          product['price'] = widget.priceList['secondTierPrice'];
        } else {
          product['priceInfo'] = 'SAMA Member\'s First License is Free.';
          product['price'] = '0.00';
        }
      }
    }
    // User is not a member
    else {
      try {
        product['priceList'] = [
          {
            'description': 'First License',
            'price': widget.priceList['firstLicensePrice']
          },
          {
            'description': widget.priceList['secondTierRange'],
            'price': widget.priceList['secondTierPrice']
          },
          {
            'description': widget.priceList['thirdTierRange'],
            'price': widget.priceList['thirdTierPrice']
          },
        ];
        product['priceInfo'] = 'SAMA Non-Member First License Price. Incl VAT';
        product['price'] = widget.priceList['firstLicensePrice'];
        //widget.updatePrice(newPrice);
      } catch (e) {
        print('error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MyUtility(context).width * 0.70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MyUtility(context).height * 0.08,
            ),
            ProductFullView(
                productTitle: widget.title,
                priceList: product['priceList'],
                price: "R ${product['price']}",
                priceInfo: product['priceInfo'],
                productQuantity: widget.productQuantity,
                qtyWidget: DigitalQuantityWidget(
                  productQuantity: widget.productQuantity,
                  getProductQuantity: widget.getProductQuantity,
                  title: widget.title,
                ),
                productImage: widget.productImage,
                changePageIndex: widget.changePageIndex,
                buyProduct: widget.buyProduct,
                product: product),
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
