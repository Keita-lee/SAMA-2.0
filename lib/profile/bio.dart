import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sama/components/CheckBoxCircle.dart';
import 'package:sama/components/MyDivider.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/profile/Tables/PublishedArticlesTable.dart';
import 'package:sama/profile/Tables/VolunteerWorkTable.dart';
import 'package:sama/profile/Tables/organisationsTable.dart';
import 'package:sama/profile/Tables/workExperience.dart';
import 'package:sama/profile/ui/longTextField.dart';
import 'package:sama/profile/ui/myDatePicker.dart';

import '../components/myutility.dart';

class BoiFormText extends StatelessWidget {
  final String mainFormText;
  const BoiFormText({super.key, required this.mainFormText});

  @override
  Widget build(BuildContext context) {
    return Text(
      mainFormText,
      style: GoogleFonts.openSans(
          fontSize: 18, height: 1, fontWeight: FontWeight.bold),
    );
  }
}

class Bio extends StatefulWidget {
  const Bio({super.key});

  @override
  State<Bio> createState() => _BioState();
}

class _BioState extends State<Bio> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MyUtility(context).width / 1.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Curriculum Vitae/Biography',
            style: GoogleFonts.openSans(
              fontSize: 24,
              color: Color(0xFF174486),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          MyDidiver(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoiFormText(mainFormText: 'Date of Birth:'),
              //Text Controller
              MyDatePicker(textfieldController: TextEditingController(), hintText: 'Date of Birth',),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          MyDidiver(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoiFormText(mainFormText: 'Marital Status:'),
              ProfileDropDownField(
                customSize: 300,
                //Controller here
                textfieldController: TextEditingController(),
                items: ['Married', 'Single'],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          MyDidiver(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoiFormText(mainFormText: 'Occupation/Work Experience:'),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Click the link above to view your Occupation/Work Experience.',
                    style: GoogleFonts.openSans(fontSize: 12),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Text Controller
              MyDatePicker(textfieldController: TextEditingController(), hintText: 'From',),
                  const SizedBox(
                    height: 20,
                  ),
                  //Text Controller
              MyDatePicker(textfieldController: TextEditingController(), hintText: 'To',),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileTextField(
                    customSize: 300,
                    textFieldType: '',
                    //Controller here
                    textfieldController: TextEditingController(),
                    ////
                    hintText: 'Description',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Add More',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF174486),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF174486),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const MyDidiver(),
           const SizedBox(
            height: 30,
          ),
          const BoiFormText(mainFormText: 'Your Occupation/Work Experience'),
          const SizedBox(
            height: 30,
          ),
          const WorkExperience(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Container(
              width: MyUtility(context).width / 1.7,
              decoration: BoxDecoration(
                color: Color.fromRGBO(252, 251, 242, 1),
                border: Border.all(
                  color: Color.fromRGBO(250, 240, 201, 1),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: 'N.B: ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              'Qualifications can only be updated if your SAMA Number under Details is up to date.',
                          style: TextStyle(fontSize: 16))
                    ]),
                  ),
                ),
              ),
            ),
          ),
          const MyDidiver(),
          const SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoiFormText(mainFormText: 'Qualifications:'),
                  const SizedBox(
                    height: 8,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Note: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                'Each qaulification is comma delimited in this format:\n',
                            style: TextStyle(fontSize: 16)),
                        TextSpan(
                            text: 'University - Qaulification - Year',
                            style: TextStyle(fontSize: 16))
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ProfileTextField(
                    customSize: 300,
                    textFieldType: '',
                    //Text Controller
                    textfieldController: TextEditingController(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Institution Name - Qualification Desc -\n',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: 'Qualification Year\n',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: 'Free State University',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const MyDidiver(),
           const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoiFormText(mainFormText: 'Published Articles:'),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Click the link above to view your Occupation/Work Experience.',
                    style: GoogleFonts.openSans(fontSize: 12),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyDatePicker(
                    hintText: 'Select Date',
                    //Text Controller
                    textfieldController: TextEditingController(),
                    //////
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileTextField(
                    hintText: 'Description',
                    customSize: 300,
                    textFieldType: '',
                    //Text Controller
                    textfieldController: TextEditingController(),
                    ///////
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Add More',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF174486),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF174486),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const MyDidiver(),
           const SizedBox(
            height: 30,
          ),
          BoiFormText(mainFormText: 'Your Published articles:'),
          const SizedBox(
            height: 15,
          ),
          PublishedArticlesTable(),
          const SizedBox(
            height: 50,
          ),
          const MyDidiver(),
           const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoiFormText(mainFormText: 'Volunteer Work:'),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Click the link above to view your Volunteer Work information.',
                    style: GoogleFonts.openSans(fontSize: 12),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyDatePicker(
                    hintText: 'Select Date',
                    //Text Controller
                    textfieldController: TextEditingController(),
                    //////
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileTextField(
                    customSize: 300,
                    hintText: 'Description',
                    textFieldType: '',
                    //Text Controller
                    textfieldController: TextEditingController(),
                    ///////
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Add More',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF174486),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF174486),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const MyDidiver(),
           const SizedBox(
            height: 30,
          ),
          BoiFormText(mainFormText: 'Your Volunteer Work:'),
          const SizedBox(
            height: 15,
          ),
          VolunteerWorkTable(),
          const SizedBox(
            height: 30,
          ),
          MyDidiver(),
          Text(
            'We want to understand your views on current operations and membership needs and how your potential contributors might fit with the SAMA\'S vision.\nPlease answer the following questions. (Limit your response to the space provided).',
            style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold, height: 1.3, fontSize: 16),
          ),
          const SizedBox(
            height: 15,
          ),
          MyDidiver(),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Why do you seek a position on the SAMA Gauteng Council ?',
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Hint: ',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: 'Maximum of 500 words allowed.',
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
              LongTextField(
                textFieldWidth: 300,
                //Text Controller
                textEditingController: TextEditingController(),
                lines: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          MyDidiver(),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SAMA leadership motivation- Please outline the specific skills you bring,\nor contributions you hope to make to SAMA:',
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Hint: ',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: 'Maximum of 500 words allowed.',
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
              LongTextField(
                textFieldWidth: 300,
                //Text Controller
                textEditingController: TextEditingController(),
                lines: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const MyDidiver(),
           const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MyUtility(context).width / 2.5,
                child: Text(
                  'Are you currently serving on any other board of directors, committees or leadership positions for another organisations, whether in your private or professional capacity? if so, please list organisation name and your position/role:',
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    height: 1.2,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileTextField(
                    customSize: 300,
                    hintText: 'Organisation name',
                    textFieldType: '',
                    //Text Controller
                    textfieldController: TextEditingController(),
                    ///////
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileTextField(
                    customSize: 300,
                    hintText: 'Position/role',
                    textFieldType: '',
                    //Text Controller
                    textfieldController: TextEditingController(),
                    ///////
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Add More',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF174486),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF174486),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const MyDidiver(),
           const SizedBox(
            height: 30,
          ),
          BoiFormText(mainFormText: 'Your Organisations:'),
          const SizedBox(
            height: 15,
          ),
          OrganisationsTable(),
          const SizedBox(
            height: 30,
          ),
          const MyDidiver(),
          Row(
            children: [
              SizedBox(
                width: MyUtility(context).width / 2.5,
                child: Text(
                  'Have you ever been involved in or have a pending disciplinary action against in your capacity as a SAMA member for allegedly breaching SAMA\'s code of conduct or other governance documents?',
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    height: 1.2,
                  ),
                ),
              ),
              Spacer(),
              CheckBoxCircle(
                header: 'Yes',
              ),
              const SizedBox(
                width: 15,
              ),
              CheckBoxCircle(
                header: 'No',
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const MyDidiver(),
          Row(
            children: [
              SizedBox(
                width: MyUtility(context).width / 2.5,
                child: Text(
                  'Have you ever been involved in or have a pending disciplinary action against you at the HPCSA?',
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    height: 1.2,
                  ),
                ),
              ),
              Spacer(),
              CheckBoxCircle(
                header: 'Yes',
              ),
              const SizedBox(
                width: 15,
              ),
              CheckBoxCircle(
                header: 'No',
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const MyDidiver(),
          Row(
            children: [
              SizedBox(
                width: MyUtility(context).width / 2.5,
                child: Text(
                  'Have you ever received a civil judgement against you?',
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    height: 1.2,
                  ),
                ),
              ),
              Spacer(),
              CheckBoxCircle(
                header: 'Yes',
              ),
              const SizedBox(
                width: 15,
              ),
              CheckBoxCircle(
                header: 'No',
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const MyDidiver(),
          Row(
            children: [
              SizedBox(
                width: MyUtility(context).width / 2.5,
                child: Text(
                  'Have you ever been removed from a position of trust?',
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    height: 1.2,
                  ),
                ),
              ),
              Spacer(),
              CheckBoxCircle(
                header: 'Yes',
              ),
              const SizedBox(
                width: 15,
              ),
              CheckBoxCircle(
                header: 'No',
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const MyDidiver(),
          Row(
            children: [
              SizedBox(
                width: MyUtility(context).width / 2.5,
                child: Text(
                  'Have you ever been charged and/or convicted of crime?',
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    height: 1.2,
                  ),
                ),
              ),
              Spacer(),
              CheckBoxCircle(
                header: 'Yes',
              ),
              const SizedBox(
                width: 15,
              ),
              CheckBoxCircle(
                header: 'No',
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const MyDidiver(),
          const SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MyUtility(context).width * 0.05,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF174486),
              ),
              child: TextButton(
                onPressed: () {
                  //ADD LOGIC HERE
                },
                child: Text(
                  'Update',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
