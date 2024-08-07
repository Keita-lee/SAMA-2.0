import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/products/UI/myProductButtons.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/login/popups/validateDialog.dart';
import 'package:sama/member/productDisplay/cart/ui/payStackCon.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CartTotalContainer extends StatefulWidget {
  final List products;
  final String cartTotal;
  Function(int, String) changePageIndex;
  CartTotalContainer(
      {super.key,
      required this.products,
      required this.cartTotal,
      required this.changePageIndex});

  @override
  State<CartTotalContainer> createState() => _CartTotalContainerState();
}

class _CartTotalContainerState extends State<CartTotalContainer> {
  bool loadingState = false;
  String email = "";
  String reference = "";
  String total = "";

  //Dialog for payment popup
  Future successPopup() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: ValidateDialog(
                description: "Payment received , please check your emails",
                closeDialog: () => Navigator.pop(context!)));
      });

  getUserEmail() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (data.exists) {
      email = data.get('email');
    }
  }

//Send payment
  Future<void> sendPayment() async {
    final response = await http.post(
      Uri.parse('https://api.paystack.co/transaction/initialize'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer sk_test_216721a21d245ae3b272fcd9b76eeb7e1076d5b7',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'amount': "${double.parse(total) * 100}",
        "currency": "ZAR",
      }),
    );
    if (response.statusCode == 200) {
      final decode =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      setState(() {
        loadingState = true;
        reference = decode['data']['reference'];
        afterPaymentMade();
      });

      launchUrl(Uri.parse(decode['data']['authorization_url']));
    } else {
      throw Exception('Failed .');
    } /* */
  }

  checkPaymentMade() {
    return http.get(
      Uri.parse('https://api.paystack.co/transaction/verify/${reference}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer sk_test_216721a21d245ae3b272fcd9b76eeb7e1076d5b7',
      },
    );
  }

  savePaymentsToHistory() {
    List products = [];
    /*
    productImage: widget.productItems[i]['productImage'],
                    productName: widget.productItems[i]['productName'],
                    productPrice: widget.productItems[i]['productPrice'],
                    qtyWidget: widget.productItems[i]['quantity'],
     */

    for (int i = 0; i < widget.products.length; i++) {
      var product = {
        "productImage": widget.products[i]['productImage'],
        "productName": widget.products[i]['productName'],
        "productPrice": widget.products[i]['productPrice'],
        "quantity": widget.products[i]['quantity'],
        "downloadLink": widget.products[i]['downloadLink'],
      };
      products.add(product);
    }

    var productHistory = {
      "paymentRef": reference,
      "products": products,
      "date": DateTime.now(),
      "user": FirebaseAuth.instance.currentUser!.uid
    };

    FirebaseFirestore.instance.collection('storeHistory').add(productHistory);
  }

  afterPaymentMade() {
    var timer = Timer.periodic(Duration(seconds: 5), (Timer t) async {
      final response = await checkPaymentMade();

      final decode =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      if (decode['data']['status'] == "success" && loadingState == true) {
        setState(() {
          savePaymentsToHistory();
          loadingState = false;
          successPopup();
        });
      }
    });
  }

  @override
  void initState() {
    getUserEmail();
    var split = widget.cartTotal.split(" ");
    total = split[1];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 365,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color(0xFFD1D1D1),
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.cartTotal,
                      style: const TextStyle(
                          color: Color.fromRGBO(0, 159, 158, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Inclusive of VAT. Placeholder text for any other related info.',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    //  sendPayment();
                    widget.changePageIndex(4, "");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromRGBO(0, 159, 158, 1),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 18),
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                              letterSpacing: 1.1),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        PayStackCon(),
        Visibility(
          visible: loadingState,
          child: Text(
            'Awaiting Payment ....',
            style: TextStyle(
                color: Color.fromRGBO(0, 159, 158, 1),
                fontWeight: FontWeight.w500,
                fontSize: 22,
                letterSpacing: 1.1),
          ),
        ),
      ],
    );
  }
}
