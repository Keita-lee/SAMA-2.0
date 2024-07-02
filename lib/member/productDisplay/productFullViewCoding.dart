import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/member/productDisplay/ui/ProductFullView.dart';
import 'package:sama/member/productDisplay/ui/codingQuantityWidget.dart';
import 'package:sama/member/productDisplay/ui/digitalQuantityWidget.dart';
import 'package:sama/components/myutility.dart';

class ProductFullViewCoding extends StatefulWidget {
  const ProductFullViewCoding({super.key});

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
                  productTitle:
                      'Electronic Medical Doctors Coding \nManual',
                  price: 'R 0.00',
                  priceInfo: 'First license free for members',
                  qtyWidget: CodingQuantityWidget()),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Published bt the South African Medical Association, the South African Medicines Formulary is researched and written by members of the Division of Clinical Pharmacology of the University of Cape Town, in collaboration with health care Professional.\n\n The formulary is aimed at doctors, pharmacists, nurses, dentists and others concerned with the safe and cost-effective prescribing of medicines',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
