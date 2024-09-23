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
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return Container(
      width:
          isMobile ? MyUtility(context).width : MyUtility(context).width * 0.50,

      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(10),
      //     color: Colors.white,
      //     border: Border.all(
      //         color: Color.fromARGB(255, 212, 210, 210), width: 1.5)),
      child: Padding(
        padding: isMobile
            ? EdgeInsets.all(0)
            : EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                width: MyUtility(context).width / 4,
                height: MyUtility(context).height / 3,
              ),
            ),
            Visibility(
              visible: widget.productImage != "" ? true : false,
              child: ImageNetwork(
                fitWeb: BoxFitWeb.contain,
                image: widget.productImage,
                width: isMobile
                    ? MyUtility(context).width / 2
                    : MyUtility(context).width / 4,
                height: isMobile
                    ? MyUtility(context).width / 2
                    : MyUtility(context).height / 4,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: isMobile
                  ? MyUtility(context).width
                  : MyUtility(context).width * 0.70 - 280,
              height: isMobile ? MyUtility(context).height * 0.14 : 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: isMobile
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    maxLines: null,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: isMobile ? TextAlign.center : null,
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: isMobile
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                      children: [
                        StyleButton(
                            fontSize: isMobile ? 16 : 13,
                            description: 'View Options',
                            height: isMobile ? 65 : 40,
                            width: 110,
                            buttonTextColor: Colors.white,
                            buttonColor: Color.fromRGBO(0, 159, 159, 1),
                            onTap: () {
                              // final Uri a = Uri.parse(widget.downloadLink);
                              // launchUrl(a);
                              widget.readMore();
                            }),
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
