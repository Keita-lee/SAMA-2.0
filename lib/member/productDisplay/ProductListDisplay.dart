import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/member/productDisplay/productFullViewCoding.dart';
import 'package:sama/member/productDisplay/productFullViewDigital.dart';
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
  int pageIndex = 0;
  String productType = "";
  String title = "";
  String price = "";
  String priceInfo = "";
  String description = "";
  String productImage = "";

  changePageIndex(value, type) {
    setState(() {
      pageIndex = value;
      productType = type;
    });
  }

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MyUtility(context).height * 0.08,
              ),
              Visibility(
                visible: pageIndex == 0 ? true : false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Products',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
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
                        readMore: () {
                          changePageIndex(1, allProduct[i]['type']);
                          setState(() {
                            title = allProduct[i]['name'];
                            price = allProduct[i]['memberPrice'];
                            priceInfo = 'Member Price. Includes VAT';
                            description = allProduct[i]['description'];
                            productImage = allProduct[i]['imageUrl'];
                          });
                        },
                      ),
                  ],
                ),
              ),
              Visibility(
                  visible: pageIndex == 1 && productType == "Digital Product"
                      ? true
                      : false,
                  child: ProductFullViewDigital(
                    title: title,
                    price: price,
                    priceInfo: priceInfo,
                    description: description,
                    productImage: productImage,
                    changePageIndex: changePageIndex,
                  )),
              Visibility(
                visible: pageIndex == 1 && productType == "Coding Product"
                    ? true
                    : false,
                child: ProductFullViewCoding(
                  title: title,
                  price: price,
                  priceInfo: priceInfo,
                  description: description,
                  productImage: productImage,
                  changePageIndex: changePageIndex,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
