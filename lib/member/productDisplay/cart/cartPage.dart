import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/productDisplay/cart/ui/cartItemDisplay.dart';
import 'package:sama/member/productDisplay/cart/ui/cartProductContainer.dart';
import 'package:sama/member/productDisplay/cart/ui/cartTotalContainer.dart';
import 'package:sama/member/productDisplay/cart/ui/quantityWidget.dart';
import 'package:sama/member/productDisplay/ui/digitalQuantityWidget.dart';
import 'package:sama/utils/cartUtils.dart';

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
  Function(String) delete;
  CartPage(
      {super.key,
      required this.products,
      required this.changePageIndex,
      required this.getTotal,
      required this.delete});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double total = 0;
  List productList = [];

  manageProductList(
    productName,
    quantity,
  ) async {
    await updateProductQuantity(productName, quantity);
    List cart = await getCart();
    setState(() {
      productList = cart;
      total = 0;
      var productIndex =
          (cart).indexWhere((item) => item["name"] == productName);

      cart[productIndex]['quantity'] = quantity;

      cart[productIndex]['total'] =
          '${double.parse(cart[productIndex]['price']) * quantity}';

      for (int i = 0; i < cart.length; i++) {
        print('total ${cart[i]['total']}');
        total = total + double.parse(cart[i]['total']);
      }

      widget.getTotal(total);
    });
  }

  @override
  void initState() {
    getCartProducts();

    super.initState();
    //
  }

  getCartProducts() async {
    List cart = await getCart();
    var newTotal = 0.0;
    for (int i = 0; i < cart.length; i++) {
      print(cart[i]['total']);
      newTotal += double.parse(cart[i]['total']);
    }
    total = newTotal;
    widget.getTotal(total);

    setState(() {
      productList = cart;
    });
  }

  void deleteProduct(String productName) async {
    await widget.delete(productName);
    await getCartProducts();
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
                  delete: deleteProduct,
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
