import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sama/PostLoginLandingPage.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/profileTextField.dart';
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

  final univercityName = TextEditingController();
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
      "univercityName": univercityName.text,
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

//Select a date popup
  onTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(1900),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    dob.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Container(
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
                                textFieldType: "stringType"),
                            SizedBox(
                              width: MyUtility(context).width * 0.015,
                            ),
                            ProfileTextField(
                                customSize: MyUtility(context).width * 0.3,
                                description: "Initials",
                                textfieldController: initials,
                                textFieldType: "stringType")
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
                              textFieldType: "stringType"),
                          SizedBox(
                            width: MyUtility(context).width * 0.015,
                          ),
                          ProfileTextField(
                              customSize: MyUtility(context).width * 0.3,
                              description: "Last Name",
                              textfieldController: lastName,
                              textFieldType: "stringType")
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
                              textFieldType: "emailType"),
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
                              textFieldType: "stringType"),
                          SizedBox(
                            width: MyUtility(context).width * 0.015,
                          ),
                          ProfileTextField(
                              customSize: MyUtility(context).width * 0.3,
                              description: "Landline",
                              textfieldController: landline,
                              textFieldType: "stringType")
                        ],
                      ),
                      SizedBox(
                        height: MyUtility(context).height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfileDropDownField(
                            description: "Gender",
                            items: ["Male", "Female"],
                            customSize: MyUtility(context).width * 0.195,
                            textfieldController: gender,
                          ),

                          /*  ProfileTextField(
                              customSize: MyUtility(context).width * 0.195,
                              description: "Gender",
                              textfieldController: gender,
                              textFieldType: "stringType"),*/
                          SizedBox(
                            width: MyUtility(context).width * 0.015,
                          ),
                          ProfileTextField(
                              customSize: MyUtility(context).width * 0.195,
                              description: "Race",
                              textfieldController: race,
                              textFieldType: "stringType"),
                          SizedBox(
                            width: MyUtility(context).width * 0.015,
                          ),
                          /* ProfileTextField(
                              customSize: MyUtility(context).width * 0.195,
                              description: "Date of birth",
                              textfieldController: dob,
                              textFieldType: "stringType"),
*/
                          SizedBox(
                            width: MyUtility(context).width * 0.195,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date of Birth",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFF6A6A6A),
                                    ),
                                  ),
                                  Container(
                                    width: MyUtility(context).width * 0.195,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: TextField(
                                      controller: dob,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                          hintText:
                                              "Click here to select date"),
                                      onTap: () =>
                                          onTapFunction(context: context),
                                    ),
                                  )
                                ]),
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
                              textFieldType: "intType"),
                          SizedBox(
                            width: MyUtility(context).width * 0.015,
                          ),
                          ProfileTextField(
                              customSize: MyUtility(context).width * 0.3,
                              description: "Passport number",
                              textfieldController: passportNumber,
                              textFieldType: "intType")
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
                              textFieldType: "stringType"),
                          SizedBox(
                            width: MyUtility(context).width * 0.015,
                          ),
                          ProfileTextField(
                              customSize: MyUtility(context).width * 0.3,
                              description: "Practice number",
                              textfieldController: practiceNumber,
                              textFieldType: "stringType")
                        ],
                      ),
                      SizedBox(
                        height: MyUtility(context).height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfileDropDownField(
                            description: "University Names",
                            items: [
                              "Sefako Makgatho Health Sciences University",
                              "University of Cape Town",
                              "University of KwaZulu-Natal",
                              "University of Limpopo",
                              "University of Pretoria",
                              "University of Stellenbosch",
                              "University of the Witwatersrand",
                              "Walter Sisulu University",
                              "Nelson Mandela University",
                              "North-West University",
                              "University of the Western Cape",
                              "University of Johannesburg",
                              "Other",
                            ],
                            customSize: MyUtility(context).width / 7,
                            textfieldController: univercityName,
                          ),
                          /*    ProfileTextField(
                              customSize: MyUtility(context).width / 7,
                              description: "University Name",
                              textfieldController: univercityName,
                              textFieldType: "stringType"),*/
                          SizedBox(
                            width: MyUtility(context).width * 0.015,
                          ),
                          ProfileDropDownField(
                            description: "University Qualification",
                            items: [
                              "Bachelor's Degree",
                              "Honours Degree",
                              "Master's Degree",
                              "Doctoral Degree"
                            ],
                            customSize: MyUtility(context).width / 7,
                            textfieldController: univercityQualification,
                          ),

                          /*    ProfileTextField(
                              customSize: MyUtility(context).width / 7,
                              description: "University Qualification",
                              textfieldController: univercityQualification,
                              textFieldType: "stringType"),*/
                          SizedBox(
                            width: MyUtility(context).width * 0.015,
                          ),
                          ProfileTextField(
                              customSize: MyUtility(context).width / 7,
                              description: "Qualification year",
                              textfieldController: qualificationYear,
                              textFieldType: "stringType"),
                          SizedBox(
                            width: MyUtility(context).width * 0.015,
                          ),
                          ProfileTextField(
                              customSize: MyUtility(context).width / 7,
                              description: "Qualification month",
                              textfieldController: qualificationMonth,
                              textFieldType: "stringType")
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
                                    if (_formKey.currentState!.validate()) {
                                      updateProfile();
                                    }
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
          ),
        ),
      ),
    );
  }
}
