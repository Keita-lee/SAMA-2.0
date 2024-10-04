import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';
import 'package:sama/admin/profesionalDevelopment/sections/cpdEditForm/addQuestion.dart';
import 'package:sama/components/styleButton.dart';

import '../../../../Login/popups/validateDialog.dart';
import '../../../../components/myutility.dart';
import '../../../../components/profileTextField.dart';
import '../../../../components/yesNoDialog.dart';
import '../../../media/ui/addMediaImage.dart';
import '../../../products/UI/myProductTextField.dart';
import 'ui/cpdQuestionStyle.dart';

class CpdEditForm extends StatefulWidget {
  String cpdId;
  Function(int, String) changePageIndex;
  CpdEditForm({super.key, required this.cpdId, required this.changePageIndex});

  @override
  State<CpdEditForm> createState() => _CpdEditFormState();
}

class _CpdEditFormState extends State<CpdEditForm> {
  //Controllers
  final title = TextEditingController();
  final introduction = TextEditingController();
  final journalLink = TextEditingController();
  final latestRelease = TextEditingController();

  final nonMemberPrice = TextEditingController();
  final subDescription = TextEditingController();
  //var
  var cpdImage = "";
  var pageIndex = 0;
  var myJSON;
  var questionIndex = -1;
  QuillController quillController = QuillController.basic();
  List questions = [];

  //ver editQuestion
  String questionAsked = "";

  List answerOfQuestion = [];
  int questionListIndex = -1;
//changeIndex of question page
  editQChangePageIndex(value) {
    setState(() {
      pageIndex = value;
    });
  }

  //Dialog  validate popup
  Future descriptionPopup(description) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: ValidateDialog(
                description: description,
                closeDialog: () => Navigator.pop(context!)));
      });

  // set image URL when selected
  getImageUrl(value) {
    setState(() {
      cpdImage = value;
    });
  }

//Select a date popup
  onTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(1900),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    latestRelease.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }

//Save to DB
  saveQuestionnaire(status) async {
    var cpdDetails = {
      'id': widget.cpdId,
      'title': title.text,
      'introduction': jsonEncode(quillController.document.toDelta().toJson()),
      'questions': questions,
      "status": status,
      "nonMemberPrice": nonMemberPrice.text,
      "subDescription": subDescription.text,
      "cpdImage": cpdImage,
      "journalLink": journalLink.text,
      "latestRelease": latestRelease.text
    };

    if (widget.cpdId == "") {
      final String newProductId =
          FirebaseFirestore.instance.collection('cpd').doc().id;
      cpdDetails['id'] = newProductId;
      await FirebaseFirestore.instance
          .collection('cpd')
          .doc(newProductId)
          .set(cpdDetails)
          .whenComplete(() {
        descriptionPopup("Data saved");
      });
    } else {
      await FirebaseFirestore.instance
          .collection('cpd')
          .doc(widget.cpdId)
          .update(cpdDetails)
          .whenComplete(() {
        descriptionPopup("Data saved");
      });
    }
  }

  //get details for cpd item
  getCpdDetails() async {
    DocumentSnapshot cpdData = await FirebaseFirestore.instance
        .collection('cpd')
        .doc(widget.cpdId)
        .get();

    if (cpdData.exists) {
      setState(() {
        journalLink.text = cpdData.get("journalLink");
        nonMemberPrice.text = cpdData.get("nonMemberPrice");
        cpdImage = cpdData.get("cpdImage");
        subDescription.text = cpdData.get("subDescription");
        title.text = cpdData.get("title");

        myJSON = jsonDecode(cpdData.get('introduction'));
        quillController = QuillController(
            document: Document.fromJson(myJSON),
            selection: TextSelection.collapsed(offset: 0));
        questions = cpdData.get("questions");
        latestRelease.text = cpdData.get("latestRelease");
      });
    }
  }

