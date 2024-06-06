import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/media/mediaForm/mediaForm.dart';
import 'package:sama/admin/media/ui/mediaContainerStyle.dart';
import 'package:sama/admin/media/ui/mediaHeaderSection.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/member/media/mediaPopup/mediaPopup.dart';

class AdminMedia extends StatefulWidget {
  const AdminMedia({super.key});

  @override
  State<AdminMedia> createState() => _AdminMediaState();
}

class _AdminMediaState extends State<AdminMedia> {
  // Text controllers
  final selectCategory = TextEditingController();

  //Open dialog for media
  Future openMediaDialog(id) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: MediaForm(
          id: id,
          closeDialog: () => Navigator.pop(context),
        ));
      });

//View date
  Future viewMediaDialog(id) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: MediaPopup(
          id: id,
          closeDialog: () => Navigator.pop(context),
        ));
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Media & Podcast',
          style: TextStyle(
              fontSize: 32,
              color: Color(0xFF3D3D3D),
              fontWeight: FontWeight.normal),
        ),
        SizedBox(
          height: 25,
        ),
        MediaHeaderSection(
          controller: selectCategory,
          openMediaForm: () {
            openMediaDialog("");
          },
        ),
        StreamBuilder<QuerySnapshot>(
            stream: selectCategory.text.isEmpty
                ? FirebaseFirestore.instance.collection('media').snapshots()
                : FirebaseFirestore.instance
                    .collection('media')
                    .where('category', isEqualTo: selectCategory.text)
                    .snapshots(),
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
                return Center(child: Text('No Media Podcast yet'));
              }

              return Container(
                width: MyUtility(context).width -
                    (MyUtility(context).width * 0.25),
                height: 550,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      final DocumentSnapshot document = documents[index];

                      // if (selectCategory.text == "") {
                      return Container(
                        child: Wrap(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            MediaContainerStyle(
                              onpress: () {
                                openMediaDialog(document['id']);
                              },
                              view: () {
                                viewMediaDialog(document['id']);
                              },
                              adminType: "true",
                              image: document['mediaImageUrl'] ?? '',
                              duration: document['duration'],
                              releaseDate: '',
                              category: document['category'],
                              title: document['title'],
                            ),
                          ],
                        ),
                      );
                    }
                    // }
                    //   else if (document['category']
                    //       .contains(selectCategory.text)) {
                    //     return Container(
                    //       child: Wrap(
                    //         //mainAxisAlignment: MainAxisAlignment.start,
                    //         spacing: 10,
                    //         runSpacing: 10,
                    //         children: [
                    //           MediaContainerStyle(
                    //             onpress: () {
                    //               openMediaDialog(document['id']);
                    //             },
                    //             view: () {
                    //               viewMediaDialog(document['id']);
                    //             },
                    //             adminType: "true",
                    //             image: document['mediaImageUrl'] ?? '',
                    //             duration: document['duration'],
                    //             releaseDate: '',
                    //             category: document['category'],
                    //             title: document['title'],
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   }
                    // },
                    ),
              );
            }),
      ]),
    );
  }
}
