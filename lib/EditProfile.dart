import 'package:flutter/material.dart';
import 'package:sama/components/TextField3.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/textfield2.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField2(
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
            textfieldheader3: 'Qualification month'),
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
