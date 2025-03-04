import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/components/myutility.dart';

import '../../ui/digitalQuantityWidget.dart';

class CartItemDisplay extends StatefulWidget {
  final Function(String, int, String?) manageProductList;
  final String productImage;
  final String productName;
  final String productPrice;
  final int qtyWidget;
  final String total;
  final Function(String) delete;
  const CartItemDisplay(
      {super.key,
      required this.manageProductList,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.qtyWidget,
      required this.total,
      required this.delete});

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
                    fitWeb: BoxFitWeb.contain,
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
                    SizedBox(
                      width: MyUtility(context).width / 5,
                      child: Text(
                        widget.productName,
                        maxLines: null,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    Text(
                      'Price includes VAT',
                      style: const TextStyle(
                          color: Color.fromRGBO(0, 159, 158, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            width: MyUtility(context).width * 0.115,
            child: Center(
              child: DigitalQuantityWidget(
                productQuantity: widget.qtyWidget,
                getProductQuantityCheckout: widget.manageProductList,
                title: widget.productName,
                canDelete: true,
                deleteProduct: widget.delete,
              ),
              // child: Text(
              //   widget.qtyWidget.toString(),
              //   style:
              //       const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              // ),
            ),
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
          // SizedBox(
          //   width: MyUtility(context).width * 0.05,
          //   child: Center(
          //     child: IconButton(
          //         onPressed: () {
          //           widget.delete(widget.productName);
          //         },
          //         icon: const Icon(
          //           Icons.delete,
          //           color: Colors.red,
          //         )),
          //   ),
          // ),
        ],
      ),
    );
  }
}
