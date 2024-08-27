import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../components/myutility.dart';
import 'ui/cpdHeader.dart';
import 'ui/cpdListItem.dart';

class CpdList extends StatefulWidget {
  Function(
    int,
    String,
  ) changePageIndex;
  CpdList({super.key, required this.changePageIndex});

  @override
  State<CpdList> createState() => _CpdListState();
}

class _CpdListState extends State<CpdList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CpdHeader(),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('cpd').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              width:
                  MyUtility(context).width - (MyUtility(context).width * 0.25),
              height: MyUtility(context).height / 2.2,
              child: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (BuildContext context, int index) {
                  final DocumentSnapshot document = documents[index];
                  final data = document.data() as Map<String, dynamic>?;

                  return CpdListItem(
                    itemColor: (index % 2 == 1)
                        ? Colors.white
                        : const Color.fromARGB(38, 158, 158, 158),
                    title: data?["title"] ?? '',
                    isActive: data?['isActive'] == "Active" ? true : false,
                    onTapDelete: () {
                      //deleteProduct(document.id);
                    },
                    onTapEdit: () {
                      widget.changePageIndex(1, document.id);
                    },
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
