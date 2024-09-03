import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/profile/bio.dart';

import '../../components/MyDivider.dart';
import '../../components/myutility.dart';
import '../../components/profileTextField.dart';

class MemberProfile extends StatefulWidget {
  String id;
  Function closeDialog;
  MemberProfile({super.key, required this.id, required this.closeDialog});

  @override
  State<MemberProfile> createState() => _MemberProfileState();
}

class _MemberProfileState extends State<MemberProfile> {
  final title = TextEditingController();
  final initials = TextEditingController();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final mobileNo = TextEditingController();
  final landline = TextEditingController();

  final gender = TextEditingController();
  final race = TextEditingController();
  final dob = TextEditingController();

  final idNumber = TextEditingController();
  final passportNumber = TextEditingController();

  final hpcsa = TextEditingController();
  final practiceNumber = TextEditingController();

  final univercityName = TextEditingController();
  final univercityQualification = TextEditingController();
  final qualificationYear = TextEditingController();
  final qualificationMonth = TextEditingController();

  final samaNumber = TextEditingController();

  getUserDetails() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .get();

    if (data.exists) {
      setState(() {
        title.text = data.get('title');
        initials.text = data.get('initials');

        firstName.text = data.get('firstName');
        lastName.text = data.get('lastName');
        email.text = data.get('email');
        mobileNo.text = data.get('mobileNo');
        landline.text = data.get('landline');

        gender.text = data.get('gender');
        race.text = data.get('race');
        dob.text = data.get('dob');

        idNumber.text = data.get('idNumber');
        passportNumber.text = data.get('passportNumber');

        hpcsa.text = data.get('hpcsaNumber');
        practiceNumber.text = data.get('practiceNumber');

        univercityQualification.text = data.get('univercityQualification');
        qualificationYear.text = data.get('qualificationYear');
        qualificationMonth.text = data.get('qualificationMonth');
      });
    }
  }

  updateSamaNumber() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"samaNumber": samaNumber.text});
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MyUtility(context).width / 2,
        height: 680,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Spacer(),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            widget.closeDialog!();
                          },
                          child: Icon(Icons.cancel),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Member Details',
                  style: GoogleFonts.openSans(
                      fontSize: 24,
                      color: Color(0xFF174486),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                MyDidiver(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            BoiFormText(mainFormText: 'Title:'),
                            SizedBox(
                              width: 8,
                            ),
                            BoiFormText2(mainFormText: title.text),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            BoiFormText(mainFormText: 'Initials:'),
                            SizedBox(
                              width: 8,
                            ),
                            BoiFormText2(mainFormText: initials.text),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            BoiFormText(mainFormText: 'First Name:'),
                            SizedBox(
                              width: 8,
                            ),
                            BoiFormText2(mainFormText: firstName.text),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            BoiFormText(mainFormText: 'Last Name:'),
                            SizedBox(
                              width: 8,
                            ),
                            BoiFormText2(mainFormText: lastName.text),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 30,
                ),
                MyDidiver(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            BoiFormText(mainFormText: 'Email:'),
                            SizedBox(
                              width: 8,
                            ),
                            BoiFormText2(mainFormText: email.text),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            BoiFormText(mainFormText: 'Mobile No'),
                            SizedBox(
                              width: 8,
                            ),
                            BoiFormText2(mainFormText: mobileNo.text),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            BoiFormText(mainFormText: 'Landline'),
                            SizedBox(
                              width: 8,
                            ),
                            BoiFormText2(mainFormText: landline.text),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                MyDidiver(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            BoiFormText(mainFormText: 'Gender:'),
                            SizedBox(
                              width: 8,
                            ),
                            BoiFormText2(mainFormText: gender.text),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            BoiFormText(mainFormText: 'Race:'),
                            SizedBox(
                              width: 8,
                            ),
                            BoiFormText2(mainFormText: race.text),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              BoiFormText(mainFormText: 'Date of Birth:'),
                              SizedBox(
                                width: 8,
                              ),
                              BoiFormText2(mainFormText: dob.text),
                            ],
                          ),
                        ],
                      ),
                    ]),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            BoiFormText(mainFormText: 'ID Number:'),
                            SizedBox(
                              width: 8,
                            ),
                            BoiFormText2(mainFormText: idNumber.text),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            BoiFormText(mainFormText: 'PassportNumber:'),
                            SizedBox(
                              width: 8,
                            ),
                            BoiFormText2(mainFormText: passportNumber.text),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            BoiFormText(mainFormText: 'SAMA Number:'),
                            SizedBox(
                              width: 8,
                            ),
                            ProfileTextField(
                                customSize: MyUtility(context).width * 0.3,
                                description: "",
                                textfieldController: landline,
                                textFieldType: "")
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
        )));
  }
}
