import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../login/popups/validateDialog.dart';
import 'package:http/http.dart' as http;

class YourOrderTable extends StatefulWidget {
  List orderProduct;
  Function(double) getTotal;
  String total;

  YourOrderTable(
      {super.key,
      required this.orderProduct,
      required this.getTotal,
      required this.total});

  @override
  State<YourOrderTable> createState() => _YourOrderTableState();
}

class _YourOrderTableState extends State<YourOrderTable> {
  var total = 0.0;
  String email = "";
  bool loadingState = false;

  String reference = "";

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
        'amount': "${widget.total * 100}",
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

    for (int i = 0; i < widget.orderProduct.length; i++) {
      var product = {
        "productImage": widget.orderProduct[i]['productImage'],
        "productName": widget.orderProduct[i]['name'],
        "productPrice": widget.orderProduct[i]['price'],
        "quantity": widget.orderProduct[i]['quantity'],
        "downloadLink": widget.orderProduct[i]['downloadLink'],
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
    print(widget.orderProduct);
    getUserEmail();

    //widget.getTotal(getTotal());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 350,
          //height: 500,
          child: Center(
            child: Table(
              columnWidths: {0: FixedColumnWidth(220)},
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                const TableRow(
                  children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Product',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Subtotal',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                ...List.generate(
                  widget.orderProduct.length,
                  (index) => TableRow(
                    children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            ' ${widget.orderProduct[index]['name']} ${widget.orderProduct[index]['quantity']}',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            (double.parse(widget.orderProduct[index]['price']) *
                                    widget.orderProduct[index]['quantity'])
                                .toString(),
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TableRow(children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '${widget.total}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ])
              ],
            ),
          ),
        ),
        Visibility(
          visible: loadingState,
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Awaiting Payment ....',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
