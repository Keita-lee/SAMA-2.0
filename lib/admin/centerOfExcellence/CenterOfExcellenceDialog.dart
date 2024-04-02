import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/imageAdd.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/components/utility.dart';

enum SingingCharacter { active, inActive }

class CenterOfExcellenceDialog extends StatefulWidget {
  String? id;
  Function closeDialog;
  CenterOfExcellenceDialog(
      {super.key, required this.id, required this.closeDialog});

  @override
  State<CenterOfExcellenceDialog> createState() =>
      _CenterOfExcellenceDialogState();
}

class _CenterOfExcellenceDialogState extends State<CenterOfExcellenceDialog> {
  // Text controllers
  final title = TextEditingController();
  final description = TextEditingController();
  final category = TextEditingController();
  List comments = [];
  //var
  String imageUrl = "";
  SingingCharacter? _character = SingingCharacter.active;

//Set value for benifits image
  setImageUrl(value) {
    setState(() {
      imageUrl = value;
    });
  }

//Add or edit a article
  createEditArticle() async {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    var data = {
      "title": title.text,
      "description": description.text,
      "image": imageUrl,
      "comments": comments,
      "status": _character == SingingCharacter.active ? "Active" : "InActive",
      "id": widget.id,
      "date": date,
      "category": category.text
    }; /*   */

    if (widget.id == "") {
      final doc = FirebaseFirestore.instance.collection('articles').doc();
      data["id"] = doc.id;

      final json = data;
      doc.set(json);
    } else {
      FirebaseFirestore.instance
          .collection('articles')
          .doc(widget.id)
          .update(data);
    }

    widget.closeDialog();
  }

  //If editing call data
  getArticleData() async {
    final data = await FirebaseFirestore.instance
        .collection('articles')
        .doc(widget.id)
        .get();

    if (data.exists) {
      setState(() {
        title.text = data.get('title');
        description.text = data.get('description');
        imageUrl = data.get('image');
        category.text = data.get('category');
        comments = data.get('comments');
        _character = data.get('status') == "Active"
            ? SingingCharacter.active
            : SingingCharacter.inActive;
      });
    }
  }

  @override
  void initState() {
    if (widget.id != "") {
      getArticleData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width / 2,
      height: 680,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      widget.closeDialog!();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "X",
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ImageAdd(
                customWidth: MyUtility(context).width / 4,
                customHeight: MyUtility(context).height / 3.5,
                description: "Excellence Image",
                networkImageUrl: imageUrl,
                setUrl: setImageUrl),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio<SingingCharacter>(
                  activeColor: Color.fromARGB(255, 8, 55, 145),
                  value: SingingCharacter.active,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Approved",
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
                SizedBox(
                  width: 10,
                ),
                Radio<SingingCharacter>(
                  activeColor: Color.fromARGB(255, 8, 55, 145),
                  value: SingingCharacter.inActive,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Not Approved",
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Title:",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFieldStyling(
                hintText: 'Add Title',
                textfieldController: title,
              ),
            ),
            Text(
              "Category:",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFieldStyling(
                hintText: 'Add Category',
                textfieldController: category,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Description:",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                    width: MyUtility(context).width,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(
                          color: const Color.fromARGB(255, 51, 51, 51),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: TextFormField(
                      minLines: 10,
                      maxLines: 10,
                      controller: description,
                      style: TextStyle(
                        color: Color.fromARGB(255, 153, 147, 147),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Description',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 199, 199, 199),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ))),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Spacer(),
                  StyleButton(
                      description: "Save Changes",
                      height: 55,
                      width: 125,
                      onTap: () {
                        createEditArticle();
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
