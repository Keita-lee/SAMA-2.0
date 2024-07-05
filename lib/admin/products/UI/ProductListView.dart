import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/products/Model/ProductItem.dart';
import 'package:sama/admin/products/UI/productListItem.dart';
import 'package:sama/admin/products/productAdd&EditPages/productEditPage.dart';
import 'package:sama/components/myutility.dart';

class ProductListView extends StatefulWidget {
  Function(
    int,
    String,
  ) changePageIndex;
  ProductListView({super.key, required this.changePageIndex});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  Future<void> deleteProduct(String productId) async {
    await FirebaseFirestore.instance
        .collection('store')
        .doc(productId)
        .delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product deleted successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('store').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: snapshot error');
        }
        if (!snapshot.hasData) {
          return const Text('Loading...');
        }

        final List<DocumentSnapshot> documents = snapshot.data!.docs;
        if (documents.isEmpty) {
          return Center(child: Text('No class yet'));
        }

        return Container(
          color: Colors.white,
          width: MyUtility(context).width - (MyUtility(context).width * 0.25),
          height: MyUtility(context).height / 2.2,
          child: ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              final DocumentSnapshot document = documents[index];
              final data = document.data() as Map<String, dynamic>?;

              return ProductListItem(
                itemColor: (index % 2 == 0)
                    ? Colors.white
                    : const Color.fromARGB(38, 158, 158, 158),
                title: data?["name"] ?? '',
                type: data?["type"] ?? '',
                isActive: data?['isActive'] ?? false,
                onTapDelete: () {
                  deleteProduct(document.id);
                },
                onTapEdit: () {
                  widget.changePageIndex(1, document.id);
                },
              );
            },
          ),
        );
      },
    );
  }
}
