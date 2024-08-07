import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../../Login/popups/validateDialog.dart';
import '../../../../components/myutility.dart';
import '../../../../components/profileTextField.dart';
import '../../../../components/styleButton.dart';
import '../ui/communityCheckBox.dart';

class AddText extends StatefulWidget {
  String textId;
  Function(int, String) changePageIndex;
  AddText({super.key, required this.textId, required this.changePageIndex});

  @override
  State<AddText> createState() => _AddTextState();
}

class _AddTextState extends State<AddText> {
  //var
  final List<String> communitiesNames = [
    'A - Student, Intern and Community Service Doctors',
    'B - Employed Private and Public Medical Practitioners',
    'C - Private Practice Medical Practitioners',
    'D - Registrars',
    'E - Specialist',
    'F - Corporate and Self Employed Doctors',
    'G - Research and Academia',
    'H - Retirees'
  ];
  List communities = [];
  var myJSON;
  QuillController quillController = QuillController.basic();

  //Controllers
  final title = TextEditingController();
  final details = TextEditingController();

//Add / remove community value from list
  addRemoveCommunity(value) {
    setState(() {
      if (communities.contains(value)) {
        var comIndex = (communities).indexWhere((item) => item == value);
        communities.removeAt(comIndex);
      } else {
        communities.add(value);
      }
    });
  }

//check if value in list
  checkIfExist(value) {
    var check = false;
    if (communities.contains(value)) {
      check = true;
    }
    return check;
  }

  //Dialog  for data save
  Future descriptionPopup(description) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: ValidateDialog(
                description: description,
                closeDialog: () => Navigator.pop(context!)));
      });

//save data to firebase
  saveCommunityDetails(status) async {
    var communityData = {
      'id': widget.textId,
      'title': title.text,
      'details': jsonEncode(quillController.document.toDelta().toJson()),
      'communities': communities,
      'type': "TEXT",
      'isActive': status,
    };

    if (widget.textId == "") {
      final String comId =
          FirebaseFirestore.instance.collection('communities').doc().id;
      communityData['id'] = comId;
      await FirebaseFirestore.instance
          .collection('communities')
          .doc(comId)
          .set(communityData)
          .whenComplete(() {
        descriptionPopup("Data Saved");
      });
    } else {
      await FirebaseFirestore.instance
          .collection('communities')
          .doc(widget.textId)
          .update(communityData)
          .whenComplete(() {
        descriptionPopup("Data Saved");
      });
    }
  }

//call data from firebase
  getCommunityPdfDetails() async {
    DocumentSnapshot commData = await FirebaseFirestore.instance
        .collection('communities')
        .doc(widget.textId)
        .get();

    if (commData.exists) {
      setState(() {
        title.text = commData.get('title');
        communities = commData.get('communities');
        myJSON = jsonDecode(commData.get('details'));
        quillController = QuillController(
            document: Document.fromJson(myJSON),
            selection: TextSelection.collapsed(offset: 0));
      });
    }
  }

  @override
  void initState() {
    if (widget.textId != "") {
      getCommunityPdfDetails();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Communities - Add Resource',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 8, 55, 145)),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: MyUtility(context).width * 0.50,
              ),
              StyleButton(
                  buttonColor: Colors.grey,
                  description: "Back",
                  height: 55,
                  width: 125,
                  onTap: () {
                    widget.changePageIndex(0, "");
                  }),
              SizedBox(
                width: 15,
              ),
              StyleButton(
                  buttonColor: Colors.grey,
                  description: "Safe as Draft",
                  height: 55,
                  width: 175,
                  onTap: () {
                    saveCommunityDetails("InActive");
                  }),
              SizedBox(
                width: 15,
              ),
              StyleButton(
                  description: "Publish",
                  height: 55,
                  width: 175,
                  onTap: () {
                    saveCommunityDetails("Active");
                  }),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Select at least one Community',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0)),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 1000,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                for (int i = 0; i < communitiesNames.length; i++)
                  CommunityCheckBox(
                    checkboxValue: checkIfExist(communitiesNames[i]),
                    description: communitiesNames[i],
                    addRemoveCommunity: addRemoveCommunity,
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ProfileTextField(
              customSize: MyUtility(context).width * 0.5,
              description: "Title",
              textfieldController: title,
              textFieldType: "stringType"),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 800,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: QuillToolbar.simple(
                configurations: QuillSimpleToolbarConfigurations(
                  controller: quillController,
                  sharedConfigurations: const QuillSharedConfigurations(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MyUtility(context).width / 2,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: QuillEditor.basic(
              configurations: QuillEditorConfigurations(
                controller: quillController,
                sharedConfigurations: const QuillSharedConfigurations(),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ]);
  }
}
