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
  Function(double, List) getTotal;
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

  manageProductList(String productName, int quantity, String? newPrice) async {
    List<Map<String, dynamic>> cart =
        await updateProductQuantity(productName, quantity, newPrice);

    // var productIndex = (cart).indexWhere((item) => item["name"] == productName);
    // cart[productIndex]['quantity'] = quantity;
    // cart[productIndex]['total'] =
    //     '${double.parse(cart[productIndex]['price']) * quantity}';

    setState(() {
      total = 0.0;
      for (int i = 0; i < cart.length; i++) {
        double newProductTotal = 0.0;
        List<String> cartTotal = List.from(cart[i]['total']);
        print('total ${cart[i]['total']}');
        if (cart[i]['total'].isNotEmpty) {
          newProductTotal += cartTotal
              .map((s) => double.parse(s))
              .reduce((val, acc) => val + acc);
          total += newProductTotal;
          cart[i]['total'] = newProductTotal.toStringAsFixed(2);
        }
      }
      widget.getTotal(total, cart);
      productList = cart;
    });
    print('total in cartPage: $total');
  }

  @override
  void initState() {
    getCartProducts();
    super.initState();
  }

  getCartProducts() async {
    try {
      List cart = await getCart();
      double newTotal = 0.0;
      for (int i = 0; i < cart.length; i++) {
        double newProductTotal = 0.0;
        List<String> cartTotal = List.from(cart[i]['total']);
        print('total ${cart[i]['total']}');
        if (cart[i]['total'].isNotEmpty) {
          newProductTotal = cartTotal
              .map((s) => double.parse(s))
              .reduce((val, acc) => val + acc);
          newTotal += newProductTotal;
          cart[i]['total'] = newProductTotal.toStringAsFixed(2);
        }
      }
      total = newTotal;
      widget.getTotal(total, cart);

      setState(() {
        productList = cart;
      });
    } catch (e) {
      print('error: $e');
    }
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
                  cartTotal: 'R ${total.toStringAsFixed(2)}',
                  changePageIndex: widget.changePageIndex)
            ],
          ),
        ),
      ],
    );
  }
}
