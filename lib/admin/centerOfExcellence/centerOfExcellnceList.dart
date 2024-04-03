import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/centerOfExcellence/CenterOfExcellenceDialog.dart';
import 'package:sama/components/myutility.dart';
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
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              StyleButton(
                  description: "Add Article",
                  height: 55,
                  width: 125,
                  onTap: () {
                    openArticleDialog("");
                  })
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('articles').snapshots(),
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
                width: MyUtility(context).width -
                    (MyUtility(context).width * 0.25),
                height: 500,
                //color: Colors.transparent,
                child: ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot document = documents[index];
                    return GestureDetector(
                      onTap: () {
                        openArticleDialog(document['id']);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xFF174486),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                document['title'],
                                style: TextStyle(
                                    fontSize: 18,
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255)),
                              ),
                              Spacer(),
                              Text(
                                document['status'],
                                style: TextStyle(
                                    fontSize: 18,
                                    color: const Color.fromARGB(
                                        255, 255, 254, 254)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            })
      ],
    );
  }
}
