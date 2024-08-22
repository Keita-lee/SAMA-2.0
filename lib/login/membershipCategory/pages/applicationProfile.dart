import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/homePage/PostLoginLandingPage.dart';

import 'package:sama/components/myutility.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/login/registerFinished.dart';
import 'package:sama/profile/EditProfile.dart';
import 'package:sama/components/constants.dart' as constants;

class ApplicationProfile extends StatefulWidget {
  const ApplicationProfile({super.key});

  @override
  State<ApplicationProfile> createState() => _ApplicationProfileState();
}

class _ApplicationProfileState extends State<ApplicationProfile> {
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
  var allUniversities = constants.availableUniversities;
  var universityQualifications = constants.qualifications;
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
      "email": (email.text).toLowerCase(),
      "mobileNo": mobileNo.text,
      "landline": landline.text,
      "profilePic":
          "https://firebasestorage.googleapis.com/v0/b/sama-959a2.appspot.com/o/images%2Fistockphoto-1495088043-612x612.jpg?alt=media&token=6355d1a2-7572-4221-99a3-a2823af52372",
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
      "profilePicView": "",
      "profileView": "",
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
    bool showRegisterBorder = false;
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Container(
        color: Color(0xFFF8FAFF),
        width: MyUtility(context).width,
        height: MyUtility(context).height,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MyUtility(context).height * 0.02,
                ),
                SizedBox(
                  width: MyUtility(context).width / 1.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image(
                              width: MyUtility(context).width / 10,
                              height: MyUtility(context).height / 8.0,
                              image: AssetImage('images/sama_logo.png')),
                          Text(
                            "SAMA Member Portal",
                            style: GoogleFonts.openSans(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Material(
                                        child: Material(
                                            child: PostLoginLandingPage(
                                          userId: "",
                                          activeIndex: 0,
                                        )),
                                      )));
                        },
                        onHover: (hovered) {
                          setState(() {
                            showRegisterBorder = hovered;
                          });
                        },
                        child: Text(
                          "Visit the website",
                          style: TextStyle(
                              decoration: showRegisterBorder == true
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                              decorationColor: Color.fromRGBO(0, 159, 158, 1),
                              decorationThickness: 2,
                              fontSize: 16,
                              color: const Color.fromRGBO(0, 159, 158, 1)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: MyUtility(context).width / 1.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: StyleButton(
                          description: "LOGIN",
                          height: 50,
                          buttonColor: Color.fromRGBO(0, 159, 158, 1),
                          width: 130,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MyUtility(context).width / 1.3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1.0,
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MyUtility(context).height * 0.05,
                        ),
                        SizedBox(
                          width: MyUtility(context).width / 1.63,
                          child: Text(
                            "Membership Sign Up",
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                              color: Color.fromRGBO(0, 159, 158, 1),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        /* Center(
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
                        ),*/
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
                                description: "Mobile Number",
                                textfieldController: mobileNo,
                                textFieldType: "stringType"),
                            SizedBox(
                              width: MyUtility(context).width * 0.015,
                            ),
                            ProfileTextField(
                                customSize: MyUtility(context).width * 0.3,
                                description: "Landline",
                                textfieldController: landline,
                                textFieldType: "")
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
                            ProfileDropDownField(
                              description: "Race",
                              items: [
                                "White/Caucasian",
                                "Hispanic/Latino",
                                "Black",
                                "Asian",
                                "Native American",
                                "Pacific Islander",
                                "Middle Eastern/North African",
                                "Other",
                              ],
                              customSize: MyUtility(context).width * 0.195,
                              textfieldController: race,
                            ),
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
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.5,
                                        color: Color(0xFF6A6A6A),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: MyUtility(context).width * 0.195,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.grey,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ID number",
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.5,
                                    color: Color(0xFF6A6A6A),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: MyUtility(context).width * 0.3,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (passportNumber.text == "") {
                                        if (value != null && value.isEmpty) {
                                          if (value.length == 13) {
                                            return "Id length should be 13 characters";
                                          }
                                        }

                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a value';
                                        }

                                        if (num.tryParse(value) == null) {
                                          return 'Please enter number value';
                                        }
                                      } else {
                                        return null;
                                      }

                                      return null;
                                    },
                                    controller: idNumber,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 153, 147, 147),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          new EdgeInsets.only(left: 12.0),
                                      border: InputBorder.none,
                                      hintText: "",
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 199, 199, 199),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MyUtility(context).width * 0.015,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Passport Number",
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.5,
                                    color: Color(0xFF6A6A6A),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: MyUtility(context).width * 0.3,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (idNumber.text == "") {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a value';
                                        }

                                        if (num.tryParse(value) == null) {
                                          return 'Please enter number value';
                                        }
                                      } else {
                                        return null;
                                      }

                                      return null;
                                    },
                                    controller: passportNumber,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 153, 147, 147),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          new EdgeInsets.only(left: 12.0),
                                      border: InputBorder.none,
                                      hintText: "",
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 199, 199, 199),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                              items: allUniversities,
                              customSize: MyUtility(context).width * 0.3,
                              textfieldController: univercityName,
                            ),
                            SizedBox(
                              width: MyUtility(context).width * 0.015,
                            ),
                            ProfileDropDownField(
                              description: "University Qualification",
                              items: universityQualifications,
                              customSize: MyUtility(context).width * 0.3,
                              textfieldController: univercityQualification,
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
                            /* ProfileDropDownField(
                              description: "University Names",
                              items: allUniversities,
                              customSize: MyUtility(context).width / 7,
                              textfieldController: univercityName,
                            ),
                            SizedBox(
                              width: MyUtility(context).width * 0.015,
                            ),
                            ProfileDropDownField(
                              description: "University Qualification",
                              items: universityQualifications,
                              customSize: MyUtility(context).width / 7,
                              textfieldController: univercityQualification,
                            ),*/

                            ProfileTextField(
                                customSize: MyUtility(context).width * 0.3,
                                description: "Qualification year",
                                textfieldController: qualificationYear,
                                textFieldType: "stringType"),
                            SizedBox(
                              width: MyUtility(context).width * 0.015,
                            ),
                            ProfileDropDownField(
                              description: "Qualification month",
                              items: [
                                "January",
                                "February",
                                "March",
                                "April",
                                "May",
                                "June",
                                "July",
                                "August",
                                "September ",
                                "October",
                                "November",
                                "December",
                              ],
                              customSize: MyUtility(context).width * 0.3,
                              textfieldController: qualificationMonth,
                            ),
                            /*  ProfileTextField(
                                customSize: MyUtility(context).width / 7,
                                description: "Qualification month",
                                textfieldController: qualificationMonth,
                                textFieldType: "stringType")*/
                          ],
                        ),
                        SizedBox(
                          height: MyUtility(context).height * 0.015,
                        ),
                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MyUtility(context).width / 1.62,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  //width: MyUtility(context).width * 0.05,
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
                                      'SUBMIT',
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
                        ),*/
                        SizedBox(
                          width: MyUtility(context).width / 1.63,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: StyleButton(
                                  description: "SUBMIT",
                                  height: 50,
                                  buttonColor: Color.fromRGBO(0, 159, 158, 1),
                                  width: 130,
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      updateProfile();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MyUtility(context).height * 0.1,
                        )
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  child: Image.asset(
                    'images/bannerBackground.jpg',
                    width: MyUtility(context).width / 1.3,
                    height: MyUtility(context).height * 0.04,
                    fit: BoxFit.cover,
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
