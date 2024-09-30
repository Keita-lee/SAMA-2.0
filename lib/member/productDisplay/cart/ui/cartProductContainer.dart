import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/utils/cartUtils.dart';

import 'cartItemDisplay.dart';

class CartProductContainer extends StatefulWidget {
  final List productItems;
  final Function(String) delete;
  final Function(String, int, String?) manageProductList;
  CartProductContainer(
      {super.key,
      required this.productItems,
      required this.manageProductList,
      required this.delete});

  @override
  State<CartProductContainer> createState() => _CartProductContainerState();
}

class _CartProductContainerState extends State<CartProductContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MyUtility(context).width * 0.55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            border: Border.all(
              color: Color(0xFFD1D1D1),
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Container(
                  width: MyUtility(context).width * 0.3,
                  child: Text('Product'),
                ),
                Container(
                  width: MyUtility(context).width * 0.11,
                  child: Center(
                    child: Text('Qty'),
                  ),
                ),
                Container(
                  width: MyUtility(context).width * 0.115,
                  child: Center(
                    child: Text('Total'),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MyUtility(context).width * 0.55,
          height: MyUtility(context).height * 0.60,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Color(0xFFD1D1D1),
                width: 1.5,
              ),
              bottom: BorderSide(
                color: Color(0xFFD1D1D1),
                width: 1.5,
              ),
              right: BorderSide(
                color: Color(0xFFD1D1D1),
                width: 1.5,
              ),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(children: [
              for (int i = 0; i < (widget.productItems).length; i++)
                CartItemDisplay(
                    delete: widget.delete,
                    manageProductList: widget.manageProductList,
                    productImage: widget.productItems[i]['productImage'],
                    productName: widget.productItems[i]['name'],
                    productPrice: widget.productItems[i]['productPrice'],
                    qtyWidget: widget.productItems[i]['quantity'],
                    total: widget.productItems[i]['total']),
            ]),
          ),
        ),
      ],
    );
  }
}
