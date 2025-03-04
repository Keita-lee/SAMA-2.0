import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:sama/admin/media/ui/addMediaImage.dart';
import 'package:sama/admin/media/ui/selectDuarationPopup.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/components/selectDuration.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleButtonYellow.dart';
import 'package:sama/components/yesNoDialog.dart';

import '../../../components/dateSelecter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MediaForm extends StatefulWidget {
  Function closeDialog;
  String id;

  MediaForm({super.key, required this.closeDialog, required this.id});

  @override
  State<MediaForm> createState() => _MediaFormState();
}

class _MediaFormState extends State<MediaForm> {
  // Var
  String mediaImageUrl = "";
  String releaseDate = "";

  // Text controllers
  final title = TextEditingController();
  final duration = TextEditingController();
  final author = TextEditingController();
  final category = TextEditingController();
  final description = TextEditingController();
  final urlLink = TextEditingController();
  final date = TextEditingController();
  final selectedCategory = TextEditingController();
  var myJSON;
  QuillController quillController = QuillController.basic();
  late YoutubePlayerController _youtubePlayerController;
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
  // String selectedCategory = "";

  // set image URL when selected
  getMediaImageUrl(value) {
    setState(() {
      mediaImageUrl = value;
    });
  }

  // set the media image URL
  getUrlForMediaImage(value) {
    setState(() {
      mediaImageUrl = value;
    });
  }

  // get YouTube thumbnail from YouTube link
  String getYouTubeThumbnailUrl(String url) {
    //final videoId = Uri.parse(url).queryParameters['v'];
    var videoId = YoutubePlayerController.convertUrlToId(url);
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  // save the form data to Firebase
  saveData() async {
    // If no image is selected, use the YouTube thumbnail
    if (mediaImageUrl.isEmpty && urlLink.text.isNotEmpty) {
      mediaImageUrl = getYouTubeThumbnailUrl(urlLink.text);
    }

    var mediaData = {
      "title": title.text,
      // "duration": duration.text,
      "author": author.text,
      "category": selectedCategory.text,
      // "description": jsonEncode(quillController.document.toDelta().toJson()),
      "urlLink": urlLink.text,
      "mediaImageUrl": getYouTubeThumbnailUrl(urlLink.text),
      "releaseDate": date.text,
      "id": widget.id,
    };

    if (widget.id == "") {
      var myNewDoc =
          await FirebaseFirestore.instance.collection("media").add(mediaData);

      FirebaseFirestore.instance.collection("media").doc(myNewDoc.id).update({
        "id": myNewDoc.id,
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
        // duration.text = data.get('duration');
        author.text = data.get('author');
        category.text = data.get('category');
        selectedCategory.text = data.get('category');
        //quillController = data.get('description');

        urlLink.text = data.get('urlLink');
        mediaImageUrl = data.get('mediaImageUrl');
        date.text = data.get('releaseDate');
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

  //Dialog for remove media
  Future removeMediaPopup() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: YesNoDialog(
          description: "Are you sure you want to remove this item",
          closeDialog: () => Navigator.pop(context!),
          callFunction: removeMedia,
        ));
      });

  getDuration(value) {
    setState(() {
      duration.text = value;
      Navigator.pop(context);
    });
  }

  //Dialog to select a duration
  Future selectDurationPopup() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: SelectDurationPopup(
          closeDialog: () => Navigator.pop(context!),
          getDuration: getDuration,
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
                    'Media & Webinars',
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
              child: Column(
                children: [
                  /*  AddMediaImage(
                    networkImageUrl: mediaImageUrl,
                    updateUrl: getUrlForMediaImage,
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileDropDownField(
                            customSize: MyUtility(context).width -
                                (MyUtility(context).width * 0.75),
                            description: 'Categories',
                            items: categories,
                            textfieldController: selectedCategory,
                          ),
                          /*     Container(
                            width: MyUtility(context).width / 4,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
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
                                  labelText: ' Category',
                                ),
                              ),
                            ),
                          ),*/
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      ProfileTextField(
                          customSize: MyUtility(context).width / 4,
                          description: "Title:",
                          textfieldController: title,
                          textFieldType: "stringType"),
                    ],
                  ),
                  SizedBox(height: 20),
                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 35,
                      ),
                      /**/ ProfileTextField(
                          customSize: MyUtility(context).width / 10,
                          description: "Duration:",
                          textfieldController: duration,
                          textFieldType: "stringType"),
                      SizedBox(
                        width: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 1.5),
                        child: StyleButton(
                            description: "Select Duration",
                            height: 55,
                            width: 150,
                            onTap: () {
                              selectDurationPopup();
                            }),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      QuillToolbar.simple(
                        configurations: QuillSimpleToolbarConfigurations(
                          controller: quillController,
                          sharedConfigurations:
                              const QuillSharedConfigurations(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      /*  Container(
                        width: MyUtility(context).width / 2,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: QuillEditor.basic(
                          configurations: QuillEditorConfigurations(
                            controller: quillController,
                            sharedConfigurations:
                                const QuillSharedConfigurations(),
                          ),
                        ),
                      ),*/
                      ProfileTextField(
                        customSize: MyUtility(context).width / 2,
                        description: "Description:",
                        textfieldController: description,
                        customHeight: 100,
                        textFieldType: "stringType",
                        lines: 6,
                      ),
                      /*  */
                      SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DateSelecter(
                        customSize: MyUtility(context).width / 4,
                        description: 'Change Date',
                        controller: date,
                        refresh: () {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileTextField(
                          customSize: MyUtility(context).width / 2,
                          description: "Youtube Link",
                          textfieldController: urlLink,
                          textFieldType: "stringType"),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      StyleButton(
                          description: "Save",
                          height: 55,
                          width: 150,
                          onTap: () {
                            saveData();
                          }),
                      SizedBox(
                        width: 8,
                      ),
                      Visibility(
                        visible: widget.id != "" ? true : false,
                        child: StyleButton(
                            description: "Remove",
                            height: 55,
                            width: 150,
                            onTap: () {
                              removeMediaPopup();
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
