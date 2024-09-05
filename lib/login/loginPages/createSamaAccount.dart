import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/login/loginPages/membershipSignUp.dart';

class CreateSamaAccount extends StatefulWidget {
  final Map userData;
  const CreateSamaAccount({super.key, required this.userData});

  @override
  State<CreateSamaAccount> createState() => _CreateSamaAccountState();
}

class _CreateSamaAccountState extends State<CreateSamaAccount> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cellController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController samaNoController = TextEditingController();
  TextEditingController idNoController = TextEditingController();
  TextEditingController hpcsaController = TextEditingController();
  bool isLoading = false;
  bool showErrorMessage = false;

  @override
  void initState() {
    print(widget.userData);
    setState(() {
      nameController.text = widget.userData['firstName'] ?? '';
      lastNameController.text = widget.userData['lastName'] ?? '';
      cellController.text = widget.userData['cell'] ?? '';
      emailController.text = widget.userData['email'] ?? '';
      samaNoController.text = widget.userData['samaNo'] ?? '';
      idNoController.text = widget.userData['idNo'] ?? '';
      hpcsaController.text = widget.userData['hpcsa'] ?? '';
    });
    super.initState();
  }

  submitUserData() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userDocRef = await _auth.createUserWithEmailAndPassword(
          email: emailController.text, password: 'Cp123456');
      await _firestore.collection('users').add({
        "id": userDocRef.user!.uid,
        "title": '',
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
        "userType": "user",
        "membershipAdded": false,
        "profilePicView": '',
        "profileView": '',
        'firstName': nameController.text,
        'lastName': lastNameController.text,
        'mobileNo': cellController.text,
        'email': emailController.text,
        'samaNo': int.parse(samaNoController.text),
        'idNumber': idNoController.text,
        'hpcsaNumber': hpcsaController.text,
        'status': 'Pending',
        'loggedIn': false
      });
      setState(() {
        isLoading = false;
        showErrorMessage = false;
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Material(child: MeshipRegFinished())));
    } catch (e) {
      print('error adding user: $e');
      setState(() {
        isLoading = false;
        showErrorMessage = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MyUtility(context).width / 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Setup Your Online Profile",
            style: GoogleFonts.openSans(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 159, 158, 1),
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Dear Member,",
            style: GoogleFonts.openSans(
              fontSize: 16,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Welcome to our member portal!",
            style: GoogleFonts.openSans(
              fontSize: 16,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "It looks like you don't have an online profile set up yet. To help us assist you better, please complete the following to create your profile. We're here to support you every step of the way!",
            style: GoogleFonts.openSans(
              fontSize: 16,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Thank you for being with us, and we look forward to helping you get started.",
            style: GoogleFonts.openSans(
              fontSize: 16,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                ProfileTextField(
                    isRounded: false,
                    isBold: false,
                    hintText: 'First Name',
                    description: 'First Name',
                    customSize: MyUtility(context).width * 0.42,
                    textFieldType: 'stringType',
                    textfieldController: nameController),
                const SizedBox(
                  height: 10.0,
                ),
                ProfileTextField(
                    isRounded: false,
                    isBold: false,
                    hintText: 'Last Name',
                    description: 'Last Name',
                    customSize: MyUtility(context).width * 0.42,
                    textFieldType: 'stringType',
                    textfieldController: lastNameController),
                const SizedBox(
                  height: 10.0,
                ),
                ProfileTextField(
                    isRounded: false,
                    isBold: false,
                    hintText: 'Cell Number',
                    description: 'Cell Number',
                    customSize: MyUtility(context).width * 0.42,
                    textFieldType: 'stringType',
                    textfieldController: cellController),
                const SizedBox(
                  height: 10.0,
                ),
                ProfileTextField(
                    isRounded: false,
                    isBold: false,
                    hintText: 'Email Address',
                    description: 'Email Address',
                    customSize: MyUtility(context).width * 0.42,
                    textFieldType: 'emailType',
                    textfieldController: emailController),
                const SizedBox(
                  height: 10.0,
                ),
                ProfileTextField(
                    isRounded: false,
                    isBold: false,
                    hintText: 'SAMA Number',
                    description: 'SAMA Number',
                    customSize: MyUtility(context).width * 0.42,
                    textFieldType: 'stringType',
                    textfieldController: samaNoController),
                const SizedBox(
                  height: 10.0,
                ),
                ProfileTextField(
                    isRounded: false,
                    isBold: false,
                    hintText: 'ID Number',
                    description: 'ID Number',
                    customSize: MyUtility(context).width * 0.42,
                    textFieldType: 'stringType',
                    textfieldController: idNoController),
                const SizedBox(
                  height: 10.0,
                ),
                ProfileTextField(
                    isRounded: false,
                    isBold: false,
                    hintText: 'HSPCSA Number',
                    description: 'HSPCSA Number',
                    customSize: MyUtility(context).width * 0.42,
                    textFieldType: 'stringType',
                    textfieldController: hpcsaController),
                const SizedBox(
                  height: 10.0,
                ),
                StyleButton(
                  waiting: isLoading,
                  description: "SUBMIT",
                  height: 55,
                  width: 100,
                  onTap: submitUserData,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                showErrorMessage
                    ? const Text(
                        'Something went wrong, please try again. If the problem persists, please contact support.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
