import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/admin/media/mediaForm/mediaForm.dart';
import 'package:sama/admin/media/ui/mediaContainerStyle.dart';
import 'package:sama/admin/media/ui/mediaHeaderSection.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/media/mediaPopup/test.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../components/banner/samaBlueBanner.dart';

class AdminMedia extends StatefulWidget {
  const AdminMedia({super.key});

  @override
  State<AdminMedia> createState() => _AdminMediaState();
}

class _AdminMediaState extends State<AdminMedia> {
  // Text controllers
  final selectCategory = TextEditingController();

  //var
  bool hideVideos = false;

  closeDialog() {
    setState(() {
      Navigator.pop(context);
      hideVideos = false;
    });
  }

  //Open dialog for media
  Future openMediaDialog(id) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
            child: MediaForm(
          id: id,
          closeDialog: () {
            closeDialog();
          },
        ));
      });

//View date
  Future viewMediaDialog(id) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
            child: Test(
          id: id,
          closeDialog: () {
            closeDialog();
          },
        ));
      });

  getCategoryValue(value) {
    setState(() {
      selectCategory.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SamaBlueBanner(pageName: 'MEDIA & WEBINARS'),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: SizedBox(
            width: MyUtility(context).width / 1.5,
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              style: GoogleFonts.openSans(fontSize: 16),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 50),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(selectCategory.text),
            MediaHeaderSection(
                controller: selectCategory,
                openMediaForm: () {
                  openMediaDialog("");
                },
                getCategoryValue: getCategoryValue),
            Visibility(
              visible: !hideVideos ? true : false,
              child: StreamBuilder<QuerySnapshot>(
                  stream: selectCategory.text == "All" ||
                          selectCategory.text == ""
                      ? FirebaseFirestore.instance
                          .collection('media')
                          .snapshots()
                      : selectCategory.text == "All"
                          ? FirebaseFirestore.instance
                              .collection('media')
                              .snapshots()
                          : FirebaseFirestore.instance
                              .collection('media')
                              .where('category', isEqualTo: selectCategory.text)
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
                    if (documents.isEmpty) {
                      return Center(child: Text('No Media & Webinars yet'));
                    }

                    return Container(
                      width: MyUtility(context).width < 1680 ? 900 : 1200,
                      //width: MyUtility(context).width / 1.6,
                      /* width: MyUtility(context).width -
                        (MyUtility(context).width * 0.25),*/
                      height: MyUtility(context).height * 0.60,
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      MyUtility(context).width < 1680 ? 3 : 4,
                                  childAspectRatio: 0.88,
                                  mainAxisSpacing: 16.0),
                          itemCount: documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            final DocumentSnapshot document = documents[index];

                            return Container(
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  Visibility(
                                    visible: document['category']
                                            .contains(selectCategory.text)
                                        ? true
                                        : false,
                                    child: MediaContainerStyle(
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
                                      id: document['id'],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  }),
            ),
          ]),
        ),
      ],
    );
  }
}
