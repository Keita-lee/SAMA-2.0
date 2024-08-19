import 'package:flutter/material.dart';
import 'package:sama/member/productDisplay/checkout/ui/billingDetailsForm.dart';
import 'package:sama/member/productDisplay/checkout/ui/yourOrderCon.dart';

class Checkout extends StatefulWidget {
  List products;
  double total;
  Function(int, String) changePageIndex;
  Checkout(
      {super.key,
      required this.products,
      required this.total,
      required this.changePageIndex});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Checkout',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(55, 94, 144, 1)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 35,
          ),
          SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BillingDetailsForm(formKey: _formKey),
                const SizedBox(
                  width: 20,
                ),
                YourOrderCon(
                  formKey: _formKey,
                  products: widget.products,
                  total: widget.total,
                  changePageIndex: widget.changePageIndex,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
