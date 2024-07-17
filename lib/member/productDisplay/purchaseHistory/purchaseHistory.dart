import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/service/commonService.dart';
import 'package:sama/components/styleButton.dart';

import 'ui/hitoryProductDisplay.dart';

class PurchaseHistory extends StatefulWidget {
  Function(int, String) changePageIndex;
  PurchaseHistory({super.key, required this.changePageIndex});

  @override
  State<PurchaseHistory> createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  List allProducts = [];

  //Get all products from user previously
  getAllProductsFromUser() async {
    setState(() {});
    allProducts.clear();
    final data = await FirebaseFirestore.instance
        .collection('storeHistory')
        .where("user", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      for (var i = 0; i < data.docs.length; i++) {
        allProducts.add(data.docs[i]);
      }
    });
  }

  @override
  void initState() {
    getAllProductsFromUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'E-Store',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              StyleButton(
                  description: "View Products",
                  height: 55,
                  width: 125,
                  onTap: () {
                    widget.changePageIndex(0, "");
                  })
            ],
          ),
          SizedBox(
            height: 35,
          ),
          for (int i = 0; i < allProducts.length; i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: HistoryProductDisplay(
                products: allProducts[i]["products"],
                date: "${CommonService().getTodaysDateText()}",
              ),
            ),
        ],
      ),
    );
  }
}
