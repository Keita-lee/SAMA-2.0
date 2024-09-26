import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sama/components/CheckBoxCircle.dart';
import 'package:sama/components/MyDivider.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/profile/Tables/PublishedArticlesTable.dart';
import 'package:sama/profile/Tables/VolunteerWorkTable.dart';
import 'package:sama/profile/Tables/organisationsTable.dart';
import 'package:sama/profile/Tables/workExperience.dart';
import 'package:sama/profile/ui/longTextField.dart';
import 'package:sama/profile/ui/myDatePicker.dart';

import '../components/dateSelecter.dart';
import 'package:file_picker/file_picker.dart';
import '../components/myutility.dart';
import '../login/popups/validateDialog.dart';

class BoiFormText extends StatelessWidget {
  var mainFormText;
  BoiFormText({super.key, required this.mainFormText});

  @override
  Widget build(BuildContext context) {
    return Text(
      mainFormText,
      style: GoogleFonts.openSans(
          fontSize: 18, height: 1, fontWeight: FontWeight.bold),
    );
  }
}

class BoiFormText2 extends StatelessWidget {
  var mainFormText;
  BoiFormText2({super.key, required this.mainFormText});

  @override
  Widget build(BuildContext context) {
    return Text(
      mainFormText,
      style: GoogleFonts.openSans(fontSize: 18, height: 1),
    );
  }
}

class Bio extends StatefulWidget {
  const Bio({super.key});

  @override
  State<Bio> createState() => _BioState();
}

class _BioState extends State<Bio> {
  //TextEditing Controller
  final dob = TextEditingController();
  final maritalStatus = TextEditingController();
// Work Experience
  final workExperienceFrom = TextEditingController();
  final workExperienceTo = TextEditingController();
  final workExperienceDescription = TextEditingController();
  List workExperience = [];
//Qualification
  final qualification = TextEditingController();
//Articles
  final articleDate = TextEditingController();
  final articleDescription = TextEditingController();
  List articles = [];

//volunteer
  final volunteerDate = TextEditingController();
  final volunteerDescription = TextEditingController();
  List volunteerWork = [];

  //QA
  final positionAtSama = TextEditingController();
  final skillToSama = TextEditingController();

  //Organization
  final organizationName = TextEditingController();
  final organizationRole = TextEditingController();
  List organizations = [];

  final position = TextEditingController();
  final leaderShipMotivation = TextEditingController();

  //var
  var cv = "";
  bool pendingDiscipline = false;
  bool disciplineAction = false;
  bool civilJudgement = false;
  bool positionRemoved = false;
  bool chargedCrime = false;

  //add data to workExperienceList
  addRemoveWorkExperience(index) {
    setState(() {
      if (index == "") {
        workExperience.add({
          "workExperienceFrom": workExperienceFrom.text,
          "workExperienceTo": workExperienceTo.text,
          "workExperienceDescription": workExperienceDescription.text,
        });
      } else {
        workExperience.removeAt(index);
      }
    });
  }

//add or remove data from articles list
  addRemoveArticle(index) {
    setState(() {
      if (index == "") {
        articles.add({
          "articleDate": articleDate.text,
          "articleDescription": articleDescription.text,
        });
      } else {
        articles.removeAt(index);
      }
    });
  }

//add or remove data from volunteers list
  addRemoveVolunteer(index) {
    setState(() {
      if (index == "") {
        volunteerWork.add({
          "volunteerDate": volunteerDate.text,
          "volunteerDescription": volunteerDescription.text,
        });
      } else {
        volunteerWork.removeAt(index);
      }
    });
  }

//add or remove data from volunteers list
  addRemoveOrganization(index) {
    setState(() {
      if (index == "") {
        organizations.add({
          "organizationName": organizationName.text,
          "organizationRole": organizationRole.text,
        });
      } else {
        organizations.removeAt(index);
      }
    });
  }

