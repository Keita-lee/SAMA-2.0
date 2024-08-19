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
  Function(int, String) changePageIndex;
  Function(double) getTotal;
  CartPage(
      {super.key,
      required this.products,
      required this.changePageIndex,
      required this.getTotal});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double total = 0;
  List productList = [];

  manageProductList(
    productName,
    quantity,
  ) {
    setState(() {
      total = 0;
      var productIndex =
          (productList).indexWhere((item) => item["name"] == productName);

      productList[productIndex]['quantity'] = quantity;

      productList[productIndex]['total'] =
          '${double.parse(productList[productIndex]['price']) * quantity}';

      for (int i = 0; i < widget.products.length; i++) {
        print(widget.products[i]['total']);
        total = total + double.parse(widget.products[i]['total']);

        widget.getTotal(total + double.parse(widget.products[i]['total']));
      }
    });
  }

  @override
  void initState() {
    productList.addAll(widget.products);
    for (int i = 0; i < widget.products.length; i++) {
      print(widget.products[i]['total']);
      total = total + double.parse(widget.products[i]['total']);
    }

    super.initState();
    //
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'My Cart',
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
              CartProductContainer(
                  productItems: productList,
                  manageProductList: manageProductList),
              const SizedBox(
                width: 20,
              ),
              CartTotalContainer(
                  products: productList,
                  cartTotal: 'R $total',
                  changePageIndex: widget.changePageIndex)
            ],
          ),
        ),
      ],
    );
  }
}
