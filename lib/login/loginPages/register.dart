import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/email/sendOtp.dart';
import 'package:sama/components/profileTextField.dart';
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
  //var

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
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: TextFormField(
              controller: widget.textfieldController,
              style: TextStyle(
                color: Color.fromARGB(255, 153, 147, 147),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "${widget.hintText}",
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 199, 199, 199),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
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

  bool showAlreadyAMemberBorder = false;

  bool _isLoading = false;
  var loadingError = "";

  final FocusNode _focusNode = FocusNode();

  //Dialog for product form
  Future openValidateDialog(String message) => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: ValidateDialog(
                description: message,
                closeDialog: () => Navigator.pop(dialogContext!)));
      });
  createClient(id) async {
    var clientData = {
      "title": title.text,
      "initials": initials.text,
      "firstName": firstName.text,
      "lastName": lastName.text,
      "email": (email.text).toLowerCase(),
      "mobileNo": mobileNo.text,
      "landline": landline.text,
      "profilePic": "",
      "gender": gender.text,
      "race": race.text,
      "dob": dob.text,
      "idNumber": idNumber.text,
      "passportNumber": passportNumber.text,
      "hpcsaNumber": hpcsa.text,
      "practiceNumber": practiceNumber.text,
      "univercityQualification": univercityQualification.text,
      "univercityName": univercityName.text,
      "qualificationYear": qualificationYear.text,
      "qualificationMonth": qualificationMonth.text,
      "password": password.text,
      "userType": "user",
      "membershipAdded": false,
      "id": "",
      "profilePicView": "",
      "profileView": ""
    }; /*   */

    final doc = FirebaseFirestore.instance.collection('users').doc(id);
    clientData["id"] = id;

    final json = clientData;
    doc.set(json);
  }

  sendEmailVerificationLink() async {
    widget.getEmail(email.text);
    if (email.text == "" || lastName.text == "" || firstName.text == "") {
      openValidateDialog('Fields are missing');
      return;
    }

    setState(() {
      _isLoading = true;
      FirebaseAuth.instance.signOut();
    });

    // Query Firestore to check if the email already exists
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email.text.toLowerCase())
        .get();

    // Check if any document exists with the given email
    if (querySnapshot.docs.isNotEmpty) {
      // Email already exists
      if (!mounted) return;
      openValidateDialog('This email has already been used');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.text.toLowerCase(),
        password: "Cp123456",
      );
    } catch (error) {
      setState(() {
        openValidateDialog('This email has already been used');
        _isLoading = false;
      });
    }

    await createClient(_auth.currentUser!.uid);

    widget.changePage(10);
//TODO re add
    //  sendOTPToUser();
    //widget.changePage(14);

    setState(() {
      _isLoading = false;
    });
  }

  sendOTPToUser() async {
    String randomOtp = Random().nextInt(999999).toString().padLeft(6, '0');
    print(randomOtp);
    try {
      await sendOtp(otp: randomOtp, email: email.text);
      widget.getEmailChangeType('registerPage');
      widget.changePage(14);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send OTP')),
      );
    }
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
        width: MyUtility(context).width / 1.5,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Already have a profile?",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 16,
                      ),
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      widget.changePage(0);
                    },
                    child: Text(
                      "Click to login",
                      style: GoogleFonts.openSans(
                        decorationThickness: 2,
                        height: 1.1,
                        decoration: TextDecoration.underline,
                        decorationColor: Color.fromRGBO(0, 159, 158, 1),
                        textStyle: TextStyle(
                          fontSize: 16,
                        ),
                        color: Color.fromRGBO(0, 159, 158, 1),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ProfileTextField(
                        isBold: false,
                        description: 'First name',
                        textfieldController: firstName,
                        customSize: MyUtility(context).width / 5,
                        textFieldType: '',
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      ProfileTextField(
                        isBold: false,
                        description: 'Surname',
                        textfieldController: lastName,
                        customSize: MyUtility(context).width / 5,
                        textFieldType: '',
                      ),
                    ],
                  ),

                  /* RegisterTextfieldStyle(
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
                  ),*/
                  SizedBox(
                    height: 15,
                  ),
                  ProfileTextField(
                    isBold: false,
                    description: 'Email address',
                    textfieldController: email,
                    customSize: MyUtility(context).width / 2.45,
                    textFieldType: '',
                  ),
                  /*  RegisterTextfieldStyle(
                    description: "Email",
                    hintText: "Email",
                    textfieldController: email,
                  ),*/
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  children: [
                    KeyboardListener(
                      focusNode: _focusNode,
                      autofocus: true,
                      onKeyEvent: (KeyEvent event) {
                        if (HardwareKeyboard.instance
                            .isLogicalKeyPressed(LogicalKeyboardKey.enter)) {
                          sendEmailVerificationLink();
                        }
                      },
                      child: StyleButton(
                          buttonColor: Color.fromRGBO(24, 69, 126, 1),
                          waiting: _isLoading,
                          description: "Next",
                          height: 55,
                          width: 125,
                          onTap: () {
                            sendEmailVerificationLink();
                          }),
                    ),
                  ],
                ),
              ),
            ]));
  }
}
