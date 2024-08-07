import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:sama/member/productDisplay/ui/ProductFullView.dart';
import 'package:sama/member/productDisplay/ui/digitalQuantityWidget.dart';
import 'package:sama/components/myutility.dart';

class ProductFullViewDigital extends StatefulWidget {
  String title;
  String price;
  String priceInfo;

  String description;
  String productImage;

  Function(int, String) changePageIndex;
  Function(Map, int) buyProduct;
  Function(String, int) getProductQuantity;
  int productQuantity;

  ProductFullViewDigital({
    super.key,
    required this.title,
    required this.price,
    required this.priceInfo,
    required this.description,
    required this.productImage,
    required this.changePageIndex,
    required this.buyProduct,
    required this.productQuantity,
    required this.getProductQuantity,
  });

  @override
  State<ProductFullViewDigital> createState() => _ProductFullViewDigitalState();
}

class _ProductFullViewDigitalState extends State<ProductFullViewDigital> {
  var myJSON;
  QuillController quillController = QuillController.basic();
  var product = {};

  @override
  void initState() {
    myJSON = jsonDecode(widget.description);
    quillController = QuillController(
        readOnly: true,
        document: Document.fromJson(myJSON),
        selection: TextSelection.collapsed(offset: 0));
    super.initState();
    product = {
      "name": widget.title,
      "productPrice": 'Member Price. Includes VAT',
      "quantity": widget.productQuantity,
      "price": widget.price,
      "id": "",
      "imageUrl": widget.productImage,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MyUtility(context).width * 0.70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MyUtility(context).height * 0.08,
            ),
            ProductFullView(
                productTitle: widget.title,
                price: "R ${widget.price}",
                priceInfo: widget.priceInfo,
                productQuantity: widget.productQuantity,
                qtyWidget: DigitalQuantityWidget(
                  productQuantity: widget.productQuantity,
                  getProductQuantity: widget.getProductQuantity,
                  title: widget.title,
                ),
                productImage: widget.productImage,
                changePageIndex: widget.changePageIndex,
                buyProduct: widget.buyProduct,
                product: product),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: MyUtility(context).width / 1.5,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: QuillEditor.basic(
                configurations: QuillEditorConfigurations(
                  controller: quillController,
                  sharedConfigurations: const QuillSharedConfigurations(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
