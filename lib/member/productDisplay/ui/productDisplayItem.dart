import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/admin/products/UI/myProductButtons.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/utils/quillUtils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/styleButton.dart';

class ProductDisplayItem extends StatefulWidget {
  final String productName;
  final String productDescription;
  final String price;
  final String priceInfo;
  final String productImage;
  final String downloadLink;
  VoidCallback readMore;
  VoidCallback buyProduct;

  ProductDisplayItem(
      {super.key,
      required this.productName,
      required this.price,
      required this.priceInfo,
      required this.productDescription,
      required this.productImage,
      required this.downloadLink,
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
      width: MyUtility(context).width * 0.50,
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(10),
      //     color: Colors.white,
      //     border: Border.all(
      //         color: Color.fromARGB(255, 212, 210, 210), width: 1.5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
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
                width: MyUtility(context).width * 0.2,
                height: MyUtility(context).width * 0.18,
              ),
            ),
            Visibility(
              visible: widget.productImage != "" ? true : false,
              child: ImageNetwork(
                fitWeb: BoxFitWeb.contain,
                image: widget.productImage,
                width: MyUtility(context).width * 0.2,
                height: MyUtility(context).width * 0.18,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MyUtility(context).width * 0.70 - 280,
              height: 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    maxLines: null,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Container(
                  //   width: MyUtility(context).width / 1.5,
                  //   height: 55,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //   ),
                  //   child: QuillEditor.basic(
                  //     configurations: QuillEditorConfigurations(
                  //       controller: quillController,
                  //       sharedConfigurations: const QuillSharedConfigurations(),
                  //     ),
                  //   ),
                  // ),
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
                  // Spacer(),
                  SizedBox(height: 20),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   mainAxisSize: MainAxisSize.max,
                        //   children: [
                        //     Text(
                        //       'R ${widget.price}',
                        //       style: const TextStyle(
                        //           fontSize: 20, color: Colors.teal),
                        //     ),
                        //     Text(
                        //       widget.priceInfo,
                        //       style: const TextStyle(
                        //         fontSize: 13,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        //Spacer(),

                        StyleButton(
                            fontSize: 13,
                            description: 'View Options',
                            height: 40,
                            width: 110,
                            buttonTextColor: Colors.white,
                            buttonColor: Color.fromRGBO(0, 159, 159, 1),
                            onTap: () {
                              final Uri a = Uri.parse(widget.downloadLink);

                              launchUrl(a);
                              // widget.readMore();
                            }),
                        // const SizedBox(
                        //   width: 15,
                        // ),
                        // Visibility(
                        //   visible: isDigital,
                        //   child: StyleButton(
                        //     fontSize: 13,
                        //     buttonColor: Colors.teal,
                        //     description: 'Buy Now',
                        //     height: 40,
                        //     width: 100,
                        //     onTap: () {
                        //       widget.buyProduct();
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
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
