import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sama/admin/media/ui/addMediaImage.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/components/styleButtonYellow.dart';

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
      "category": category.text,
      "description": description.text,
      "urlLink": urlLink.text,
      "mediaImageUrl": mediaImageUrl,
      "releaseDate": releaseDate,
      "id": "",
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
              padding: const EdgeInsets.all(20.0),
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
                    children: [
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
                          description: "Author:",
                          textfieldController: author,
                          textFieldType: "stringType"),
                      ProfileTextField(
                          customSize: MyUtility(context).width / 4,
                          description: "Category",
                          textfieldController: category,
                          textFieldType: "stringType"),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileTextField(
                      customSize: MyUtility(context).width / 2.5,
                      description: "Description",
                      textfieldController: description,
                      textFieldType: "stringType"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileTextField(
                      customSize: MyUtility(context).width / 4,
                      description: "Youtube Link",
                      textfieldController: urlLink,
                      textFieldType: "stringType"),
                  SizedBox(
                    width: 15,
                  ),
                  StylrButtonYellow(
                      description: "Save",
                      height: 45,
                      width: 110,
                      onTap: () {
                        saveData();
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
