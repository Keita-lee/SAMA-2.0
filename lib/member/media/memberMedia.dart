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
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Media & Webinars',
        style: TextStyle(
            fontSize: 32,
            color: Color(0xFF3D3D3D),
            fontWeight: FontWeight.normal),
      ),
      SizedBox(
        height: 25,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MyUtility(context).width - (MyUtility(context).width * 0.45),
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
              return Center(child: Text('No Media & Webinars yet'));
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
                          Visibility(
                            visible: category.text == ""
                                ? true
                                : category.text == document['category']
                                    ? true
                                    : false,
                            child: MediaContainerStyle(
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
                            ),
                          )
                        ],
                      );
                    }));
          }),
    ]));
  }
}
