import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/member/productDisplay/cart/ui/payStackCon.dart';
import 'package:sama/member/productDisplay/checkout/yourOrderTable/yourOrderTable.dart';

class YourOrderCon extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const YourOrderCon({super.key, required this.formKey});

  @override
  State<YourOrderCon> createState() => _YourOrderConState();
}

class _YourOrderConState extends State<YourOrderCon> {
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
                YourOrderTable(orderProduct: [])
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
            if (widget.formKey.currentState?.validate() ?? false) {
              // ADD LOGIC
            } else {
              // ADD LOGIC
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
      ],
    );
  }
}
