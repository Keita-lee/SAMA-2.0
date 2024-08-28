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
  final List communitiesList;
  String searchText;
  String communityFilter;
  bool waiting;
  CommunityList(
      {super.key,
      required this.changePageIndex,
      required this.communitiesList,
      required this.searchText,
      required this.communityFilter,
      required this.waiting});

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

  // void filterList(List<DocumentSnapshot docs) {

  // }

  @override
  Widget build(BuildContext context) {
    // only show communities where the title contains 'searchTerm'
    List filteredDocuments = widget.communitiesList.where((doc) {
      final title = doc?['title'] as String?;
      return title?.toLowerCase().contains(widget.searchText.toLowerCase()) ??
          false;
    }).toList();

    // Apply type filter if a specific type is selected
    if (widget.communityFilter != 'Show All') {
      filteredDocuments = filteredDocuments
          .where((community) =>
              community['communities'].contains(widget.communityFilter))
          .toList();
    }

    return Container(
      color: Colors.white,
      width: MyUtility(context).width - (MyUtility(context).width * 0.15),
      height: MyUtility(context).height / 2.2,
      child: widget.waiting
          ? const Center(
              child: Text(
              'Loading...',
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
          : filteredDocuments.isEmpty
              ? const Center(child: Text('No communities yet'))
              : ListView.builder(
                  itemCount: filteredDocuments.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Map<String, dynamic> data = filteredDocuments[index];

                    return CommunityListItemStyle(
                      itemColor: (index % 2 == 0)
                          ? Colors.white
                          : const Color.fromARGB(38, 158, 158, 158),
                      title: data["title"] ?? '',
                      type: data["type"] ?? '',
                      isActive: data?['isActive'] == "Active" ? true : false,
                      onTapDelete: () {
                        deleteProduct(data['id']);
                      },
                      onTapEdit: () {
                        if (data["type"] == "PDF") {
                          widget.changePageIndex(1, data['id']);
                        } else if (data["type"] == "TEXT") {
                          widget.changePageIndex(2, data['id']);
                        }
                      },
                      communities: data["communities"],
                    );
                  },
                ),
    );
  }
}
