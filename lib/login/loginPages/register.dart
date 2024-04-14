import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sama/components/email/sendOtp.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/components/utility.dart';
import 'package:sama/login/popups/validateDialog.dart';

class RegisterTextfieldStyle extends StatefulWidget {
  String hintText;
  String description;
  final TextEditingController textfieldController;

  RegisterTextfieldStyle(
      {super.key,
      required this.hintText,
      required this.description,
      required this.textfieldController});

  @override
  State<RegisterTextfieldStyle> createState() => _RegisterTextfieldStyleState();
}

class _RegisterTextfieldStyleState extends State<RegisterTextfieldStyle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.description,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        Container(
          width: MyUtility(context).width / 4.8,
          height: 45,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              border: Border.all(
                color: const Color.fromARGB(255, 51, 51, 51),
              ),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: TextFormField(
            controller: widget.textfieldController,
            style: TextStyle(
              color: Color.fromARGB(255, 153, 147, 147),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "   ${widget.hintText}",
              hintStyle: TextStyle(
                color: Color.fromARGB(255, 199, 199, 199),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Register extends StatefulWidget {
  Function(int) changePage;
  Function(String) getEmailChangeType;
  Function(String) getEmail;
  Register(
      {super.key,
      required this.changePage,
      required this.getEmailChangeType,
      required this.getEmail});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
  final univercityName = TextEditingController();
  final password = TextEditingController();

  BuildContext? dialogContext;

  //Dialog for product form
  Future openValidateDialog() => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: ValidateDialog(
                description: "Fields are Missing",
                closeDialog: () => Navigator.pop(dialogContext!)));
      });
  createClient(id) async {
    var clientData = {
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
      "userType": "user",
      "membershipAdded": false,
      "id": ""
    }; /*   */

    final doc = FirebaseFirestore.instance.collection('users').doc(id);
    clientData["id"] = id;

    final json = clientData;
    doc.set(json);
  }

  sendEmailVerificationLink() async {
    widget.getEmail(email.text);
    if (email.text == "" || lastName.text == "" || firstName.text == "") {
      openValidateDialog();
      return;
    }

    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: "Cp123456",
      );
    } catch (error) {}

    await createClient(_auth.currentUser!.uid);

    sendOTPToUser();
  }

  sendOTPToUser() async {
    String randomOtp = Random().nextInt(999999).toString().padLeft(6, '0');
    print(randomOtp);
    await sendOtp(otp: randomOtp, email: email.text);
    widget.getEmailChangeType('registerPage');
    widget.changePage(14);
  }

  @override
  void initState() {
    setState(() {
      mobileNo.text = "+27 ";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //     width: MyUtility(context).width / 1.5,
      height: MyUtility(context).height / 2,
      child: SingleChildScrollView(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*  Image(
              width: MyUtility(context).width / 6,
              height: MyUtility(context).height / 3.5,
              image: AssetImage('images/sama_logo.png')),*/
          SizedBox(
            width: MyUtility(context).width / 3,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Register",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RegisterTextfieldStyle(
                        description: "First Name:",
                        hintText: "First Name",
                        textfieldController: firstName,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RegisterTextfieldStyle(
                        description: "Last Name:",
                        hintText: "Last Name",
                        textfieldController: lastName,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RegisterTextfieldStyle(
                        description: "Email",
                        hintText: "Email",
                        textfieldController: email,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        StyleButton(
                            description: "Submit",
                            height: 55,
                            width: 125,
                            onTap: () {
                              sendEmailVerificationLink();
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.changePage(0);
                    },
                    child: Text(
                      "Already a member? Login here.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 8, 55, 145),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ]),
          ),
        ],
      )),
    );
  }
}
