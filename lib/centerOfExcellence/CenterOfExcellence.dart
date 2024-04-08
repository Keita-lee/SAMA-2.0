import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/centerOfExcellence/CenterOfExcellenceDialog.dart';
import 'package:sama/centerOfExcellence/ui/NewsContainer.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';

class CenterOfExcellence extends StatefulWidget {
  Function(int?)? changePage;
  Function(String?, String?)? getArticleId;
  CenterOfExcellence(
      {super.key, required this.changePage, required this.getArticleId});

  @override
  State<CenterOfExcellence> createState() => _CenterOfExcellenceState();
}

class _CenterOfExcellenceState extends State<CenterOfExcellence> {
  List allArticles = [];
  String userType = "";

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

  getUserData() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (data.exists) {
      setState(() {
        userType = data.get('userType');
      });
    }
  }

  getAllArticles() async {
    final data = await FirebaseFirestore.instance.collection('articles').get();
    setState(() {
      for (var i = 0; i < data.docs.length; i++) {
        allArticles.add(data.docs[i]);
      }
    });
  }

  @override
  void initState() {
    getAllArticles();
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Center of Excellence',
            style: TextStyle(
                fontSize: 32,
                color: Color(0xFF3D3D3D),
                fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: MyUtility(context).height * 0.05,
          ),
          /* StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('articles').snapshots(),
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
                  return Center(child: Text('No class yet'));
                }

                return Container(
                    width: MyUtility(context).width -
                        (MyUtility(context).width * 0.25),
                    height: 500,
                    //color: Colors.transparent,
                    child: ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          final DocumentSnapshot document = documents[index];
                          return SizedBox(
                            width: 200,
                            child: NewsContainer(
                              image: document['image'],
                              category: document['category'],
                              date: document['date'],
                              header: document['title'],
                              onPressed: () {
                                setState(() {
                                  widget.getArticleId!(document['id']);
                                });

                                widget.changePage!(6);
                              },
                            ),
                          );
                        }));
              }),
        */ /*    Row(
            children: [
              NewsContainer(
                  image: 'images/news1.jpg',
                  category: 'Category ',
                  date: '13 March 2024',
                  header: 'Header',
                  onPressed: () {}),
              SizedBox(
                width: MyUtility(context).width * 0.025,
              ),
              NewsContainer(
                  image: 'images/news2.jpg',
                  category: 'Med-e-mail',
                  date: '13 March 2024',
                  header:
                      'WEBINAR | JUDASA - Reviving a Junior Doctors Movement',
                  onPressed: () {}),
            ],
          ),
      */

          Visibility(
              visible: userType == "Admin" ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width:
                        MyUtility(context).width - MyUtility(context).width / 4,
                  ),
                  StyleButton(
                      description: "Add Article",
                      height: 55,
                      width: 125,
                      onTap: () {
                        openArticleDialog("");
                      })
                ],
              )),
          Container(
            width: MyUtility(context).width - (MyUtility(context).width * 0.25),
            child: Wrap(
              alignment: WrapAlignment.start,
              children: [
                for (var i = 0; i < allArticles.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: NewsContainer(
                        openArticleDialog: openArticleDialog,
                        articleId: allArticles[i]['id'],
                        userType: userType,
                        image: allArticles[i]['image'],
                        category: allArticles[i]['category'],
                        date: allArticles[i]['date'],
                        header: allArticles[i]['title'],
                        onPressed: () {
                          setState(() {
                            widget.getArticleId!(
                                allArticles[i]['id'], allArticles[i]['image']);
                          });

                          widget.changePage!(6);
                        },
                        onArticleEdit: () {
                          openArticleDialog(allArticles[i]['id']);
                        }),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
