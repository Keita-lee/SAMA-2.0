import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/Events/AdminEvents/UI/eventsCategory/categoryForm.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';

class Categories extends StatefulWidget {
  Function closeDialog;
  String categoryType;
  Categories(
      {super.key, required this.closeDialog, required this.categoryType});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  //Open dialog for media
  Future openCategoryFormDialog(id) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: CategoryForm(
          id: id,
          categoryType: widget.categoryType,
          closeDialog: () => Navigator.pop(context),
        ));
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width / 2,
      height: MyUtility(context).height / 1.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(255, 255, 255, 255)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      widget.closeDialog();
                    },
                    child: Text(
                      "X",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color.fromARGB(255, 8, 55, 145),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: StyleButton(
                  description: "Add Category",
                  height: 55,
                  width: 125,
                  onTap: () {
                    openCategoryFormDialog("");
                  }),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('categories')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: snapshot error');
                  }
                  if (!snapshot.hasData) {
                    return const Text('Loading...');
                  }

                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  if (documents.isEmpty) {
                    return Center(child: Text('No Media & Webinars yet'));
                  }

                  return Container(
                      width: MyUtility(context).width -
                          (MyUtility(context).width * 0.25),
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            final DocumentSnapshot document = documents[index];
                            return GestureDetector(
                              onTap: () {
                                openCategoryFormDialog(document['id']);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MyUtility(context).width / 2.3,
                                  height: 75,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 254, 203, 54),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Text(
                                    document['categoryDescription'],
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 8, 55, 145),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                            );
                          }));
                }),
          ],
        ),
      ),
    );
  }
}
