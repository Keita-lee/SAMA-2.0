import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/productDisplay/cart/ui/cartItemDisplay.dart';
import 'package:sama/member/productDisplay/cart/ui/cartProductContainer.dart';
import 'package:sama/member/productDisplay/cart/ui/cartTotalContainer.dart';
import 'package:sama/member/productDisplay/cart/ui/quantityWidget.dart';
import 'package:sama/member/productDisplay/ui/digitalQuantityWidget.dart';

/*
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
*/
class CartPage extends StatefulWidget {
  List products;
  CartPage({super.key, required this.products});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double total = 0;

  @override
  void initState() {
    for (int i = 0; i < widget.products.length; i++) {
      print(widget.products[i]['total']);
      total = total + double.parse(widget.products[i]['total']);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'My Cart',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(55, 94, 144, 1)),
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
              CartProductContainer(productItems: widget.products),
              const SizedBox(
                width: 20,
              ),
              CartTotalContainer(
                  products: widget.products, cartTotal: 'R $total')
            ],
          ),
        ),
      ],
    );
  }
}
