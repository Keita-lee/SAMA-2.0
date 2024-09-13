import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/admin/media/ui/mediaContainerStyle.dart';
import 'package:sama/components/banner/samaBlueBanner.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/media/mediaPopup/mediaPopup.dart';

class MemberMedia extends StatefulWidget {
  const MemberMedia({super.key});

  @override
  State<MemberMedia> createState() => _MemberMediaState();
}

class _MemberMediaState extends State<MemberMedia> {
  final category = TextEditingController();

  List items = [
    'All',
    'Webinar',
    'SAMA News',
    'General',
    'Conferences',
    'Virtual Meeting',
    'Office of the Chair',
    'Corona Virus - COVID-19',
    'Courses',
  ];
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

  adjustDates() async {
    final doc = await FirebaseFirestore.instance.collection('media').get();

    if (doc.docs.isNotEmpty) {
      for (var i = 0; i < doc.docs.length; i++) {
        var str = doc.docs[i]['releaseDate'].split("-");
        var releaseDate = "${str[2]}-${str[1]}-${str[0]}";
        print(releaseDate);
        FirebaseFirestore.instance
            .collection('media')
            .doc(doc.docs[i]['id'])
            .update({"releaseDate": releaseDate}); /* */
      }
    }
  }

  @override
  void initState() {
    // adjustDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SamaBlueBanner(pageName: 'MEDIA & WEBINARS'),
        SizedBox(
          height: isMobile ? 10 : 30,
        ),
        Container(
            padding:
                isMobile ? EdgeInsets.only(left: 0) : EdgeInsets.only(left: 50),
            child: Column(
                crossAxisAlignment: isMobile
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('media')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: snapshot error');
                        }
                        if (!snapshot.hasData) {
                          return const Text('Loading...');
                        }

                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;
                        documents.sort((a, b) {
                          //sorting in ascending order
                          return DateTime.parse(b["releaseDate"])
                              .compareTo(DateTime.parse(a["releaseDate"]));
                        });

                        if (documents.isEmpty) {
                          return Center(child: Text('No Media & Webinars yet'));
                        }
                        if (isMobile) {
                          return Container(
                              width: MyUtility(context).width,
                              height: MyUtility(context).height / 1.8,
                              child: ListView.builder(
                                  itemCount: documents.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final DocumentSnapshot document =
                                        documents[index];
                                    return MediaContainerStyle(
                                      view: () {
                                        openMediaDialog(document['id']);
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
                                      duration: "",
                                      releaseDate: document['releaseDate'],
                                      category: document['category'],
                                      title: document['title'],
                                      id: document['title'],
                                    );
                                  }));
                        } else {
                          return Container(
                              width:
                                  MyUtility(context).width < 1680 ? 900 : 1200,
                              height: MyUtility(context).height * 0.77,
                              child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        MyUtility(context).width < 1680 ? 3 : 4,
                                    childAspectRatio: 0.88,
                                  ),
                                  itemCount: documents.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final DocumentSnapshot document =
                                        documents[index];
                                    return Wrap(
                                      direction: Axis.horizontal,
                                      children: [
                                        Visibility(
                                          visible: category.text == ""
                                              ? true
                                              : category.text ==
                                                      document['category']
                                                  ? true
                                                  : false,
                                          child: MediaContainerStyle(
                                            view: () {
                                              openMediaDialog(document['id']);
                                            },
                                            onpress: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return MediaPopup(
                                                    id: document["id"],
                                                    closeDialog: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            adminType: "false",
                                            image: document['mediaImageUrl'],
                                            duration: "",
                                            releaseDate:
                                                document['releaseDate'],
                                            category: document['category'],
                                            title: document['title'],
                                            id: document['title'],
                                          ),
                                        )
                                      ],
                                    );
                                  }));
                        }
                      }),
                ])),
      ],
    );
  }
}
