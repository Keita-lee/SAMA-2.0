import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class CartProductContainer extends StatefulWidget {
  final List<Widget> productItems;
  const CartProductContainer({super.key, required this.productItems});

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
                  
                  width: MyUtility(context).width * 0.30,
                  child: Text('Product'),
                ),
                Container(
                  
                  width: MyUtility(context).width * 0.115,
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
            child: Column(
              children: widget.productItems,
            ),
          ),
        ),
      ],
    );
  }
}
