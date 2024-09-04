import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/profile/bio.dart';

import '../../components/MyDivider.dart';
import '../../components/email/registrationUpdate.dart';
import '../../components/myutility.dart';
import '../../components/profileTextField.dart';
import '../../components/yesNoDialog.dart';

List paymentTypes = [
  {
    "applicationType": "Student",
    "paymentOptions": [
      {
        "title": 'Free Membership',
        "info": "",
        "month": " R0.00",
        "annual": "R 0.00"
      }
    ]
  },
  {
    "applicationType": "Private Practice",
    "paymentOptions": [
      {
        "code": "E",
        "title": '4th Year After Qualification',
        "info":
            "After two years of Internship and \none year of Community service.\n Can be employed by Government,\n working in Private Practice or fall\n under EDOPS. SAMJ included.",
        "month": " R404.43",
        "annual": "R 4 853.16"
      },
      {
        "code": "G",
        "title": "Private Practice",
        "info":
            "Private Practice or Private\n and Hospital Sessions.\n SAMJ included.",
        "month": "R515.00",
        "annual": "R 6180.00"
      },
      {
        "code": "P",
        "title": "Part Time MP",
        "info":
            "Working part time in \nPrivate Practice, Government or\n EDOPS. SAMJ included.",
        "month": "R302.00",
        "annual": "R R3624.00"
      },
      {
        "code": "D",
        "title": "Spouse of Member",
        "info":
            "The spouse of a full SAMA member \nwill pay a reduced member rate. \nThe spouse will not receive a separate \njournal as the SAMJ will be \nposted to the main member only. \nShould a spouse like to receive \nhis/her own copy of the SAMJ,\n a special reduced member rate will\n apply for the 2nd copy. Can\n be employed by Government, working in Private \nPractice or fall under EDOPS \n(Employed Doctors Outside \nPublic Sector).",
        "month": "R320.27",
        "annual": "R 3 843.24"
      },
      {
        "code": "C",
        "title": "Retired",
        "info":
            "Retired members only. SAMJ not\n included. If a member\n would like to participate \nin the CPD programme, \nthey need to subscribe to the\n SAMJ. A special reduced \nmember rate will apply.",
        "month": "R122.73",
        "annual": "R 1 472.76"
      },
      {
        "code": "L",
        "title": "Life Member ",
        "info":
            "Member for 40 years. No \nSAMJ included. Should a\n Life member like to receive\n a copy the SAMJ, a special reduced\n member rate will apply. Can \nstill be in Private Practice,\n employed by Government or fall\n under EDOPS or can be retired.",
        "month": "R0.00",
        "annual": "R 0.00"
      },
    ],
  },
  {
    "applicationType": "Public Sector",
    "paymentOptions": [
      {
        "code": "B",
        "title": "Intern",
        "info":
            "After completing 6 years of study\n becomes 1st year Intern then \n2nd year Intern. Qualifying\n month can vary. Government\n employed. SAMJ (SA Medical\n Journal) included.",
        "month": "R234.91",
        "annual": "R 2818.92"
      },
      {
        "code": "W",
        "title": "Community Service",
        "info":
            "One year Community service\n - after two years Internship.\n SAMJ included.",
        "month": "R320.27",
        "annual": "R3843.24"
      },
      {
        "code": "E",
        "title": "4th Year After Qualification - ",
        "info":
            "After two years of Internship and\n one year of Community service.\n Can be employed by Government,\n working in Private Practice or \nfall under EDOPS. \nSAMJ included.",
        "month": "R404.43",
        "annual": "R4853.16"
      },
      {
        "code": "R",
        "title": "Registrar",
        "info":
            "Studying for a Speciality.\n Full time in Government\n or Military Hospital\n. SAMJ included.",
        "month": "R404.43",
        "annual": "R4853.16"
      },
      {
        "code": "S",
        "title": "Full Time MP",
        "info":
            "Full time employed by Government\n or Full time employed \nand doing RWOPS (Remuneration outside\n Public Service) or employed by NHLS \n(National Health Lab Services).\n SAMJ Included.",
        "month": "R0.00",
        "annual": "R 545.87"
      },
      {
        "code": "P",
        "title": "Part Time MP",
        "info":
            "Working part time in Private\n Practice, Government or \nEDOPS. SAMJ included.",
        "month": "R 320.27",
        "annual": "R6550.44"
      },
      {
        "code": "D",
        "title": "Spouse of Member",
        "info":
            "The spouse of a full SAMA\n member will pay a reduced member rate.\n The spouse will not receive a separate journal \nas the SAMJ will be posted to the\n main member only. Should a spouse\n like to receive his/her own copy\n of the SAMJ, a special reduced \nmember rate will apply for \nthe 2nd copy. Can be employed\n by Government, working in Private \nPractice or fall under EDOPS\n (Employed Doctors Outside Public Sector).",
        "month": "R 315.60",
        "annual": "R3787.2"
      },
      {
        "code": "C",
        "title": "Retired",
        "info":
            "Retired members only. SAMJ not included.\n If a member would like to participate\n in the CPD programme, they need to subscribe\n to the SAMJ. A special reduced member \nrate will apply",
        "month": "R1472.76",
        "annual": "R122.73"
      },
      {
        "code": "L",
        "title": "Life Member",
        "info":
            "Member for 40 years. No SAMJ\n included. Should a Life member\n like to receive a copy the SAMJ, \na special reduced member rate\n will apply. Can still be in Private \nPractice, employed by Government or\n fall under EDOPS or can be retired.",
        "month": "R0.00",
        "annual": "R 0.00"
      },
    ],
  },
  {
    "applicationType": "Doctors Employed Outside Public Service",
    "paymentOptions": [
      {
        "code": "E",
        "title": "4th Year After Qualification",
        "info":
            "After two years of Internship and one year of \nCommunity service. Can be employed by Government, \nworking in Private Practice or fall under EDOPS. \nSAMJ included.",
        "month": "R382.00",
        "annual": "R4584.00"
      },
      {
        "code": "S",
        "title": "Full Time Other MP",
        "info":
            "EDOPS (Employed Doctors Outside Public\n Sector). Municipality/Research. Regional/Community Health.\n SA Defence Force Permanent. National\n Health Insurance. SAMJ \nincluded. Full time University/Private/Mine\n hospital/NGO/ Contracted to Government \nemployed. SAMJ included.",
        "month": "R515.75",
        "annual": "R6189.00"
      },
      {
        "code": "P",
        "title": "Part Time MP",
        "info":
            "Working part time \nin Private Practice, \nGovernment or EDOPS. SAMJ included.",
        "month": "R302.00",
        "annual": "R3624.00"
      },
      {
        "code": "O",
        "title": "Other Practitioner",
        "info":
            "Working/ employed in the\n Industry, Commercial, Medical Aid\n or Managed Health Care. \nSAMJ included.",
        "month": "R515.00",
        "annual": "R6180.00"
      },
      {
        "code": "D",
        "title": "Spouse of Member -",
        "info":
            "The spouse of a full SAMA \nmember will pay a reduced member rate. \nThe spouse will not receive a separate journal\n as the SAMJ will be posted to the main \nmember only. Should a spouse like \nto receive his/her own copy of\n the SAMJ, a special reduced member\n rate will apply for the 2nd copy\n. Can be employed by Government, \nworking in Private Practice or \nfall under EDOPS (Employed Doctors Outside \nPublic Sector).",
        "month": "R298.00",
        "annual": "R3576.00"
      },
      {
        "code": "Y",
        "title": "Unattached (with journals)",
        "info": "Overseas membership\n receiving the SAMJ.",
        "month": "R552.00",
        "annual": "R6624.00"
      },
      {
        "code": "X",
        "title": "Unattached",
        "info": "Overseas membership\n without receiving the SAMJ.",
        "month": "R125.00",
        "annual": "R1500.00"
      },
      {
        "code": "C",
        "title": "Retired",
        "info":
            "Retired members only. SAMJ not\n included. If a member would like \nto participate in the CPD programme,\n they need to subscribe to the SAMJ. A \nspecial reduced member rate\n will apply.",
        "month": "R115.00",
        "annual": "R1380.00"
      },
      {
        "code": "L",
        "title": "Life Member - R0.00",
        "info":
            "Member for 40 years. \nNo SAMJ included. Should a Life\n member like to receive a copy the SAMJ,\n a special reduced member rate will\n apply. Can still be in Private \nPractice, employed by Government or fall under\n EDOPS or can be retired.",
        "month": "R0.00",
        "annual": "R 0.00"
      },
    ]
  }
];