  Future uploadFile(fileName, webImage) async {
    final ref = FirebaseStorage.instance.ref().child('files').child(fileName);

    var imageUrl = "";
    await ref.putData(webImage!);
    imageUrl = await ref.getDownloadURL();
    print(imageUrl);
    setState(() {
      cv = imageUrl;
      fileUploadStatus = "Upload Complete";
    });
  }

  var fileUploadStatus = "";
  Future<void> pickFile() async {
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

  Future userUpdated() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: ValidateDialog(
                description: "Bio Data Saved",
                closeDialog: () => Navigator.pop(context!)));
      });

  getBioData() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (data.exists) {
      setState(() {
        cv = data.get('bio.cv');
        articles = data.get('bio.articles');
        chargedCrime = data.get('bio.chargedCrime');
        civilJudgement = data.get('bio.civilJudgement');
        dob.text = data.get('bio.dob');
        maritalStatus.text = data.get('bio.maritalStatus');
        pendingDiscipline = data.get('bio.pendingDiscipline');
        positionRemoved = data.get('bio.positionRemoved');
        qualification.text = data.get('bio.qualifications');
        volunteerWork = data.get('bio.volunteerWork');
        workExperience = data.get('bio.workExperience');
        organizations = data.get('bio.organizations'); /**/
      });
    }
  }

  updateUserBio() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "bio": {
        "cv": cv,
        "dob": dob.text,
        "maritalStatus": maritalStatus.text,
        "workExperience": workExperience,
        "qualifications": qualification.text,
        "articles": articles,
        "volunteerWork": volunteerWork,
        "pendingDiscipline": pendingDiscipline,
        "civilJudgement": civilJudgement,
        "positionRemoved": positionRemoved,
        "chargedCrime": chargedCrime,
        "organizations": organizations
      }
    }).whenComplete(() {
      userUpdated();
    });
  }

  @override
  void initState() {
    getBioData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    if (isMobile) {
      return SizedBox(
        width: MyUtility(context).width - 15,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Curriculum Vitae/Biography',
                style: GoogleFonts.openSans(
                  fontSize: 24,
                  color: Color(0xFF174486),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              BoiFormText(mainFormText: 'Date of Birth:'),
              SizedBox(
                height: 15,
              ),
              MyDatePicker(
                textfieldController: dob,
                hintText: 'Date of Birth',
                refresh: () {
                  setState(() {});
                },
              ),
              SizedBox(
                height: 15,
              ),
              BoiFormText(mainFormText: 'Marital Status:'),
              SizedBox(
                height: 10,
              ),
              ProfileDropDownField(
                focusTap: false,
                customSize: MyUtility(context).width / 1.1,
                //Controller here
                textfieldController: maritalStatus,
                items: ['Married', 'Single'],
              ),
              SizedBox(
                height: 10,
              ),
              BoiFormText(mainFormText: 'Occupation/Work Experience:'),
              SizedBox(
                height: 10,
              ),

              MyDatePicker(
                textfieldController: workExperienceTo,
                hintText: 'From',
                refresh: () {
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 20,
              ),
              //Text Controller
              MyDatePicker(
                textfieldController: workExperienceFrom,
                hintText: 'To',
                refresh: () {
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileTextField(
                customSize: MyUtility(context).width / 1.1,
                customHeight: MyUtility(context).height / 4,
                textFieldType: '',
                //Controller here
                textfieldController: workExperienceDescription,
                ////
                hintText: 'Description',
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  addRemoveWorkExperience("");
                },
                child: Text(
                  'Add More',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF174486),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF174486),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BoiFormText(mainFormText: 'Your Occupation/Work Experience'),
              const SizedBox(
                height: 20,
              ),
              WorkExperience(
                  workExperienceList: workExperience,
                  removeExperience: addRemoveWorkExperience),

              SizedBox(
                height: 10,
              ),

              BoiFormText(mainFormText: 'Qualifications:'),

              SizedBox(
                height: 10,
              ),

              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'Note: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text:
                            'Each qaulification is comma delimited in this format:\n',
                        style: TextStyle(fontSize: 16)),
                    TextSpan(
                        text: 'University - Qaulification - Year',
                        style: TextStyle(fontSize: 16))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

              LongTextField(
                textFieldWidth: MyUtility(context).width / 1.1,
                //Text Controller
                textEditingController: qualification,
                lines: 5,
              ),
              const SizedBox(
                height: 20,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'Institution Name - Qualification Desc -\n',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: 'Qualification Year\n',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: 'Free State University',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BoiFormText(mainFormText: 'Published Articles:'),
              const SizedBox(
                height: 10,
              ),
              MyDatePicker(
                hintText: 'Select Date',
                //Text Controller
                textfieldController: articleDate,
                refresh: () {
                  setState(() {});
                },
                //////
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileTextField(
                hintText: 'Description',
                customSize: MyUtility(context).width / 1.1,
                textFieldType: '',
                //Text Controller
                textfieldController: articleDescription,
                ///////
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  addRemoveArticle("");
                },
                child: Text(
                  'Add More',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF174486),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF174486),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              BoiFormText(mainFormText: 'Your Published articles:'),
              const SizedBox(
                height: 10,
              ),
              PublishedArticlesTable(
                  articlesList: articles, removeArticle: addRemoveArticle),

              const SizedBox(
                height: 10,
              ),

              BoiFormText(mainFormText: 'Volunteer Work:'),

              const SizedBox(
                height: 10,
              ),
              MyDatePicker(
                hintText: 'Select Date',
                //Text Controller
                textfieldController: volunteerDate,
                refresh: () {
                  setState(() {});
                },
                //////
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileTextField(
                customSize: MyUtility(context).width / 1.1,
                hintText: 'Description',
                textFieldType: '',
                //Text Controller
                textfieldController: volunteerDescription,
                ///////
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  addRemoveVolunteer("");
                },
                child: Text(
                  'Add More',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF174486),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF174486),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              VolunteerWorkTable(
                  volunteerWork: volunteerWork,
                  removeVolunteerWork: addRemoveVolunteer),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Why do you seek a position on the SAMA Gauteng Council ?',
                style: GoogleFonts.openSans(
                  fontSize: 18,
                  height: 1.2,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'Hint: ',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: 'Maximum of 500 words allowed.',
                    style: TextStyle(fontSize: 12)),
              ])),

              LongTextField(
                textFieldWidth: MyUtility(context).width / 1.1,
                //Text Controller
                textEditingController: TextEditingController(),
                lines: 10,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 125,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF174486),
                        ),
                        child: TextButton(
                          onPressed: () {
                            pickFile();
                          },
                          child: Text(
                            'Upload Cv',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      fileUploadStatus,
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 125,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF174486),
                  ),
                  child: TextButton(
                    onPressed: () {
                      updateUserBio();
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        width: MyUtility(context).width / 1.7,
        height: MyUtility(context).height / 1.2,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Curriculum Vitae/Biography',
                style: GoogleFonts.openSans(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF174486),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MyDidiver(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoiFormText(mainFormText: 'Date of Birth:'),
                  //Text Controller
                  MyDatePicker(
                    textfieldController: dob,
                    hintText: 'Date of Birth',
                    refresh: () {
                      setState(() {});
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              MyDidiver(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoiFormText(mainFormText: 'Marital Status:'),
                  ProfileDropDownField(
                    customSize: 300,
                    //Controller here
                    textfieldController: maritalStatus,
                    items: ['Married', 'Single'],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              MyDidiver(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BoiFormText(mainFormText: 'Occupation/Work Experience:'),
                      /*  const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Click the link above to view your Occupation/Work Experience.',
                      style: GoogleFonts.openSans(fontSize: 12),
                    )*/
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Text Controller
                      MyDatePicker(
                        textfieldController: workExperienceTo,
                        hintText: 'From',
                        refresh: () {
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //Text Controller
                      MyDatePicker(
                        textfieldController: workExperienceFrom,
                        hintText: 'To',
                        refresh: () {
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProfileTextField(
                        customSize: 300,
                        textFieldType: '',
                        //Controller here
                        textfieldController: workExperienceDescription,
                        ////
                        hintText: 'Description',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          addRemoveWorkExperience("");
                        },
                        child: Text(
                          'Add More',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF174486),
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF174486),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const MyDidiver(),
              const SizedBox(
                height: 30,
              ),
              BoiFormText(mainFormText: 'Your Occupation/Work Experience'),
              const SizedBox(
                height: 30,
              ),
              WorkExperience(
                  workExperienceList: workExperience,
                  removeExperience: addRemoveWorkExperience),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Container(
                  width: MyUtility(context).width / 1.7,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(252, 251, 242, 1),
                    border: Border.all(
                      color: Color.fromRGBO(250, 240, 201, 1),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: 'N.B: ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  'Qualifications can only be updated if your SAMA Number under Details is up to date.',
                              style: TextStyle(fontSize: 16))
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
              const MyDidiver(),
              const SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BoiFormText(mainFormText: 'Qualifications:'),
                      const SizedBox(
                        height: 8,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Note: ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'Each qaulification is comma delimited in this format:\n',
                                style: TextStyle(fontSize: 16)),
                            TextSpan(
                                text: 'University - Qaulification - Year',
                                style: TextStyle(fontSize: 16))
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      LongTextField(
                        textFieldWidth: 300,
                        //Text Controller
                        textEditingController: qualification,
                        lines: 5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text:
                                    'Institution Name - Qualification Desc -\n',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: 'Qualification Year\n',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: 'Free State University',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const MyDidiver(),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BoiFormText(mainFormText: 'Published Articles:'),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyDatePicker(
                        hintText: 'Select Date',
                        //Text Controller
                        textfieldController: articleDate,
                        refresh: () {
                          setState(() {});
                        },
                        //////
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProfileTextField(
                        hintText: 'Description',
                        customSize: 300,
                        textFieldType: '',
                        //Text Controller
                        textfieldController: articleDescription,
                        ///////
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          addRemoveArticle("");
                        },
                        child: Text(
                          'Add More',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF174486),
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF174486),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const MyDidiver(),
              const SizedBox(
                height: 30,
              ),
              BoiFormText(mainFormText: 'Your Published articles:'),
              const SizedBox(
                height: 15,
              ),
              PublishedArticlesTable(
                  articlesList: articles, removeArticle: addRemoveArticle),
              const SizedBox(
                height: 50,
              ),
              const MyDidiver(),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BoiFormText(mainFormText: 'Volunteer Work:'),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyDatePicker(
                        hintText: 'Select Date',
                        //Text Controller
                        textfieldController: volunteerDate,
                        refresh: () {
                          setState(() {});
                        },
                        //////
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProfileTextField(
                        customSize: 300,
                        hintText: 'Description',
                        textFieldType: '',
                        //Text Controller
                        textfieldController: volunteerDescription,
                        ///////
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          addRemoveVolunteer("");
                        },
                        child: Text(
                          'Add More',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF174486),
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF174486),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const MyDidiver(),
              const SizedBox(
                height: 30,
              ),
              BoiFormText(mainFormText: 'Your Volunteer Work:'),
              const SizedBox(
                height: 15,
              ),
              VolunteerWorkTable(
                  volunteerWork: volunteerWork,
                  removeVolunteerWork: addRemoveVolunteer),
              const SizedBox(
                height: 30,
              ),
              MyDidiver(),
              Text(
                'We want to understand your views on current operations and membership needs and how your potential contributors might fit with the SAMA\'S vision.\nPlease answer the following questions. (Limit your response to the space provided).',
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold, height: 1.3, fontSize: 16),
              ),
              const SizedBox(
                height: 15,
              ),
              MyDidiver(),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Why do you seek a position on the SAMA Gauteng Council ?',
                        style: GoogleFonts.openSans(
                          fontSize: 18,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Hint: ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: 'Maximum of 500 words allowed.',
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  LongTextField(
                    textFieldWidth: 300,
                    //Text Controller
                    textEditingController: TextEditingController(),
                    lines: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              MyDidiver(),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SAMA leadership motivation- Please outline the specific skills you bring,\nor contributions you hope to make to SAMA:',
                        style: GoogleFonts.openSans(
                          fontSize: 18,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Hint: ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: 'Maximum of 500 words allowed.',
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  LongTextField(
                    textFieldWidth: 300,
                    //Text Controller
                    textEditingController: TextEditingController(),
                    lines: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const MyDidiver(),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MyUtility(context).width / 2.5,
                    child: Text(
                      'Are you currently serving on any other board of directors, committees or leadership positions for another organisations, whether in your private or professional capacity? if so, please list organisation name and your position/role:',
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileTextField(
                        customSize: 300,
                        hintText: 'Organisation name',
                        textFieldType: '',
                        //Text Controller
                        textfieldController: organizationName,
                        ///////
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProfileTextField(
                        customSize: 300,
                        hintText: 'Position/role',
                        textFieldType: '',
                        //Text Controller
                        textfieldController: organizationRole,
                        ///////
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          addRemoveOrganization("");
                        },
                        child: Text(
                          'Add More',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF174486),
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF174486),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const MyDidiver(),
              const SizedBox(
                height: 30,
              ),
              BoiFormText(mainFormText: 'Your Organisations:'),
              const SizedBox(
                height: 15,
              ),
              OrganisationsTable(
                  removeOrganization: addRemoveOrganization,
                  organizations: organizations),
              const SizedBox(
                height: 30,
              ),
              const MyDidiver(),
              Row(
                children: [
                  SizedBox(
                    width: MyUtility(context).width / 2.5,
                    child: Text(
                      'Have you ever been involved in or have a pending disciplinary action against in your capacity as a SAMA member for allegedly breaching SAMA\'s code of conduct or other governance documents?',
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Spacer(),
                  CheckBoxCircle(
                    header: 'Yes',
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  CheckBoxCircle(
                    header: 'No',
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const MyDidiver(),
              Row(
                children: [
                  SizedBox(
                    width: MyUtility(context).width / 2.5,
                    child: Text(
                      'Have you ever been involved in or have a pending disciplinary action against you at the HPCSA?',
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Spacer(),
                  CheckBoxCircle(
                    header: 'Yes',
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  CheckBoxCircle(
                    header: 'No',
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const MyDidiver(),
              Row(
                children: [
                  SizedBox(
                    width: MyUtility(context).width / 2.5,
                    child: Text(
                      'Have you ever received a civil judgement against you?',
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Spacer(),
                  CheckBoxCircle(
                    header: 'Yes',
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  CheckBoxCircle(
                    header: 'No',
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const MyDidiver(),
              Row(
                children: [
                  SizedBox(
                    width: MyUtility(context).width / 2.5,
                    child: Text(
                      'Have you ever been removed from a position of trust?',
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Spacer(),
                  CheckBoxCircle(
                    header: 'Yes',
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  CheckBoxCircle(
                    header: 'No',
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const MyDidiver(),
              Row(
                children: [
                  SizedBox(
                    width: MyUtility(context).width / 2.5,
                    child: Text(
                      'Have you ever been charged and/or convicted of crime?',
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Spacer(),
                  CheckBoxCircle(
                    header: 'Yes',
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  CheckBoxCircle(
                    header: 'No',
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const MyDidiver(),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: MyUtility(context).width * 0.05,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF174486),
                      ),
                      child: TextButton(
                        onPressed: () {
                          pickFile();
                        },
                        child: Text(
                          'Upload Cv',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    fileUploadStatus,
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MyUtility(context).width * 0.05,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF174486),
                  ),
                  child: TextButton(
                    onPressed: () {
                      updateUserBio();
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
