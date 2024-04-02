import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/centerOfExcellence/CenterOfExcellenceDialog.dart';
import 'package:sama/components/styleButton.dart';

class CenterOfExcellenceList extends StatefulWidget {
  const CenterOfExcellenceList({super.key});

  @override
  State<CenterOfExcellenceList> createState() => _CenterOfExcellenceListState();
}

class _CenterOfExcellenceListState extends State<CenterOfExcellenceList> {
  @override
  Widget build(BuildContext context) {
    BuildContext? dialogContext;
    //Dialog for benifits
    Future openArticleDialog(id) => showDialog(
        context: context,
        builder: (context) {
          dialogContext = context;
          return Dialog(
              child: CenterOfExcellenceDialog(
                  id: id, closeDialog: () => Navigator.pop(dialogContext!)));
        });

    return Column(
      children: [
        Row(
          children: [
            Spacer(),
            StyleButton(
                description: "Add Article",
                height: 55,
                width: 125,
                onTap: () {
                  openArticleDialog("");
                })
          ],
        ),
         StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('articles')
          
            .snapshots(),
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
            width: 500,
            height: 500,
            //color: Colors.transparent,
            child: ListView.builder(
              itemCount: documents.length,
              itemBuilder: (BuildContext context, int index) {
                final DocumentSnapshot document = documents[index];
                return GestureDetector(
                  onTap: (){openArticleDialog(document['id']);},
                  child: Container(
                  
                    child: Row(children: [
                       Text(
                                document['title'],
                                style: TextStyle(fontSize: 18, color: Colors.black),
                       ),
                          Spacer(),
                                 Text(
                                document['status'],
                                style: TextStyle(fontSize: 18, color: Colors.black),),
                       
                    ],),
                  ),
                );},),);

        })
      ],
    );
  }
}
