import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import 'package:sama/components/passwordStrengthMeter.dart';
import 'package:sama/components/styleButton.dart';

import 'package:sama/components/myutility.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/login/popups/validateDialog.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NonMemberSignUp extends StatefulWidget {
  Function closeDialog;
  NonMemberSignUp({super.key, required this.closeDialog});

  @override
  State<NonMemberSignUp> createState() => _NonMemberSignUpState();
}

class _NonMemberSignUpState extends State<NonMemberSignUp> {
  // Text controllers

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final mobileNo = TextEditingController();
  final landline = TextEditingController();

  final idNumber = TextEditingController();
  final password = TextEditingController();
  final passwordCheck = TextEditingController();
  final passNotifier = ValueNotifier<CustomPassStrength?>(null);

  //var
  String userType = "";
  String userId = "";
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool loadingState = false;
  List cartProducts = [];
  String reference = "";

  Future messageDialog(String message) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: ValidateDialog(
                description: message,
                closeDialog: () => Navigator.pop(context!)));
      });

  //Update user cpd
  updateUserCpd(userId) async {
    var userCpdData = {
      "grade": "Pending",
      "dateCreate": DateTime.now(),
      "cpdAssessments": [],
      "userId": userId,
      "paymentRef": reference,
    };

    final snapShot = await FirebaseFirestore.instance
        .collection('cpdUserData')
        .doc(userId)
        .get();

    if (snapShot.exists) {
    } else {
      await FirebaseFirestore.instance
          .collection('cpdUserData')
          .doc(userId)
          .set(userCpdData);
    }

//check if user exist
  }

//Send payment
  Future<void> sendPayment() async {
    if (!_formKey.currentState!.validate()) return;
    final response = await http.post(
      Uri.parse('https://api.paystack.co/transaction/initialize'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer sk_test_216721a21d245ae3b272fcd9b76eeb7e1076d5b7',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email.text,
        'amount': "${1500 * 100}",
        "currency": "ZAR",
      }),
    );
    if (response.statusCode == 200) {
      final decode =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      setState(() {
        loadingState = true;
        reference = decode['data']['reference'];
        afterPaymentMade();
      });

      launchUrl(Uri.parse(decode['data']['authorization_url']));
    } else {
      print('error ${response.statusCode} ${response.body}');
      throw Exception('Failed .');
    }
  }

  checkPaymentMade() {
    return http.get(
      Uri.parse('https://api.paystack.co/transaction/verify/${reference}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer sk_test_216721a21d245ae3b272fcd9b76eeb7e1076d5b7',
      },
    );
  }

  afterPaymentMade() {
    var timer = Timer.periodic(Duration(seconds: 5), (Timer t) async {
      final response = await checkPaymentMade();

      final decode =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      if (decode['data']['status'] == "success" && loadingState == true) {
        setState(() {
          loadingState = false;
          createProfile();
        });
      }
    });
  }

  createProfile() async {
    if (!_formKey.currentState!.validate()) return;
    if (password.text != passwordCheck.text) {
      return messageDialog("Passwords do not match.");
    }

    try {
      UserCredential userDocRef = await _auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userDocRef.user!.uid)
          .set({
        "id": userDocRef.user!.uid,
        "title": "",
        "initials": '',
        "landline": '',
        "profilePic": '',
        "gender": '',
        "race": '',
        "dob": '',
        "passportNumber": '',
        "practiceNumber": '',
        "univercityQualification": '',
        "univercityName": '',
        "qualificationYear": '',
        "qualificationMonth": '',
        "password": '',
        "userType": "NonMember",
        "membershipAdded": false,
        "profilePicView": '',
        "profileView": '',
        'firstName': firstName.text,
        'lastName': lastName.text,
        'mobileNo': mobileNo.text,
        'email': email.text,
        'samaNo': '',
        'idNumber': '',
        'hpcsaNumber': '',
        'status': 'Active',
        'registrationType': '',
        'loggedIn': false
      });
      await messageDialog(
          'Non member Register success, please login to access cpd');
      await updateUserCpd(userDocRef.user!.uid);
      await _auth.signOut();
      await widget.closeDialog();
    } catch (error) {
      print("Error");

      await messageDialog('This email has already been used');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool showRegisterBorder = false;

    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return Container(
      color: Colors.white,
      width: isMobile ? MyUtility(context).width : MyUtility(context).width / 2,
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
                              widget.closeDialog();
                            },
                            child: Icon(Icons.cancel),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Non Member Sign Up",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          color: Color.fromRGBO(0, 159, 158, 1),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ProfileTextField(
                          customSize: MyUtility(context).width,
                          description: "First Name",
                          textfieldController: firstName,
                          textFieldType: "stringType"),
                      SizedBox(
                        height: 15,
                      ),
                      ProfileTextField(
                          customSize: MyUtility(context).width,
                          description: "Last Name",
                          textfieldController: lastName,
                          textFieldType: "stringType"),
                      SizedBox(
                        height: 15,
                      ),
                      ProfileTextField(
                          customSize: MyUtility(context).width,
                          description: "Email",
                          textfieldController: email,
                          textFieldType: "emailType"),
                      SizedBox(
                        height: 15,
                      ),
                      ProfileTextField(
                          customSize: MyUtility(context).width,
                          description: "Mobile Number",
                          textfieldController: mobileNo,
                          textFieldType: "stringType"),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Create a Password",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                          color: Color.fromRGBO(0, 159, 158, 1),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MyUtility(context).width,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            border: Border.all(
                              color: Color.fromARGB(255, 153, 147, 147),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: TextFormField(
                          obscureText: true,
                          controller: password,
                          style: TextStyle(
                            color: Color.fromARGB(255, 153, 147, 147),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (value) {
                            passNotifier.value =
                                CustomPassStrength.calculate(text: value);
                          },
                          decoration: InputDecoration(
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
                      SizedBox(
                        height: 15,
                      ),
                      PasswordStrengthChecker(
                        configuration: PasswordStrengthCheckerConfiguration(
                          height: 28,
                          borderWidth: 0.5,
                          inactiveBorderColor:
                              const Color.fromARGB(255, 126, 126, 126),
                          externalBorderRadius: BorderRadius.circular(30),
                        ),
                        strength: passNotifier,
                      ),
                      SizedBox(height: 20),
                      ProfileTextField(
                          isPassword: true,
                          isBold: false,
                          description: 'Confirm Password',
                          customSize: MyUtility(context).width,
                          textFieldType: 'IntType',
                          textfieldController: passwordCheck),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: isMobile
                            ? MyUtility(context).width - 25
                            : MyUtility(context).width / 1.63,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                              visible: loadingState,
                              child: Text(
                                'Awaiting Payment ....',
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 159, 158, 1),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                    letterSpacing: 1.1),
                              ),
                            ),
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
                                    sendPayment();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MyUtility(context).height * 0.1,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    child: Image.asset(
                      'images/bannerBackground.jpg',
                      width: MyUtility(context).width,
                      height: MyUtility(context).height * 0.04,
                      fit: BoxFit.cover,
                    ),
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
