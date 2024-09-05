import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/service/commonService.dart';
import 'package:sama/login/membershipCategory/pages/ui/PaymentTextReu.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../components/styleButton.dart';
import '../../../member/productDisplay/cart/ui/payStackCon.dart';
import 'ui/paymentTextField.dart';
import 'package:http/http.dart' as http;

class PaymentMethod extends StatefulWidget {
  String email;
  String title;
  String applicationPrice;
  Function(int) nextSection;
  String applicationCategory;
  String paymentType;
  Function(String) getPaymentRef;
  Function(Map) getDebitOrder;
  Function(String, String) getPaymentDetails;

  PaymentMethod(
      {super.key,
      required this.email,
      required this.title,
      required this.applicationPrice,
      required this.nextSection,
      required this.applicationCategory,
      required this.paymentType,
      required this.getPaymentRef,
      required this.getDebitOrder,
      required this.getPaymentDetails});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  bool isChecked = false;
  var paymnetType = "PAY ONLINE";
  var amountToPay = 0.0;
  var email = "";
  String paymentStatus = "";
  String reference = "";
  String debitRef = "Loading...";
  bool loadingState = false;
  TextEditingController bankDisclaimer = TextEditingController();
  TextEditingController accHolderName = TextEditingController();
  TextEditingController nameOfBank = TextEditingController();
  TextEditingController branchName = TextEditingController();
  TextEditingController branchCode = TextEditingController();
  TextEditingController accNumber = TextEditingController();
  TextEditingController accType = TextEditingController();

  getAmountOfMembers() async {
    final doc = await FirebaseFirestore.instance.collection('users').get();
    setState(() {
      final data = FirebaseFirestore.instance.collection('users').get();
      widget.getPaymentRef("MP0000${doc.docs.length}");
      debitRef = "MP0000${doc.docs.length}";
    });
    FirebaseFirestore.instance.collection('users').get();
  }

//Calculate months left for december
  getTimeFrame() {
    return '${CommonService().getMonthTodayDate()} ${CommonService().getYearTodayDate()} - December ${CommonService().getYearTodayDate()}';
  }

  getTotalToPay() {
    var getAm = (widget.applicationPrice).split("R");
    var payAmount =
        ((double.parse(getAm[1]) / 12) * CommonService().getMonthDiff())
            .roundToDouble();

    setState(() {
      amountToPay = payAmount;
    });
    return 'R ${(payAmount)}';
  }

  afterPaymentMade() {
    var timer = Timer.periodic(Duration(seconds: 5), (Timer t) async {
      print("TESTTime");
      final response = await checkPaymentMade();

      final decode =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      if (decode['data']['status'] == "success") {
        setState(() {
          paymentStatus = "Payment Received";
        });
      }
    });
  }

  checkCustomerExist() {
    return http.get(
      Uri.parse('https://api.paystack.co/customer/${email}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer sk_test_216721a21d245ae3b272fcd9b76eeb7e1076d5b7',
      },
    );
  }

  checkSubscription() async {
    var timer = Timer.periodic(Duration(seconds: 5), (Timer t) async {
      final response = await checkCustomerExist();

      final decode =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      if (decode['status'] == false) {
        setState(() {
          paymentStatus = "Awaiting Payment";
        });
      } else {
        if (decode['data']['subscriptions'].length == 0) {
// Not Subscribed
          setState(() {
            paymentStatus = "Awaiting Payment";
          });
        } else {
//Subscribed
          if (decode['data']['subscriptions'][0]['status'] == "active") {
            //Payed Subscription
            setState(() {
              paymentStatus = "Payment Received";
            });
          } else {
            //No payed subscription
            setState(() {
              paymentStatus = "Awaiting Payment";
            });
          }
        }
      }
    });
  }