//Update list of questions
  updateQuestionsList(value, index) {
    print(index);
    print(questionListIndex);
    if (questionListIndex > -1) {
      //Edit
      setState(() {
        questions[questionListIndex]['questionToBeAsked'] =
            value['questionToBeAsked'];
        questions[questionListIndex]['answerOptions'] = value['answerOptions'];
        editQChangePageIndex(0);
      });
    } else {
      //Add
      setState(() {
        questions.add(value);
        editQChangePageIndex(0);
      });
    }
  }

  editQuestionUpdateValues(question, answerList, index) {
    setState(() {
      editQChangePageIndex(1);
      questionListIndex = index;
      questionAsked = question;
      answerOfQuestion = answerList;
    });
  }

  @override
  void initState() {
    if (widget.cpdId != "") {
      getCpdDetails();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MyUtility(context).width / 1.3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: pageIndex == 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      StyleButton(
                        description: "Back",
                        height: 55,
                        width: 125,
                        onTap: () {
                          widget.changePageIndex(0, "");
                        },
                        buttonColor: Color.fromARGB(255, 212, 210, 210),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      StyleButton(
                        description: "Save as Draft",
                        height: 55,
                        width: 125,
                        onTap: () {
                          saveQuestionnaire("InActive");
                        },
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      StyleButton(
                        description: "Publish",
                        height: 55,
                        width: 125,
                        onTap: () {
                          saveQuestionnaire("Active");
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Color(0xFFD1D1D1),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AddMediaImage(
                                networkImageUrl: cpdImage,
                                updateUrl: getImageUrl,
                              ),
                              Column(
                                children: [
                                  MyProductTextField(
                                    hintText: 'Title',
                                    textfieldController: title,
                                    textFieldWidth:
                                        MyUtility(context).width * 0.28,
                                    topPadding: 0,
                                    header: 'Title',
                                  ),
                                  MyProductTextField(
                                    hintText: 'Sub Description',
                                    textfieldController: subDescription,
                                    textFieldWidth:
                                        MyUtility(context).width * 0.28,
                                    topPadding: 0,
                                    header: 'Sub description',
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  MyProductTextField(
                                    hintText: 'Journal Link',
                                    textfieldController: journalLink,
                                    textFieldWidth:
                                        MyUtility(context).width * 0.28,
                                    topPadding: 0,
                                    header: 'Journal Link',
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    width: MyUtility(context).width * 0.28,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Release Date",
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            width: MyUtility(context).width *
                                                0.195,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: TextField(
                                              controller: latestRelease,
                                              readOnly: true,
                                              decoration: const InputDecoration(
                                                  hintText:
                                                      "Click here to select date"),
                                              onTap: () => onTapFunction(
                                                  context: context),
                                            ),
                                          )
                                        ]),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Introduction",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MyUtility(context).width * 0.75,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: QuillToolbar.simple(
                                configurations:
                                    QuillSimpleToolbarConfigurations(
                                  controller: quillController,
                                  sharedConfigurations:
                                      const QuillSharedConfigurations(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MyUtility(context).width * 0.60,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: QuillEditor.basic(
                                configurations: QuillEditorConfigurations(
                                  controller: quillController,
                                  sharedConfigurations:
                                      const QuillSharedConfigurations(),
                                ),
                              ),
                            ),
                          ),
                          /*SizedBox(
                            height: 15,
                          ),
                          MyProductTextField(
                            hintText: 'Journal Link',
                            textfieldController: journalLink,
                            textFieldWidth: MyUtility(context).width * 0.75,
                            topPadding: 0,
                            header: 'Link',
                          ),*/
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Questions",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      StyleButton(
                          description: "Add Question",
                          height: 55,
                          width: 155,
                          onTap: () {
                            setState(() {
                              questionAsked = "";
                              answerOfQuestion = [];
                            });

                            editQChangePageIndex(1);
                          })
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Visibility(
                visible: pageIndex == 1,
                child: AddQuestion(
                  updateQuestionsList: updateQuestionsList,
                  questionToBeAsked: questionAsked,
                  answerOptions: answerOfQuestion,
                  index: questionIndex,
                )),
            for (var i = 0; i < questions.length; i++)
              Visibility(
                  visible: pageIndex == 0,
                  child: CpdQuestionStyle(
                      questionValue: questions[i]['questionToBeAsked'],
                      editQuestion: () {
                        editQuestionUpdateValues(
                            questions[i]['questionToBeAsked'],
                            questions[i]['answerOptions'],
                            i);
                      })),
            SizedBox(
              height: 45,
            ),
          ],
        ),
      ),
    );
  }
}
