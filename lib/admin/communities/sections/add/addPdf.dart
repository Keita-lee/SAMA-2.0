import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../../Login/popups/validateDialog.dart';
import '../../../../components/myutility.dart';
import '../../../../components/profileTextField.dart';
import '../../../../components/styleButton.dart';
import '../ui/communityCheckBox.dart';

class AddPdf extends StatefulWidget {
  String pdfId;
  Function(int, String) changePageIndex;
  AddPdf({super.key, required this.pdfId, required this.changePageIndex});

  @override
  State<AddPdf> createState() => _AddPdfState();
}

class _AddPdfState extends State<AddPdf> {
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

  //Controllers
  final title = TextEditingController();
  final pdfLink = TextEditingController();

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
      'id': widget.pdfId,
      'title': title.text,
      'pdfLink': pdfLink.text,
      'communities': communities,
      'type': "PDF",
      'isActive': status,
    };

    if (widget.pdfId == "") {
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
          .doc(widget.pdfId)
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
        .doc(widget.pdfId)
        .get();

    if (commData.exists) {
      setState(() {
        title.text = commData.get('title');
        pdfLink.text = commData.get('pdfLink');
        communities = commData.get('communities');
      });
    }
  }

  Future uploadFile(fileName, webImage) async {
    final ref = FirebaseStorage.instance.ref().child('files').child(fileName);

    var imageUrl = "";
    await ref.putData(webImage!);
    imageUrl = await ref.getDownloadURL();
    print(imageUrl);
    setState(() {
      pdfLink.text = imageUrl;
      fileUploadStatus = "Upload Complete";
    });
  }

  var fileUploadStatus = "";
  Future<void> pickFile() async {
    setState(() {
      fileUploadStatus = "";
    });
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    //  FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      for (var i = 0; i < result.files.length; i++) {
        Uint8List? fileBytes = result.files[i].bytes;
        var fileName = result.files[i].name;
        fileUploadStatus = "Uploading ...";
        await uploadFile(fileName, fileBytes);
      }

      // Upload file
    }
  }

  @override
  void initState() {
    if (widget.pdfId != "") {
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
          ProfileTextField(
              customSize: MyUtility(context).width * 0.5,
              description: "PDF link",
              textfieldController: pdfLink,
              textFieldType: "stringType"),
          SizedBox(
            height: 15,
          ),
          Text(
            'Insert direct link or click to upload',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 146, 146, 146)),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              StyleButton(
                  description: "Upload File",
                  height: 55,
                  width: 175,
                  onTap: () {
                    pickFile();
                    //   widget.changePageIndex(0, "");
                  }),
              SizedBox(
                width: 15,
              ),
              Text(
                fileUploadStatus,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 146, 146, 146)),
              ),
            ],
          ),
        ]);
  }
}
