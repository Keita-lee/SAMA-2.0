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
  String searchText;
  String productTypeText;
  ProductListView(
      {super.key,
      required this.changePageIndex,
      required this.searchText,
      required this.productTypeText});

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

  checkSearchResults(data) {
    if (widget.searchText == "") {
      return true;
    } else if ((widget.searchText).toLowerCase().contains((data['name']))) {
      return true;
    }
    return false;
  }

  checkTypeResults(data) {
    if (widget.productTypeText != null) {
      if (widget.productTypeText == "" || widget.productTypeText == "All") {
        return true;
      } else if (widget.productTypeText!.contains(data['type'])) {
        return true;
      }
    }

    return false;
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

              return Visibility(
                visible: checkSearchResults(data),
                child: Visibility(
                  visible: checkTypeResults(data),
                  child: ProductListItem(
                    itemColor: (index % 2 == 0)
                        ? Colors.white
                        : const Color.fromARGB(38, 158, 158, 158),
                    title: data?["name"] ?? '',
                    type: data?["type"] ?? '',
                    isActive: data?['isActive'] == "Active" ? true : false,
                    onTapDelete: () {
                      deleteProduct(document.id);
                    },
                    onTapEdit: () {
                      if (data?["type"] == "Physical Product") {
                        widget.changePageIndex(3, document.id);
                      } else if (data?["type"] == "Digital Product") {
                        widget.changePageIndex(4, document.id);
                      } else {
                        widget.changePageIndex(5, document.id);
                      }
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
