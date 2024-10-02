import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (auth.currentUser != null) {
      _getDetails();
    }
  }

  void _getDetails() async {
    try {
      User user = auth.currentUser!;

      QuerySnapshot userDetails = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user.email)
          .get();
      if (userDetails.docs.isNotEmpty) {
        setState(() {
          firstNameController.text = userDetails.docs[0]['firstName'];
          lastNameController.text = userDetails.docs[0]['lastName'];
          emailController.text = user.email!;
        });
      }
    } catch (e) {
      print('error getting user details: $e');
    }
  }

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
                BillingDetailsForm(
                  formKey: _formKey,
                  emailController: emailController,
                  firstNameController: firstNameController,
                  lastNameController: lastNameController,
                ),
                const SizedBox(
                  width: 20,
                ),
                YourOrderCon(
                  formKey: _formKey,
                  products: widget.products,
                  total: widget.total,
                  changePageIndex: widget.changePageIndex,
                  email: emailController,
                  name:
                      '${firstNameController.text} ${firstNameController.text}',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
