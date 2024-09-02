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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SamaBlueBanner(pageName: 'MEDIA & WEBINARS'),
        SizedBox(
          height: 30,
        ),
        /*  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: SizedBox(
            width: MyUtility(context).width / 1.5,
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              style: GoogleFonts.openSans(fontSize: 16),
            ),
          ),
        ),*/
        Container(
            padding: EdgeInsets.only(left: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 30,
              ),
              /*Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MyUtility(context).width -
                    (MyUtility(context).width * 0.45),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select a Category",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF6A6A6A),
                    ),
                  ),
                  DropdownMenu<String>(
                    width: 250,
                    controller: category,
                    requestFocusOnTap: true,
                    label: const Text(''),
                    onSelected: (value) {
                      setState(() {
                        if (value == "All") {
                          category.text = "";
                        } else {
                          category.text = (value!);
                        }
                      });
                    },
                    dropdownMenuEntries:
                        items.map<DropdownMenuEntry<String>>((value) {
                      return DropdownMenuEntry<String>(
                        value: value,
                        label: value,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),*/
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
                    if (documents.isEmpty) {
                      return Center(child: Text('No Media & Webinars yet'));
                    }

                    return Container(
                        //color: const Color.fromARGB(137, 255, 193, 7),
                        width: MyUtility(context).width < 1680 ? 900 : 1200,
                        //width: MyUtility(context).width / 1.6,
                        /* width: MyUtility(context).width -
                        (MyUtility(context).width * 0.25),*/
                        height: MyUtility(context).height * 0.77,
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  MyUtility(context).width < 1680 ? 3 : 4,
                              childAspectRatio: 0.88,
                            ),
                            itemCount: documents.length,
                            itemBuilder: (BuildContext context, int index) {
                              final DocumentSnapshot document =
                                  documents[index];
                              return Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  Visibility(
                                    visible: category.text == ""
                                        ? true
                                        : category.text == document['category']
                                            ? true
                                            : false,
                                    child: MediaContainerStyle(
                                      view: () {
                                        openMediaDialog(document['title']);
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
                                      releaseDate: "",
                                      category: document['category'],
                                      title: document['title'],
                                      id: document['title'],
                                    ),
                                  )
                                ],
                              );
                            }));
                  }),
            ])),
      ],
    );
  }
}
