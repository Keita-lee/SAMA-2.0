import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/PostLoginLandingPage.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/userState.dart';
import 'package:sama/login/registerFinished.dart';
import 'package:sama/profile/EditProfile.dart';

class RegisterFullProfile extends StatefulWidget {
  const RegisterFullProfile({super.key});

  @override
  State<RegisterFullProfile> createState() => _RegisterFullProfileState();
}

class _RegisterFullProfileState extends State<RegisterFullProfile> {
  // Text controllers
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

  final univercityQualification = TextEditingController();
  final qualificationYear = TextEditingController();
  final qualificationMonth = TextEditingController();

  final password = TextEditingController();

  //var
  String userType = "";
  getUserData() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
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

        hpcsa.text = data.get('hpcsa');
        practiceNumber.text = data.get('practiceNumber');

        univercityQualification.text = data.get('univercityQualification');
        qualificationYear.text = data.get('qualificationYear');
        qualificationMonth.text = data.get('qualificationMonth');

        password.text = data.get('password');
        userType = data.get('userType');
      });
    }
  }

  updateProfile() async {
    var userData = {
      "title": title.text,
      "initials": initials.text,
      "firstName": firstName.text,
      "lastName": lastName.text,
      "email": email.text,
      "mobileNo": mobileNo.text,
      "landline": landline.text,
      "profilePic": "",
      "gender": gender.text,
      "race": race.text,
      "dob": dob.text,
      "idNumber": idNumber.text,
      "passportNumber": passportNumber.text,
      "hpcsa": hpcsa.text,
      "practiceNumber": practiceNumber.text,
      "univercityQualification": univercityQualification.text,
      "qualificationYear": qualificationYear.text,
      "qualificationMonth": qualificationMonth.text,
      "password": password.text,
      "userType": userType,
      "id": FirebaseAuth.instance.currentUser!.uid
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(userData);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Material(child: RegisterFinished())));
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MyUtility(context).width,
        height: MyUtility(context).height,
        color: const Color.fromARGB(255, 8, 55, 145),
        child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                      width: MyUtility(context).width / 4,
                      height: MyUtility(context).height / 3.5,
                      image: AssetImage('images/sama_logo.png')),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ProfileTextField(
                                customSize: MyUtility(context).width * 0.3,
                                description: "Title",
                                textfieldController: title,
                              ),
                              SizedBox(
                                width: MyUtility(context).width * 0.015,
                              ),
                              ProfileTextField(
                                customSize: MyUtility(context).width * 0.3,
                                description: "Initials",
                                textfieldController: initials,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MyUtility(context).height * 0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProfileTextField(
                              customSize: MyUtility(context).width * 0.3,
                              description: "First Name",
                              textfieldController: firstName,
                            ),
                            SizedBox(
                              width: MyUtility(context).width * 0.015,
                            ),
                            ProfileTextField(
                              customSize: MyUtility(context).width * 0.3,
                              description: "Last Name",
                              textfieldController: lastName,
                            )
                          ],
                        ),
                        SizedBox(
                          height: MyUtility(context).height * 0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProfileTextField(
                              customSize: MyUtility(context).width * 0.615,
                              description: "Email",
                              textfieldController: email,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MyUtility(context).height * 0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProfileTextField(
                              customSize: MyUtility(context).width * 0.3,
                              description: "Mobile No",
                              textfieldController: mobileNo,
                            ),
                            SizedBox(
                              width: MyUtility(context).width * 0.015,
                            ),
                            ProfileTextField(
                              customSize: MyUtility(context).width * 0.3,
                              description: "Landline",
                              textfieldController: landline,
                            )
                          ],
                        ),
                        SizedBox(
                          height: MyUtility(context).height * 0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProfileTextField(
                              customSize: MyUtility(context).width * 0.195,
                              description: "Gender",
                              textfieldController: gender,
                            ),
                            SizedBox(
                              width: MyUtility(context).width * 0.015,
                            ),
                            ProfileTextField(
                              customSize: MyUtility(context).width * 0.195,
                              description: "Race",
                              textfieldController: race,
                            ),
                            SizedBox(
                              width: MyUtility(context).width * 0.015,
                            ),
                            ProfileTextField(
                              customSize: MyUtility(context).width * 0.195,
                              description: "Date of birth",
                              textfieldController: dob,
                            )
                          ],
                        ),
                        SizedBox(
                          height: MyUtility(context).height * 0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProfileTextField(
                              customSize: MyUtility(context).width * 0.3,
                              description: "ID number",
                              textfieldController: idNumber,
                            ),
                            SizedBox(
                              width: MyUtility(context).width * 0.015,
                            ),
                            ProfileTextField(
                              customSize: MyUtility(context).width * 0.3,
                              description: "Passport number",
                              textfieldController: passportNumber,
                            )
                          ],
                        ),
                        SizedBox(
                          height: MyUtility(context).height * 0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProfileTextField(
                              customSize: MyUtility(context).width * 0.3,
                              description: "HPCSA number",
                              textfieldController: hpcsa,
                            ),
                            SizedBox(
                              width: MyUtility(context).width * 0.015,
                            ),
                            ProfileTextField(
                              customSize: MyUtility(context).width * 0.3,
                              description: "Practice number",
                              textfieldController: practiceNumber,
                            )
                          ],
                        ),
                        SizedBox(
                          height: MyUtility(context).height * 0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProfileTextField(
                              customSize: MyUtility(context).width * 0.195,
                              description: "University Qualification",
                              textfieldController: univercityQualification,
                            ),
                            SizedBox(
                              width: MyUtility(context).width * 0.015,
                            ),
                            ProfileTextField(
                              customSize: MyUtility(context).width * 0.195,
                              description: "Qualification year",
                              textfieldController: qualificationYear,
                            ),
                            SizedBox(
                              width: MyUtility(context).width * 0.015,
                            ),
                            ProfileTextField(
                              customSize: MyUtility(context).width * 0.195,
                              description: "Qualification month",
                              textfieldController: qualificationMonth,
                            )
                          ],
                        ),
                        SizedBox(
                          height: MyUtility(context).height * 0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MyUtility(context).width / 1.62,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: MyUtility(context).width * 0.05,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF174486),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      updateProfile();
                                    },
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MyUtility(context).height * 0.1,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
