import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/login/membershipCategory/pages/ui/PaymentTextReu.dart';

import '../../../components/styleButton.dart';
import '../../../member/productDisplay/cart/ui/payStackCon.dart';
import 'ui/paymentTextField.dart';

class PaymentMethod extends StatefulWidget {
  String title;
  String applicationPrice;
  Function(int) nextSection;
  String applicationCategory;
  PaymentMethod(
      {super.key,
      required this.title,
      required this.applicationPrice,
      required this.nextSection,
      required this.applicationCategory});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  bool isChecked = false;
  var paymnetType = "";

  final accHolderName = TextEditingController(text: '');
  final nameOfBank = TextEditingController(text: '');
  final branchName = TextEditingController(text: '');
  final branchCode = TextEditingController(text: '');
  final accNumber = TextEditingController(text: '');
  final accType = TextEditingController(text: '');
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
                      PaymentTextreu(boldText: 'Annual', secondText: 'R4584'),
                      Text(
                        'Calculated on a pro-rata basis when payng annually',
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
                    Column(
                      children: [
                        PaymentTextPr(
                            boldText: 'Pro-rata Amount',
                            secondText: widget.applicationPrice),
                        PaymentTextPr(
                            boldText: 'For Period',
                            secondText: 'Aug 2024 - Dec 2024'),
                      ],
                    ),
                    Text(
                      'R887',
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                          fontSize: 16,
                          letterSpacing: -0.5),
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
                          'R1490',
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                              fontSize: 16,
                              letterSpacing: -0.5),
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
                      child: Row(
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
                                  onChanged: (bool value) {},
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
                              "N.B. Email proof of paymnets to emailaddres@tobeconfirmed",
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
            StyleButton(
                description: "CONTINUE",
                height: 55,
                width: 125,
                onTap: () {
                  widget.nextSection(3);
                })
          ],
        )
      ],
    );
  }
}
