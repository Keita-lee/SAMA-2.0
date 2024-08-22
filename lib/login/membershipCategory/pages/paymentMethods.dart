import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/login/membershipCategory/pages/ui/PaymentTextReu.dart';

import '../../../components/styleButton.dart';

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
