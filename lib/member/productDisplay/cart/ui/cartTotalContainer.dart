import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/products/UI/myProductButtons.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/productDisplay/cart/ui/payStackCon.dart';

class CartTotalContainer extends StatefulWidget {
  final String cartTotal;
  const CartTotalContainer({super.key, required this.cartTotal});

  @override
  State<CartTotalContainer> createState() => _CartTotalContainerState();
}

class _CartTotalContainerState extends State<CartTotalContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 365,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color(0xFFD1D1D1),
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    
                    Text(
                      widget.cartTotal,
                      style: const TextStyle(
                          color: Color.fromRGBO(0, 159, 158, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                Text(
                  'Inclusive of VAT. Placeholder text for any other related info.',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 50,),
                InkWell(
                  onTap: () {
                    
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromRGBO(0, 159, 158, 1),
                      
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 18),
                        child: Text(
                          'Checkout',
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
                const SizedBox(height: 15,),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15,),
        PayStackCon()
      ],
    );
  }
}
