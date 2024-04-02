import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/TextField3.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/textfield2.dart';
import 'package:sama/components/userState.dart';

class ProfileTextField extends StatefulWidget {
  double customSize;
  final TextEditingController textfieldController;
  String description;
  ProfileTextField(
      {super.key,
      required this.customSize,
      required this.textfieldController,
      required this.description});

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.description,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF6A6A6A),
          ),
        ),
        Container(
          width: widget.customSize,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: TextFormField(
            controller: widget.textfieldController,
            style: TextStyle(
              color: Color.fromARGB(255, 153, 147, 147),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
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
      ],
    );
  }
}

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
      });
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
        SizedBox(
          height: MyUtility(context).height * 0.015,
        ),
        Row(
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

        /*    TextField2(
          textfieldtitle: 'Title',
          textfieldtitle2: 'Initials',
        ),

        SizedBox(
          height: MyUtility(context).height * 0.015,
        ),
        TextField2(
          textfieldtitle: 'First Name',
          textfieldtitle2: 'Last Name',
        ),
        SizedBox(
          height: MyUtility(context).height * 0.015,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF6A6A6A),
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: MyUtility(context).width * 0.615,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MyUtility(context).height * 0.015,
        ),
        TextField2(
          textfieldtitle: 'Mobile No',
          textfieldtitle2: 'Landline No',
        ),
        SizedBox(
          height: MyUtility(context).height * 0.015,
        ),
        TextField3(
            textfieldheader1: 'Gender',
            textfieldheader2: 'Race',
            textfieldheader3: 'Date of birth'),
        SizedBox(
          height: MyUtility(context).height * 0.015,
        ),
        TextField2(
          textfieldtitle: 'ID number',
          textfieldtitle2: 'Passport number',
        ),
        SizedBox(
          height: MyUtility(context).height * 0.015,
        ),
        TextField2(
          textfieldtitle: 'HPCSA number',
          textfieldtitle2: 'Practice number',
        ),
        SizedBox(
          height: MyUtility(context).height * 0.015,
        ),
        TextField3(
            textfieldheader1: 'University Qualification',
            textfieldheader2: 'Qualification year',
            textfieldheader3: 'Qualification month'),*/
        SizedBox(
          height: MyUtility(context).height * 0.015,
        ),
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
                onPressed: () {},
                child: Text(
                  'Save',
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
        SizedBox(
          height: MyUtility(context).height * 0.1,
        )
      ],
    );
  }
}
