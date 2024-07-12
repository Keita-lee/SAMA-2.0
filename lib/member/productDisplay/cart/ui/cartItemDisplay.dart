import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/components/myutility.dart';

class CartItemDisplay extends StatefulWidget {
  final String productImage;
  final String productName;
  final String productPrice;
  final int qtyWidget;
  final String total;
  const CartItemDisplay(
      {super.key,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.qtyWidget,
      required this.total});

  @override
  State<CartItemDisplay> createState() => _CartItemDisplayState();
}

class _CartItemDisplayState extends State<CartItemDisplay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Row(
        children: [
          SizedBox(
            width: MyUtility(context).width * 0.31,
            child: Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Visibility(
                  visible: widget.productImage == "" ? true : false,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/imageIcon.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: MyUtility(context).width / 15,
                    height: 100,
                  ),
                ),
                Visibility(
                  visible: widget.productImage != "" ? true : false,
                  child: ImageNetwork(
                    fitWeb: BoxFitWeb.cover,
                    image: widget.productImage,
                    width: MyUtility(context).width / 15,
                    height: 100,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productName,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'First copy free for members',
                      style: const TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    Text(
                      widget.productPrice,
                      style: const TextStyle(
                          color: Color.fromRGBO(0, 159, 158, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            width: MyUtility(context).width * 0.11,
            child: Transform.scale(
                scale: 0.8,
                child: Center(
                  child: Text(
                    '${widget.qtyWidget}',
                    style: const TextStyle(
                        color: Color.fromRGBO(0, 159, 158, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                )),
          ),
          SizedBox(
            width: MyUtility(context).width * 0.115,
            child: Center(
              child: Text(
                widget.total,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
