import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/email/sendDigitalProducts.dart';
import 'package:sama/components/email/sendLicenses.dart';
import 'package:sama/components/email/sendPaymentConfirmation.dart';
import 'package:sama/member/productDisplay/cart/ui/payStackCon.dart';
import 'package:sama/member/productDisplay/checkout/yourOrderTable/yourOrderTable.dart';
import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sama/utils/cartUtils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../login/popups/validateDialog.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class YourOrderCon extends StatefulWidget {
  TextEditingController email;
  String name;
  final GlobalKey<FormState> formKey;
  Function(int, String) changePageIndex;
  List products;
  double total;

  YourOrderCon(
      {super.key,
      required this.formKey,
      required this.products,
      required this.total,
      required this.changePageIndex,
      required this.email,
      required this.name});

  @override
  State<YourOrderCon> createState() => _YourOrderConState();
}

class _YourOrderConState extends State<YourOrderCon> {
  double total = 0.0;
  String email = "";
  bool loadingState = false;
  List cartProducts = [];
  String reference = "";

  Future<void> _getCart() async {
    List cart = await getCart();
    setState(() {
      cartProducts = cart;
      total = getTotal(cart);
    });
  }

  //Dialog for payment popup
  Future successPopup() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: ValidateDialog(
                description: "Payment received , please check your emails",
                closeDialog: () {
                  widget.changePageIndex(0, "");
                  Navigator.pop(context);
                }));
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

  double getTotal(List cart) {
    double total = cart.fold(0.0, (sum, item) {
      return sum + double.parse(item['total']);
    });

    return total;
  }

