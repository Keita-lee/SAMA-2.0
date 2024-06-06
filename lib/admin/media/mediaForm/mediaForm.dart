import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sama/admin/media/ui/addMediaImage.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleButtonYellow.dart';
import 'package:sama/components/yesNoDialog.dart';

class MediaForm extends StatefulWidget {
  Function closeDialog;
  String id;
  MediaForm({super.key, required this.closeDialog, required this.id});

  @override
  State<MediaForm> createState() => _MediaFormState();
}

class _MediaFormState extends State<MediaForm> {
  //var
  String mediaImageUrl = "";
  String releaseDate = "";

  // Text controllers
  final title = TextEditingController();
  final duration = TextEditingController();
  final author = TextEditingController();
  final category = TextEditingController();
  final description = TextEditingController();
  final urlLink = TextEditingController();

  List<String> categories = [
    'Webinar',
    'SAMA News',
    'General',
    'Conferences',
    'Virtual Meeting',
    'Office of the Chair',
    'Corona Virus - COVID-19',
    'Courses',
  ];
  String? selectedCategory;

//getUrlForMediaImae
  getUrlForMediaImage(value) {
    setState(() {
      mediaImageUrl = value;
    });
  }

//save add data to firebase
  saveData() async {
    var mediaData = {
      "title": title.text,
      "duration": duration.text,
      "author": author.text,
      "category": selectedCategory ?? 'No Category',
      "description": description.text,
      "urlLink": urlLink.text,
      "mediaImageUrl": mediaImageUrl,
      "releaseDate": releaseDate,
      "id": widget.id,
    };

    if (widget.id == "") {
      var myNewDoc =
          await FirebaseFirestore.instance.collection("media").add(mediaData);

      FirebaseFirestore.instance.collection("media").doc(myNewDoc.id).update({
        "id": myNewDoc.id,
        "releaseDate": DateTime.now()
      }).whenComplete(() => widget.closeDialog());
    } else {
      FirebaseFirestore.instance
          .collection("media")
          .doc(widget.id)
          .update(mediaData)
          .whenComplete(() => widget.closeDialog());
    }
  }

  getMediaData() async {
    final data = await FirebaseFirestore.instance
        .collection('media')
        .doc(widget.id)
        .get();

    if (data.exists) {
      setState(() {
        title.text = data.get('title');
        duration.text = data.get('duration');
        author.text = data.get('author');
        category.text = data.get('category');
        description.text = data.get('description');
        urlLink.text = data.get('urlLink');
        mediaImageUrl = data.get('mediaImageUrl');
        releaseDate = data.get('releaseDate');
      });
    }
  }

  //Remove member from db
  removeMedia() {
    FirebaseFirestore.instance
        .collection('media')
        .doc(widget.id)
        .delete()
        .whenComplete(() => widget.closeDialog!());
  }

  BuildContext? dialogContext;
  //Dialog for password Validate
  Future removeMediaPopup() => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: YesNoDialog(
          description: "Are you sure you want to remove this item",
          closeDialog: () => Navigator.pop(dialogContext!),
          callFunction: removeMedia,
        ));
      });

  @override
  void initState() {
    //get data when Id availble
    if (widget.id != "") {
      getMediaData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width / 1.8,
      height: MyUtility(context).height / 1.4,
      decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color.fromARGB(255, 8, 55, 145),
              width: 2.0,
            ),
          ),
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(255, 255, 255, 255)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Text(
                    'Media & Podcast',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF174486),
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        widget.closeDialog();
                      },
                      child: Icon(Icons.cancel),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Transform.scale(
                scale: 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AddMediaImage(
                        networkImageUrl: mediaImageUrl,
                        updateUrl: getUrlForMediaImage),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ProfileTextField(
                        //     customSize: MyUtility(context).width / 4,
                        //     description: "Category:",
                        //     textfieldController: category,
                        //     textFieldType: "stringType"),
                        Container(
                          width: MyUtility(context).width / 4,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButtonFormField(
                            value: selectedCategory,
                            items: categories.map((category) {
                              return DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCategory = value!;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Category',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ProfileTextField(
                            customSize: MyUtility(context).width / 4,
                            description: "Title:",
                            textfieldController: title,
                            textFieldType: "stringType"),
                        ProfileTextField(
                            customSize: MyUtility(context).width / 4,
                            description: "Duration:",
                            textfieldController: duration,
                            textFieldType: "stringType"),
                        ProfileTextField(
                            customSize: MyUtility(context).width / 4,
                            description: "Description:",
                            textfieldController: description,
                            textFieldType: "stringType"),
                        ProfileTextField(
                            customSize: MyUtility(context).width / 4,
                            description: "Youtube Link",
                            textfieldController: urlLink,
                            textFieldType: "stringType"),
                        SizedBox(height: 20),
                        StyleButton(
                            description: "Save",
                            height: 55,
                            width: 150,
                            onTap: () {
                              saveData();
                            }),
                        Visibility(
                          visible: widget.id != "" ? true : false,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: StyleButton(
                                description: "Remove",
                                height: 55,
                                width: 150,
                                onTap: () {
                                  removeMediaPopup();
                                }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Transform.scale(
            //   scale: 0.8,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     //crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(left: 20),
            //         child: ProfileTextField(
            //             customSize: MyUtility(context).width / 2.5,
            //             description: "Description",
            //             textfieldController: description,
            //             textFieldType: "stringType"),
            //       ),
            //     ],
            //   ),
            // ),
            // Transform.scale(
            //   scale: 0.8,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     //crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(left: 35),
            //         child: ProfileTextField(
            //             customSize: MyUtility(context).width / 2.5,
            //             description: "Youtube Link",
            //             textfieldController: urlLink,
            //             textFieldType: "stringType"),
            //       ),
            //       SizedBox(
            //         width: 15,
            //       ),
            //     ],
            //   ),
            // ),
            //SizedBox(height: 20),
            // Center(
            //   child: Transform.scale(
            //     scale: 0.8,
            //     child: Container(
            //       //width: MyUtility(context).width / 2,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           StyleButton(
            //               description: "Save",
            //               height: 55,
            //               width: 150,
            //               onTap: () {
            //                 saveData();
            //               }),
            //           SizedBox(
            //             width: 15,
            //           ),
            //           Visibility(
            //             visible: widget.id != "" ? true : false,
            //             child: StyleButton(
            //                 description: "Remove",
            //                 height: 55,
            //                 width: 150,
            //                 onTap: () {
            //                   removeMediaPopup();
            //                 }),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
