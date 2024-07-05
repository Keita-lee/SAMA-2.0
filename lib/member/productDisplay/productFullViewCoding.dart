import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/member/productDisplay/ui/ProductFullView.dart';
import 'package:sama/member/productDisplay/ui/codingQuantityWidget.dart';
import 'package:sama/member/productDisplay/ui/digitalQuantityWidget.dart';
import 'package:sama/components/myutility.dart';

class ProductFullViewCoding extends StatefulWidget {
  String title;
  String price;
  String priceInfo;

  String description;
  String productImage;

  ProductFullViewCoding(
      {super.key,
      required this.title,
      required this.price,
      required this.priceInfo,
      required this.description,
      required this.productImage});

  @override
  State<ProductFullViewCoding> createState() => _ProductFullViewCodingState();
}

class _ProductFullViewCodingState extends State<ProductFullViewCoding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
                price: widget.price,
                priceInfo: widget.priceInfo,
                qtyWidget: CodingQuantityWidget(),
                productImage: widget.productImage,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                widget.description,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
