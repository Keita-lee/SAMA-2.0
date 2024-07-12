import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/productDisplay/cart/ui/cartItemDisplay.dart';
import 'package:sama/member/productDisplay/cart/ui/cartProductContainer.dart';
import 'package:sama/member/productDisplay/cart/ui/cartTotalContainer.dart';
import 'package:sama/member/productDisplay/cart/ui/quantityWidget.dart';
import 'package:sama/member/productDisplay/ui/digitalQuantityWidget.dart';

List<Widget> cartProducts = [
  CartItemDisplay(
      productImage: '',
      productName: 'South African Medicines Formulary',
      productPrice: 'R 1020.00',
      qtyWidget: QuantityWidget(),
      total: 'R 1020.00'),
  CartItemDisplay(
      productImage: '',
      productName: 'South African Medicines Formulary',
      productPrice: 'R 1020.00',
      qtyWidget: QuantityWidget(),
      total: 'R 1020.00'),
];

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 80, top: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Cart',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(55, 94, 144, 1)),
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CartProductContainer(
                  productItems: [
                    CartItemDisplay(
                        productImage: '',
                        productName: 'South African Medicines Formulary',
                        productPrice: 'R 1020.00',
                        qtyWidget: QuantityWidget(),
                        total: 'R 1020.00'),
                    CartItemDisplay(
                        productImage: '',
                        productName: 'South African Medicines Formulary',
                        productPrice: 'R 1020.00',
                        qtyWidget: QuantityWidget(),
                        total: 'R 1020.00'),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                CartTotalContainer(cartTotal: 'R 3 060.00')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
