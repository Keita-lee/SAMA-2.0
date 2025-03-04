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

import '../../../components/email/payments/debitOrder.dart';
import '../../../components/email/payments/eftPayment.dart';
import '../../../components/email/payments/onlinePayment.dart';
import '../../loginPages/membershipSignUp.dart';

class ApplicationProfile extends StatefulWidget {
  String email;
  Function(int) nextSection;
  Map debitOrder;
  String paymentType;
  String prodCatCde;
  Map paymentDetails;
  bool shouldShowPrevBtn;
  ApplicationProfile(
      {super.key,
      required this.email,
      required this.nextSection,
      required this.debitOrder,
      required this.paymentType,
      required this.prodCatCde,
      required this.paymentDetails,
      required this.shouldShowPrevBtn});

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
  String userId = "";
  getUserData() async {
    print("Get userData");
    print(widget.email);
    if (widget.email != "") {
      final dataEmail = await FirebaseFirestore.instance
          .collection('users')
          .where("email", isEqualTo: widget.email)
          .get();
      print("No Email");
      if (dataEmail.docs.isNotEmpty) {
        setState(() {
          print("Get EMAIL");
          firstName.text = dataEmail.docs[0].get('firstName');
          lastName.text = dataEmail.docs[0].get('lastName');
          email.text = dataEmail.docs[0].get('email');
          userId = dataEmail.docs[0].get('id');
        });
      }
    } else {
      final data = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (data.exists) {
        firstName.text = data.get('firstName');
        lastName.text = data.get('lastName');
        email.text = data.get('email');
      }
    }
  }

  sendUpdatedEmail() async {
    print("Email sent");
    if (widget.paymentDetails['type'] == "PAY ONLINE") {
      await sendOnlineUpdate(
          name: '${firstName.text} ${lastName.text}', email: email.text);
    } else if (widget.paymentDetails['type'] == "MANUAL EFT") {
      await sendEftUpdate(
          name: '${firstName.text} ${lastName.text}',
          email: email.text,
          invno: widget.paymentDetails['ref']);
    } else {
      await sendDebitUpdate(
          name: '${firstName.text} ${lastName.text}', email: email.text);
    }
  }

