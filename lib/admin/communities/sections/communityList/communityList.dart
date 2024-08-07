import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/products/Model/ProductItem.dart';
import 'package:sama/admin/products/UI/productListItem.dart';
import 'package:sama/admin/products/productAdd&EditPages/productEditPage.dart';
import 'package:sama/components/myutility.dart';

import 'ui/communityListItemStyle.dart';

class CommunityList extends StatefulWidget {
  Function(
    int,
    String,
  ) changePageIndex;
  CommunityList({super.key, required this.changePageIndex});

  @override
  State<CommunityList> createState() => _CommunityListState();
}

class _CommunityListState extends State<CommunityList> {
  Future<void> deleteProduct(String productId) async {
    await FirebaseFirestore.instance
        .collection('communities')
        .doc(productId)
        .delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Community deleted successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('communities').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: snapshot error');
        }
        if (!snapshot.hasData) {
          return const Text('Loading...');
        }

        final List<DocumentSnapshot> documents = snapshot.data!.docs;
        if (documents.isEmpty) {
          return Center(child: Text('No communities yet'));
        }

        return Container(
          color: Colors.white,
          width: MyUtility(context).width - (MyUtility(context).width * 0.15),
          height: MyUtility(context).height / 2.2,
          child: ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              final DocumentSnapshot document = documents[index];
              final data = document.data() as Map<String, dynamic>?;

              return CommunityListItemStyle(
                itemColor: (index % 2 == 0)
                    ? Colors.white
                    : const Color.fromARGB(38, 158, 158, 158),
                title: data?["title"] ?? '',
                type: data?["type"] ?? '',
                isActive: data?['isActive'] == "Active" ? true : false,
                onTapDelete: () {
                  deleteProduct(document.id);
                },
                onTapEdit: () {
                  if (data?["type"] == "PDF") {
                    widget.changePageIndex(1, document.id);
                  } else if (data?["type"] == "TEXT") {
                    widget.changePageIndex(2, document.id);
                  }
                },
                communities: data?["communities"],
              );
            },
          ),
        );
      },
    );
  }
}
