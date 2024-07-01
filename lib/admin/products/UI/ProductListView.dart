import 'package:flutter/material.dart';
import 'package:sama/admin/products/Model/ProductItem.dart';
import 'package:sama/admin/products/UI/productListItem.dart';
import 'package:sama/components/myutility.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width * 0.60,
      height: MyUtility(context).height * 0.30,
      child: ListView.builder(
          itemCount: ProductItems.length,
          itemBuilder: (context, index) {
            return ProductListItem(
              itemColor: (index % 2 == 0) ? Colors.white : const Color.fromARGB(38, 158, 158, 158),
                title: ProductItems[index].productTitle,
                type: ProductItems[index].productType);
          }),
    );
  }
}
