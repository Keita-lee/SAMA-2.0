import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/member/productDisplay/ui/productDisplayItem.dart';
import 'package:sama/components/myutility.dart';

class ProductListDisplay extends StatefulWidget {
  const ProductListDisplay({super.key});

  @override
  State<ProductListDisplay> createState() => _ProductListDisplayState();
}

class _ProductListDisplayState extends State<ProductListDisplay> {
  List allProduct = [];
  String userType = "";

//Get all products from firebase
  getAllProducts() async {
    setState(() {});
    allProduct.clear();
    final data = await FirebaseFirestore.instance.collection('store').get();
    setState(() {
      for (var i = 0; i < data.docs.length; i++) {
        if (data.docs[i]['isActive']) {
          allProduct.add(data.docs[i]);
        }
      }
    });
  }

  @override
  void initState() {
    getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MyUtility(context).width * 0.75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MyUtility(context).height * 0.08,
            ),
            Text(
              'Products',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 35,
            ),
            for (int i = 0; i < allProduct.length; i++)
              ProductDisplayItem(
                productName: allProduct[i]['name'],
                price: allProduct[i]['memberPrice'],
                priceInfo: 'Member Price. Includes VAT',
                productDescription: allProduct[i]['description'],
                productImage: allProduct[i]['imageUrl'],
              ),
          ],
        ),
      ),
    );
  }
}
