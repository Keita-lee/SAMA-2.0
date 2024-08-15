import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/admin/products/UI/myProductButtons.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/utils/quillUtils.dart';

import '../../../components/styleButton.dart';

class ProductDisplayItem extends StatefulWidget {
  final String productName;
  final String productDescription;
  final String price;
  final String priceInfo;
  final String productImage;
  VoidCallback readMore;
  VoidCallback buyProduct;
  ProductDisplayItem(
      {super.key,
      required this.productName,
      required this.price,
      required this.priceInfo,
      required this.productDescription,
      required this.productImage,
      required this.readMore,
      required this.buyProduct});

  @override
  State<ProductDisplayItem> createState() => _ProductDisplayItemState();
}

class _ProductDisplayItemState extends State<ProductDisplayItem> {
  bool isDigital = true;
  var myJSON;
  QuillController quillController = QuillController.basic();

  @override
  void initState() {
    quillController = handleDescription(widget.productDescription, true, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width * 0.70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
              color: Color.fromARGB(255, 212, 210, 210), width: 1.5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: widget.productImage == "" ? true : false,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/imageIcon.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                width: 180,
                height: 180,
              ),
            ),
            Visibility(
              visible: widget.productImage != "" ? true : false,
              child: ImageNetwork(
                fitWeb: BoxFitWeb.contain,
                image: widget.productImage,
                width: 180,
                height: 180,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Container(
              width: MyUtility(context).width * 0.70 - 280,
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
                  /*  SizedBox(
                    width: MyUtility(context).width / 3.5,
                    height: 30,
                    child: Text(
                      widget.productDescription,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),*/
                  Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'R ${widget.price}',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.teal),
                          ),
                          Text(
                            widget.priceInfo,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      StyleButton(
                          fontSize: 13,
                          description: 'Read More',
                          height: 40,
                          width: 110,
                          buttonTextColor: Colors.black,
                          buttonColor: Color.fromARGB(255, 212, 210, 210),
                          onTap: () {
                            widget.readMore();
                          }),
                      const SizedBox(
                        width: 15,
                      ),
                      Visibility(
                        visible: isDigital,
                        child: StyleButton(
                          fontSize: 13,
                          buttonColor: Colors.teal,
                          description: 'Buy Now',
                          height: 40,
                          width: 100,
                          onTap: () {
                            widget.buyProduct();
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
