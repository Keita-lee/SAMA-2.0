import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/media/ui/mediaContainerStyle.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/media/mediaPopup/mediaPopup.dart';

class MemberMedia extends StatefulWidget {
  const MemberMedia({super.key});

  @override
  State<MemberMedia> createState() => _MemberMediaState();
}

class _MemberMediaState extends State<MemberMedia> {
  //Open dialog for media
  Future openMediaDialog(id) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: MediaPopup(
          id: id,
          closeDialog: () => Navigator.pop(context!),
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
      StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('media').snapshots(),
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
                      return Wrap(
                        direction: Axis.horizontal,
                        children: [
                          MediaContainerStyle(
                            view: () {
                              openMediaDialog(document["id"]);
                            },
                            onpress: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return MediaPopup(
                                    id: document["id"],
                                    closeDialog: () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              );
                            },
                            adminType: "false",
                            image: document['mediaImageUrl'],
                            duration: document['duration'],
                            releaseDate: '',
                            category: document['category'],
                            title: document['title'],
                            id: document['id'],
                          )
                        ],
                      );
                    }));
          }),
    ]));
  }
}