  makePayment() async {
    if (widget.paymentType == "Monthly") {
      final Uri a = Uri.parse("https://paystack.com/pay/iwyh4-6wpx");

      launchUrl(a);
      checkSubscription();
    } else {
      final response = await http.post(
        Uri.parse('https://api.paystack.co/transaction/initialize'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer sk_test_216721a21d245ae3b272fcd9b76eeb7e1076d5b7',
        },
        body: jsonEncode(<String, dynamic>{
          'amount': amountToPay * 100,
          'email': email,
          "currency": "ZAR",
          // Add any other data you want to send in the body
        }),
      );

      if (response.statusCode == 200) {
        var t = jsonDecode(response.body);
        print(t['data']['authorization_url']);
        final decode =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        setState(() {
          reference = decode['data']['reference'];
          paymentStatus = "Awaiting payment";
          print('wait');
          afterPaymentMade();
          widget.getPaymentRef(decode['data']['reference']);
        });
        launchUrl((Uri.parse(t['data']['authorization_url'])));
      }
    }
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

  getUserData() async {
    if (widget.email != "") {
      setState(() {
        email = widget.email;
      });
    } else {
      final data = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (data.exists) {
        setState(() {
          email = data.get('email');
        });
      }
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MyUtility(context).width,
          height: MyUtility(context).height * 0.3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey, width: 1.5)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MyUtility(context).width * 0.32,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PaymentTextreu(
                          boldText: 'Application Type',
                          secondText: widget.title),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: PaymentTextreu(
                              boldText: 'Category',
                              secondText: widget.applicationCategory),
                        ),
                      ),
                      PaymentTextreu(
                          boldText: widget.paymentType,
                          secondText: widget.applicationPrice),
                      Text(
                        'Calculated on a pro-rata basis when paying annually',
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.grey[800],
                            letterSpacing: -0.5),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      JournalCheckBox(
                        title: 'Include SA Medical Journal (SAMJ)',
                        onChanged: (bool value) {},
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: widget.paymentType != "Monthly",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PaymentTextPr(
                            boldText: 'Pro-rata Amount',
                            secondText: widget.paymentType != "Monthly"
                                ? getTotalToPay()
                                : widget.applicationPrice,
                          ),
                          PaymentTextPr(
                              boldText: 'For Period',
                              secondText: getTimeFrame()),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "R0",
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                          fontSize: 16,
                          height: 2),
                    ),
                    Column(
                      children: [
                        Text(
                          'Total Due',
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                              fontSize: 16,
                              letterSpacing: -0.5),
                        ),
                        Text(
                          widget.paymentType != "Monthly"
                              ? getTotalToPay()
                              : widget.applicationPrice,
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            width: MyUtility(context).width,
            height: MyUtility(context).height * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey, width: 1.5)),
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              paymnetType = "PAY ONLINE";
                            });
                          },
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                color: paymnetType == "PAY ONLINE"
                                    ? Colors.grey[800]
                                    : Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "PAY ONLINE",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              paymnetType = "DEBIT ORDER";
                            });
                          },
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                color: paymnetType == "DEBIT ORDER"
                                    ? Colors.grey[800]
                                    : Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "DEBIT ORDER",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              getAmountOfMembers();

                              paymnetType = "MANUAL EFT";
                            });
                          },
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                color: paymnetType == "MANUAL EFT"
                                    ? Colors.grey[800]
                                    : Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "MANUAL EFT",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: paymnetType == "PAY ONLINE",
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Pay by Card, Scan to Pay, SnapScan, Eft (Ozow)",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                              Spacer(),
                              PayStackCon(),
                            ],
                          ),
                          Row(
                            children: [
                              StyleButton(
                                  description: "Pay",
                                  height: 55,
                                  width: 125,
                                  onTap: () {
                                    makePayment();
                                  }),
                              Spacer(),
                              Text(
                                paymentStatus,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                        visible: paymnetType == "DEBIT ORDER",
                        child: SizedBox(
                          width: MyUtility(context).width / 2,
                          height: MyUtility(context).height / 5,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Account holder name",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    Spacer(),
                                    PaymentTextField(
                                      hintText: '',
                                      textfieldController: accHolderName,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Name of Bank",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    Spacer(),
                                    PaymentTextField(
                                      hintText: '',
                                      textfieldController: nameOfBank,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Branch name",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    Spacer(),
                                    PaymentTextField(
                                      hintText: '',
                                      textfieldController: branchName,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Branch Code",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    Spacer(),
                                    PaymentTextField(
                                      hintText: '',
                                      textfieldController: branchCode,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Account number",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    Spacer(),
                                    PaymentTextField(
                                      hintText: '',
                                      textfieldController: accNumber,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Account type",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    Spacer(),
                                    PaymentTextField(
                                      hintText: '',
                                      textfieldController: accType,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                JournalCheckBox(
                                  title:
                                      'I, herby request , The South African Mediacl Association to draw againts my account with the\n above metioned bank ( or any other bank or branch to which I may transfer my account), the\n amount necessary for payment of the instalment due for my membership until further notice',
                                  onChanged: (bool value) {
                                    setState(() {
                                      bankDisclaimer.text = "Y";
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                        )),
                    Visibility(
                        visible: paymnetType == "MANUAL EFT",
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "BANKING DETAILS",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                            Text(
                              "Name: The South African Medical Association",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                              ),
                            ),
                            Text(
                              "Bank: Standard Bank, Hatfield",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                              ),
                            ),
                            Text(
                              "Acc. No: 012577332",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                              ),
                            ),
                            Text(
                              "Branch code: 011545",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                              ),
                            ),
                            Text(
                              "Reference: ${debitRef}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        )),
                  ],
                ))),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StyleButton(
                buttonColor: const Color.fromARGB(255, 219, 219, 219),
                description: "PREVIOUS",
                height: 55,
                width: 125,
                onTap: () {
                  widget.nextSection(1);
                }),
            Spacer(),
            Visibility(
              visible: paymnetType == "PAY ONLINE" &&
                  paymentStatus == "Payment Received",
              child: StyleButton(
                  description: "CONTINUE",
                  height: 55,
                  width: 125,
                  onTap: () {
                    widget.getPaymentDetails(paymnetType, widget.title);
                    widget.nextSection(3);
                  }),
            ),
            Visibility(
              visible: paymnetType != "PAY ONLINE",
              child: StyleButton(
                  description: "CONTINUE",
                  height: 55,
                  width: 125,
                  onTap: () {
                    widget.getPaymentDetails(paymnetType, widget.title);
                    widget.getDebitOrder({
                      "bankAccHolder": accHolderName.text,
                      "bankAccNo": accNumber.text,
                      "bankAccType": accType.text,
                      "bankBranchCde": branchCode.text,
                      "bankBranchName": branchName.text,
                      "bankDisclaimer": bankDisclaimer.text,
                      "bankName": nameOfBank.text,
                      "bankPaymAnnual": "",
                      "bankPaymMonthly": "",
                    });
                    widget.nextSection(3);
                  }),
            )
          ],
        )
      ],
    );
  }
}