  updateProfile() async {
    var userData = {
      "paymentDetails": widget.paymentDetails,
      "bankAccHolder": widget.debitOrder['bankAccHolder'],
      "bankAccNo": widget.debitOrder['bankAccNo'],
      "bankAccType": widget.debitOrder['bankAccType'],
      "bankBranchCde": widget.debitOrder['bankBranchCde'],
      "bankBranchName": widget.debitOrder['bankBranchName'],
      "bankDisclaimer": widget.debitOrder['bankDisclaimer'],
      "bankName": widget.debitOrder['bankName'],
      "bankPaymAnnual": "",
      "bankPaymMonthly": "",
      "prodCatCde": widget.prodCatCde,

      "title": title.text,
      "initials": initials.text,
      "firstName": firstName.text,
      "lastName": lastName.text,
      "email": (email.text).toLowerCase(),
      "mobileNo": mobileNo.text,
      "landline": landline.text, //
      "profilePic":
          "https://firebasestorage.googleapis.com/v0/b/sama-959a2.appspot.com/o/images%2Fistockphoto-1495088043-612x612.jpg?alt=media&token=6355d1a2-7572-4221-99a3-a2823af52372",
      "gender": gender.text,
      "race": race.text,
      "dob": dob.text,
      "idNumber": idNumber.text,
      "passportNumber": passportNumber.text,
      "hpcsaNumber": hpcsa.text, //
      "practiceNumber": practiceNumber.text,

      "univercityQualification": univercityQualification.text,
      "univercityName": univercityName.text,
      "qualificationYear": qualificationYear.text,
      "qualificationMonth": qualificationMonth.text,
      "password": password.text,
      "userType": userType,
      "profilePicView": "",
      "profileView": "",
      "id":
          widget.email != "" ? userId : FirebaseAuth.instance.currentUser!.uid,
      "status": "Pending",
      "regionCde": ""
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.email != ""
            ? userId
            : FirebaseAuth.instance.currentUser!.uid)
        .update(userData);

    await sendUpdatedEmail();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Material(child: MeshipRegFinished())));
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
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return Container(
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: Container(
          color: Color(0xFFF8FAFF),
          width: MyUtility(context).width,
          height: MyUtility(context).height,
          child: Padding(
            padding: isMobile ? EdgeInsets.all(5) : EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MyUtility(context).height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfileTextField(
                              customSize: isMobile
                                  ? MyUtility(context).width / 2 - 15
                                  : MyUtility(context).width * 0.27,
                              description: "First Name",
                              textfieldController: firstName,
                              textFieldType: "stringType"),
                          SizedBox(
                            width: MyUtility(context).width * 0.015,
                          ),
                          ProfileTextField(
                              customSize: isMobile
                                  ? MyUtility(context).width / 2 - 15
                                  : MyUtility(context).width * 0.27,
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
                                customSize: isMobile
                                    ? MyUtility(context).width / 2 - 15
                                    : MyUtility(context).width * 0.27,
                                description: "Title",
                                textfieldController: title,
                                textFieldType: "stringType"),
                            SizedBox(
                              width: MyUtility(context).width * 0.015,
                            ),
                            ProfileTextField(
                                customSize: isMobile
                                    ? MyUtility(context).width / 2 - 15
                                    : MyUtility(context).width * 0.27,
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
                              customSize: isMobile
                                  ? MyUtility(context).width / 1.1
                                  : MyUtility(context).width * 0.5,
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
                              customSize: isMobile
                                  ? MyUtility(context).width / 2 - 15
                                  : MyUtility(context).width * 0.27,
                              description: "Mobile Number",
                              textfieldController: mobileNo,
                              textFieldType: "stringType"),
                          SizedBox(
                            width: MyUtility(context).width * 0.015,
                          ),
                          ProfileTextField(
                              customSize: isMobile
                                  ? MyUtility(context).width / 2 - 15
                                  : MyUtility(context).width * 0.27,
                              description: "Landline",
                              textfieldController: landline,
                              textFieldType: "")
                        ],
                      ),
                      SizedBox(
                        height: MyUtility(context).height * 0.015,
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          ProfileDropDownField(
                            description: "Gender",
                            items: ["Male", "Female"],
                            customSize: isMobile
                                ? MyUtility(context).width / 2 - 15
                                : MyUtility(context).width * 0.17,
                            textfieldController: gender,
                          ),
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
                            customSize: isMobile
                                ? MyUtility(context).width / 2 - 15
                                : MyUtility(context).width * 0.17,
                            textfieldController: race,
                          ),
                          SizedBox(
                            width: MyUtility(context).width * 0.015,
                          ),
                          SizedBox(
                            width: isMobile
                                ? MyUtility(context).width / 1.1
                                : MyUtility(context).width * 0.17,
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
                                    width: isMobile
                                        ? MyUtility(context).width / 1.1
                                        : MyUtility(context).width * 0.195,
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
                                width: isMobile
                                    ? MyUtility(context).width / 2 - 15
                                    : MyUtility(context).width * 0.27,
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
                                      color: Color.fromARGB(255, 199, 199, 199),
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
                                width: isMobile
                                    ? MyUtility(context).width / 2 - 15
                                    : MyUtility(context).width * 0.27,
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
                                      color: Color.fromARGB(255, 199, 199, 199),
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
                              customSize: isMobile
                                  ? MyUtility(context).width / 2 - 15
                                  : MyUtility(context).width * 0.27,
                              description: "HPCSA number",
                              textfieldController: hpcsa,
                              textFieldType: "stringType"),
                          SizedBox(
                            width: MyUtility(context).width * 0.015,
                          ),
                          ProfileTextField(
                              customSize: isMobile
                                  ? MyUtility(context).width / 2 - 15
                                  : MyUtility(context).width * 0.27,
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
                            customSize: isMobile
                                ? MyUtility(context).width / 2 - 15
                                : MyUtility(context).width * 0.27,
                            textfieldController: univercityName,
                          ),
                          SizedBox(
                            width: MyUtility(context).width * 0.015,
                          ),
                          ProfileDropDownField(
                            description: "University Qualification",
                            items: universityQualifications,
                            customSize: isMobile
                                ? MyUtility(context).width / 2 - 15
                                : MyUtility(context).width * 0.27,
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
                              customSize: isMobile
                                  ? MyUtility(context).width / 2 - 15
                                  : MyUtility(context).width * 0.27,
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
                            customSize: isMobile
                                ? MyUtility(context).width / 2 - 15
                                : MyUtility(context).width * 0.27,
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
                        width: isMobile
                            ? MyUtility(context).width - 25
                            : MyUtility(context).width / 1.63,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            widget.shouldShowPrevBtn
                                ? StyleButton(
                                    buttonColor: const Color.fromARGB(
                                        255, 219, 219, 219),
                                    description: "PREVIOUS",
                                    height: 55,
                                    width: 125,
                                    onTap: () {
                                      widget.nextSection(2);
                                    })
                                : const SizedBox.shrink(),
                            Spacer(),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