//Send payment
  Future<void> sendPayment() async {
    print(widget.email);
    final response = await http.post(
      Uri.parse('https://api.paystack.co/transaction/initialize'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer sk_test_216721a21d245ae3b272fcd9b76eeb7e1076d5b7',
      },
      body: jsonEncode(<String, dynamic>{
        'email': FirebaseAuth.instance.currentUser != null
            ? email
            : widget.email.text,
        'amount': "${total * 100}",
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
      print('error ${response.statusCode} ${response.body}');
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

  savePaymentsToHistory() async {
    List<Map<String, dynamic>> products = [];
    List<Map<String, dynamic>> productCodes = [];
    List<Map<String, dynamic>> digitalProducts = [];

    String title = '';
    for (int i = 0; i < cartProducts.length; i++) {
      var product = {
        "productImage": cartProducts[i]['productImage'],
        "productName": cartProducts[i]['name'] ?? '',
        "productPrice": cartProducts[i]['price'],
        "quantity": cartProducts[i]['quantity'],
        "downloadLink": cartProducts[i]['downloadLink'] ?? '',
        "productType": cartProducts[i]['type'],
      };

      if (cartProducts[i]['type'] == 'Licensed Product') {
        product.putIfAbsent(
            'productCode', () => cartProducts[i]['productCode']);
        productCodes.add({
          'code': cartProducts[i]['productCode'],
          'quantity': cartProducts[i]['quantity'],
          'name': cartProducts[i]['productName']
        });
      } else if (cartProducts[i]['type'] == 'Digital Product') {
        DocumentSnapshot digitalProductSnapshot = await FirebaseFirestore
            .instance
            .collection('store')
            .doc(cartProducts[i]['id'])
            .get();

        digitalProducts.add({
          'name': digitalProductSnapshot.get('name'),
          'downloadLink': digitalProductSnapshot.get('downloadLink'),
        });
      }

      products.add(product);
    }

    var productHistory = {
      "paymentRef": reference,
      "products": products,
      "date": DateTime.now(),
      "user": FirebaseAuth.instance.currentUser?.uid ?? email,
    };

    try {
      DocumentReference doc = await FirebaseFirestore.instance
          .collection('storeHistory')
          .add(productHistory);
      String name = widget.name;
      if (FirebaseAuth.instance.currentUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        name = '${userDoc.get('lastName')} ${userDoc.get('firstName')}';
        title = userDoc.get('title');
      }

      if (productCodes.isNotEmpty) {
        for (var code in productCodes) {
          addCodingLicenses(code['code'], code['quanitity'], doc.id, name,
              code['name'], title);
        }
      }

      if (digitalProducts.isNotEmpty) {
        for (var product in digitalProducts) {
          sendDigitalProduct(
            email: email == '' ? widget.email.text : email,
            name: name,
            title: title,
            link: product['downloadLink'],
            product: product['name'],
          );
        }
      }

      sendPaymentConfirmation(
          email: email,
          customerName: name,
          totalPrice: total.toString(),
          refNo: reference);
    } catch (e) {
      print('could not add user history $e');
    }
  }

  addCodingLicenses(String productCode, int quantity, String docId, String name,
      String productName, String title) async {
    var uuid = const Uuid();
    String licenseString = '';
    String link = '';
    for (int i = 1; i <= quantity; i++) {
      String licenseKey = uuid.v1();
      licenseString += 'license $i: $licenseKey\n';
      if (productCode.contains('ICD10')) {
        await FirebaseFirestore.instance.collection('icd10Licenses').add({
          "accTxid": docId,
          "computercode": '',
          "createdon": '',
          "expiryData": '',
          "installcount": '',
          "installdate": '',
          "installed": 0,
          "licensekey": licenseKey,
          "productCode": productCode,
        });
        link = 'https://www.samedical.org/downloads/icd10/setup.exe';
      } else if (productCode.contains('MDCM')) {
        await FirebaseFirestore.instance.collection('emdcmLicenses').add({
          "accTxid": docId,
          "computercode": '',
          "createdon": '',
          "expiryData": '',
          "installcount": '',
          "installdate": '',
          "installed": 0,
          "licensekey": licenseKey,
          "productCode": productCode,
          "lastComms": '',
          "webLastlogin": '',
          "webSessionid": '',
        });
        link = 'https://www.samedical.org/downloads/emdcm/setup.exe';
      } else if (productCode.contains('CCSA')) {
        await FirebaseFirestore.instance.collection('ccsaLicenses').add({
          "accTxid": docId,
          "computercode": '',
          "createdon": '',
          "expiryData": '',
          "installcount": '',
          "installdate": '',
          "installed": 0,
          "licensekey": licenseKey,
          "productCode": productCode,
        });
        link = 'https://www.samedical.org/downloads/ccsa/setup.exe';
      }
    }

    sendLicenses(
      email: email == '' ? widget.email.text : email,
      name: name,
      title: title,
      link: link,
      licenses: licenseString,
      product: productName,
    );
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

  getTotals(value) {
    setState(() {
      total = value;
    });
  }

  @override
  void initState() {
    getUserEmail();
    _getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 365,
          decoration: BoxDecoration(
            color: Color.fromRGBO(231, 252, 252, 1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color(0xFFD1D1D1),
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Your Order',
                  style: GoogleFonts.openSans(fontSize: 18),
                ),
                //List here
                YourOrderTable(
                    orderProduct: cartProducts,
                    getTotal: getTotals,
                    total: total.toStringAsFixed(2)),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Pay by Card, Scan to Pay, SnapScan, EFT(Ozow)',
          style: GoogleFonts.openSans(fontSize: 14),
        ),
        const SizedBox(
          height: 10,
        ),
        PayStackCon(),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            // form validation here
            if (widget.formKey.currentState!.validate()) {
              print("1");
              sendPayment();
            } else {
              print("2");

              // Not Valid
            }
          },
          child: Container(
            width: 365,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color.fromRGBO(0, 159, 158, 1),
            ),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                child: Text(
                  'Place Order',
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
        Visibility(
          visible: loadingState,
          child: Text(
            'Awaiting Payment ....',
            style: TextStyle(
                color: Color.fromRGBO(0, 159, 158, 1),
                fontWeight: FontWeight.w600,
                fontSize: 22,
                letterSpacing: 1.1),
          ),
        ),
      ],
    );
  }
}
