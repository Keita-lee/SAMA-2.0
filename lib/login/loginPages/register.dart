import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/components/utility.dart';

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
  Register({super.key, required this.changePage});

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

  final password = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  createClient() async {
    var clientData = {
      "title": title.text,
      "initials": initials.text,
      "firstName": firstName.text,
      "lastName": lastName.text,
      "email": email.text,
      "mobileNo": mobileNo.text,
      "landline": landline.text,
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
      "userType": "user",
      "id": ""
    }; /*   */

    UserCredential result =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text.trim().toLowerCase(),
      password: password.text.trim(),
    );
    User? user = result.user;

    final doc =
        FirebaseFirestore.instance.collection('users').doc(result.user?.uid);
    clientData["id"] = doc.id;

    final json = clientData;
    doc.set(json);
    widget.changePage(0);
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
          Image(
              width: MyUtility(context).width / 6,
              height: MyUtility(context).height / 3.5,
              image: AssetImage('imges/sama_logo.png')),
          Column(
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RegisterTextfieldStyle(
                      description: "Title",
                      hintText: "Title",
                      textfieldController: title,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    RegisterTextfieldStyle(
                      description: "Initials",
                      hintText: "Initials",
                      textfieldController: initials,
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RegisterTextfieldStyle(
                      description: "First Name:",
                      hintText: "First Name",
                      textfieldController: firstName,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    RegisterTextfieldStyle(
                      description: "Last Name:",
                      hintText: "Last Name",
                      textfieldController: lastName,
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RegisterTextfieldStyle(
                      description: "Email",
                      hintText: "Email",
                      textfieldController: email,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    RegisterTextfieldStyle(
                      description: "Mobile Number:",
                      hintText: "Mobile Number",
                      textfieldController: mobileNo,
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RegisterTextfieldStyle(
                      description: "Landline",
                      hintText: "Landline",
                      textfieldController: landline,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    RegisterTextfieldStyle(
                      description: "Gender:",
                      hintText: "gender",
                      textfieldController: gender,
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RegisterTextfieldStyle(
                      description: "Race",
                      hintText: "Race",
                      textfieldController: race,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    RegisterTextfieldStyle(
                      description: "Date of Birth:",
                      hintText: "DOB",
                      textfieldController: dob,
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RegisterTextfieldStyle(
                      description: "Race",
                      hintText: "Race",
                      textfieldController: race,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    RegisterTextfieldStyle(
                      description: "Date of Birth:",
                      hintText: "DOB",
                      textfieldController: dob,
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RegisterTextfieldStyle(
                      description: "ID Number:",
                      hintText: "ID Number",
                      textfieldController: idNumber,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    RegisterTextfieldStyle(
                      description: "Passport Number:",
                      hintText: "Passport Number",
                      textfieldController: passportNumber,
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RegisterTextfieldStyle(
                      description: "HPCSA:",
                      hintText: "HPCSA",
                      textfieldController: hpcsa,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    RegisterTextfieldStyle(
                      description: "Practice Number:",
                      hintText: "Practice Number",
                      textfieldController: practiceNumber,
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RegisterTextfieldStyle(
                      description: "Univercity Qualification:",
                      hintText: "Univercity Qualification",
                      textfieldController: univercityQualification,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    RegisterTextfieldStyle(
                      description: "Qualification Year:",
                      hintText: "Qualification Year",
                      textfieldController: qualificationYear,
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RegisterTextfieldStyle(
                      description: "Qualification Month:",
                      hintText: "Qualification Month",
                      textfieldController: qualificationMonth,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    RegisterTextfieldStyle(
                      description: "Password:",
                      hintText: "Password",
                      textfieldController: password,
                    )
                  ],
                ),
                Row(
                  children: [
                    Spacer(),
                    StyleButton(
                        description: "Register User",
                        height: 55,
                        width: 125,
                        onTap: () {
                          createClient();
                        })
                  ],
                )
              ]),
        ],
      )),
    );
  }
}