class MemberProfile extends StatefulWidget {
  String id;
  Function closeDialog;
  MemberProfile({super.key, required this.id, required this.closeDialog});

  @override
  State<MemberProfile> createState() => _MemberProfileState();
}

class _MemberProfileState extends State<MemberProfile> {
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

  final paymentType = TextEditingController();
  final paymentTypeRef = TextEditingController();

  final hpcsa = TextEditingController();
  final practiceNumber = TextEditingController();

  final univercityName = TextEditingController();
  final univercityQualification = TextEditingController();
  final qualificationYear = TextEditingController();
  final qualificationMonth = TextEditingController();

  final bankAccHolder = TextEditingController();
  final bankAccNo = TextEditingController();
  final bankAccType = TextEditingController();
  final bankBranchCde = TextEditingController();
  final bankBranchName = TextEditingController();
  final bankDisclaimer = TextEditingController();
  final bankName = TextEditingController();

  final samaNumber = TextEditingController();

  final categoryType = TextEditingController();
  final subCategory = TextEditingController();
  final subCategoryTime = TextEditingController();
  final categoryPrice = TextEditingController();

  getUserDetails() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .get();

    if (data.exists) {
      var catIndex = (paymentTypes).indexWhere((item) =>
          item['applicationType'] == data.get('paymentDetails.categoryType'));
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

        hpcsa.text = data.get('hpcsaNumber');
        practiceNumber.text = data.get('practiceNumber');

        univercityQualification.text = data.get('univercityQualification');
        qualificationYear.text = data.get('qualificationYear');
        qualificationMonth.text = data.get('qualificationMonth');
        paymentType.text = data.get('paymentDetails.type');
        paymentTypeRef.text = data.get('paymentDetails.ref');

        bankAccHolder.text = data.get('bankAccHolder');
        bankAccNo.text = data.get('bankAccNo');
        bankAccType.text = data.get('bankAccType');
        bankBranchCde.text = data.get('bankBranchCde');
        bankBranchName.text = data.get('bankBranchName');
        bankDisclaimer.text = data.get('bankDisclaimer');
        bankName.text = data.get('bankName');

        categoryType.text = paymentTypes[catIndex]['applicationType'];

        var catTypeIndex = (paymentTypes[catIndex]['paymentOptions'])
            .indexWhere((item) => item['code'] == data.get('prodCatCde'));

        if (data.get('paymentDetails.bankPayType') == "Annually") {
          categoryPrice.text =
              paymentTypes[catIndex]['paymentOptions'][catTypeIndex]['annual'];
        } else {
          categoryPrice.text =
              paymentTypes[catIndex]['paymentOptions'][catTypeIndex]['month'];
        }

        subCategory.text =
            paymentTypes[catIndex]['paymentOptions'][catTypeIndex]['title'];
        subCategoryTime.text = data.get('paymentDetails.bankPayType');
      });
    }
  }

  sendRegistrationEmail() async {
    await sendRegistrationUpdate(
        email: email.text,
        memberTitle: title.text,
        memberName: firstName.text,
        memberSurname: lastName.text);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .update({"status": "Active"});
  }

  //Dialog for password Validate
  Future activateAccount() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: YesNoDialog(
          description:
              "This will send a automatic email to user for activation details",
          closeDialog: () => Navigator.pop(context!),
          callFunction: sendRegistrationEmail,
        ));
      });

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MyUtility(context).width / 2,
        height: 680,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            widget.closeDialog!();
                          },
                          child: Icon(Icons.cancel),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Member Details',
                  style: GoogleFonts.openSans(
                      fontSize: 24,
                      color: Color(0xFF174486),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                MyDidiver(),
                Row(
                  children: [
                    ProfileTextField(
                        customSize: MyUtility(context).width / 6,
                        description: "Title:",
                        textfieldController: title,
                        textFieldType: "stringType"),
                    Spacer(),
                    ProfileTextField(
                        customSize: MyUtility(context).width / 6,
                        description: "Initials:",
                        textfieldController: initials,
                        textFieldType: "stringType"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    ProfileTextField(
                        customSize: MyUtility(context).width / 6,
                        description: "First Name:",
                        textfieldController: firstName,
                        textFieldType: "stringType"),
                    Spacer(),
                    ProfileTextField(
                        customSize: MyUtility(context).width / 6,
                        description: "Last Name:",
                        textfieldController: lastName,
                        textFieldType: "stringType"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 30,
                ),
                MyDidiver(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ProfileTextField(
                        customSize: MyUtility(context).width / 6,
                        description: "Email",
                        textfieldController: email,
                        textFieldType: "stringType"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    ProfileTextField(
                        customSize: MyUtility(context).width / 6,
                        description: "Mobile No",
                        textfieldController: mobileNo,
                        textFieldType: "stringType"),
                    Spacer(),
                    ProfileTextField(
                        customSize: MyUtility(context).width / 6,
                        description: "Landline",
                        textfieldController: landline,
                        textFieldType: "stringType"),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                MyDidiver(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileTextField(
                        customSize: MyUtility(context).width / 6,
                        description: "Gender:",
                        textfieldController: gender,
                        textFieldType: "stringType"),
                    Spacer(),
                    ProfileTextField(
                        customSize: MyUtility(context).width / 6,
                        description: "Race:",
                        textfieldController: race,
                        textFieldType: "stringType"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(children: [
                  ProfileTextField(
                      customSize: MyUtility(context).width / 6,
                      description: "Date of Birth:",
                      textfieldController: dob,
                      textFieldType: "stringType"),
                  Spacer(),
                ]),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    ProfileTextField(
                        customSize: MyUtility(context).width / 6,
                        description: "ID Number:",
                        textfieldController: idNumber,
                        textFieldType: "stringType"),
                    Spacer(),
                    ProfileTextField(
                        customSize: MyUtility(context).width / 6,
                        description: "PassportNumber:",
                        textfieldController: passportNumber,
                        textFieldType: "stringType"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                MyDidiver(),
                Text(
                  'Member Category',
                  style: GoogleFonts.openSans(
                      fontSize: 24,
                      color: Color(0xFF174486),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileTextField(
                        customSize: MyUtility(context).width / 3,
                        description: "Category Selected:",
                        textfieldController: categoryType,
                        textFieldType: "stringType"),
                    Spacer(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileTextField(
                        customSize: MyUtility(context).width / 6,
                        description: "Title:",
                        textfieldController: subCategory,
                        textFieldType: "stringType"),
                    Spacer(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileTextField(
                        customSize: MyUtility(context).width / 6,
                        description: "Title:",
                        textfieldController: subCategoryTime,
                        textFieldType: "stringType"),
                    Spacer(),
                    ProfileTextField(
                        customSize: MyUtility(context).width / 6,
                        description: "Payment:",
                        textfieldController: categoryPrice,
                        textFieldType: "stringType"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                MyDidiver(),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Payment Details',
                  style: GoogleFonts.openSans(
                      fontSize: 24,
                      color: Color(0xFF174486),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                MyDidiver(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileTextField(
                        customSize: MyUtility(context).width / 6,
                        description: "Payment Type:",
                        textfieldController: paymentType,
                        textFieldType: "stringType"),
                    Spacer(),
                    Visibility(
                      visible: paymentType.text == "PAY ONLINE",
                      child: ProfileTextField(
                          customSize: MyUtility(context).width / 6,
                          description: "Reference:",
                          textfieldController: paymentTypeRef,
                          textFieldType: "stringType"),
                    ),
                  ],
                ),
                Visibility(
                    visible: paymentType.text == "DEBIT ORDER",
                    child: Column(
                      children: [
                        ProfileTextField(
                            customSize: MyUtility(context).width / 6,
                            description: "Bank Account Holder:",
                            textfieldController: bankAccHolder,
                            textFieldType: "stringType"),
                        SizedBox(
                          height: 10,
                        ),
                        ProfileTextField(
                            customSize: MyUtility(context).width / 6,
                            description: "Bank Name:",
                            textfieldController: bankName,
                            textFieldType: "stringType"),
                        SizedBox(
                          height: 10,
                        ),
                        ProfileTextField(
                            customSize: MyUtility(context).width / 6,
                            description: "Bank Branch Name:",
                            textfieldController: bankBranchName,
                            textFieldType: "stringType"),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            ProfileTextField(
                                customSize: MyUtility(context).width / 6,
                                description: "Bank Branch Code:",
                                textfieldController: bankBranchCde,
                                textFieldType: "stringType"),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            ProfileTextField(
                                customSize: MyUtility(context).width / 6,
                                description: "Bank Account Type:",
                                textfieldController: bankAccType,
                                textFieldType: "stringType"),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            ProfileTextField(
                                customSize: MyUtility(context).width / 6,
                                description: "Bank Account Number:",
                                textfieldController: bankAccNo,
                                textFieldType: "stringType"),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            ProfileTextField(
                                customSize: MyUtility(context).width / 6,
                                description: "Bank Disclaimer:",
                                textfieldController: bankDisclaimer,
                                textFieldType: "stringType"),
                          ],
                        ),
                      ],
                    )),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    StyleButton(
                        description: " Activate Account",
                        height: 55,
                        width: 125,
                        onTap: () {
                          activateAccount();
                        })
                  ],
                )
              ]),
        )));
  }
}
