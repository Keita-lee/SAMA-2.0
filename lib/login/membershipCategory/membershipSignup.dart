import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/login/membershipCategory/pages/category.dart';
import 'package:sama/login/membershipCategory/pages/paymentMethods.dart';

import 'memberCategory.dart';
import 'pages/applicationType.dart';
import 'ui/memberCategoryTabStyle.dart';

class MembershipSignUp extends StatefulWidget {
  const MembershipSignUp({super.key});

  @override
  State<MembershipSignUp> createState() => _MembershipSignUpState();
}

class _MembershipSignUpState extends State<MembershipSignUp> {
  var pageIndex = 0;
  var sectionIndex = 0;
  var applicationSelected = "";
  var applicationCategory = "";
  var applicationOptions = [];
  var applicationPrice = "";
  //update page index
  changePageIndex(value) {
    setState(() {
      pageIndex = value;
    });
  }

//Go to next part of register
  nextSection(value) {
    setState(() {
      sectionIndex = value;
      pageIndex = value;
    });
  }

  applicationTypeSelected(value) {
    setState(() {
      applicationSelected = value;

      var applicationIndex =
          (paymentTypes).indexWhere((item) => item["applicationType"] == value);

      applicationOptions = paymentTypes[applicationIndex]['paymentOptions'];
    });
  }

  priceSelected(value, categoryName) {
    setState(() {
      applicationCategory = categoryName;
      applicationPrice = value;
    });
  }

  List applicationTypes = [
    'Student',
    'Private Practice',
    'Public Sector',
    'Doctors Employed Outside Public Service',
    'Not Sure'
  ];

  List paymentTypes = [
    {
      "applicationType": "Student",
      "paymentOptions": [
        {
          "title": 'Free Membership',
        }
      ]
    },
    {
      "applicationType": "Private Practice",
      "paymentOptions": [
        {
          "title": '4th Year After Qualification',
          "info":
              "After two years of Internship and \none year of Community service.\n Can be employed by Government,\n working in Private Practice or fall\n under EDOPS. SAMJ included.",
          "month": " R404.43",
          "annual": "R 4 853.16"
        },
        {
          "title": "Private Practice",
          "info":
              "Private Practice or Private\n and Hospital Sessions.\n SAMJ included.",
          "month": "R515.00",
          "annual": "R 6180.00"
        },
        {
          "title": "Part Time MP",
          "info":
              "Working part time in \nPrivate Practice, Government or\n EDOPS. SAMJ included.",
          "month": "R302.00",
          "annual": "R R3624.00"
        },
        {
          "title": "Spouse of Member",
          "info":
              "The spouse of a full SAMA member \nwill pay a reduced member rate. \nThe spouse will not receive a separate \njournal as the SAMJ will be \nposted to the main member only. \nShould a spouse like to receive \nhis/her own copy of the SAMJ,\n a special reduced member rate will\n apply for the 2nd copy. Can\n be employed by Government, working in Private \nPractice or fall under EDOPS \n(Employed Doctors Outside \nPublic Sector).",
          "month": "R320.27",
          "annual": "R 3 843.24"
        },
        {
          "title": "Retired",
          "info":
              "Retired members only. SAMJ not\n included. If a member\n would like to participate \nin the CPD programme, \nthey need to subscribe to the\n SAMJ. A special reduced \nmember rate will apply.",
          "month": "R122.73",
          "annual": "R 1 472.76"
        },
        {
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
          "title": "Intern",
          "info":
              "After completing 6 years of study\n becomes 1st year Intern then \n2nd year Intern. Qualifying\n month can vary. Government\n employed. SAMJ (SA Medical\n Journal) included.",
          "month": "R234.91",
          "annual": "R 2818.92"
        },
        {
          "title": "Community Service",
          "info":
              "One year Community service\n - after two years Internship.\n SAMJ included.",
          "month": "R320.27",
          "annual": "R3843.24"
        },
        {
          "title": "4th Year After Qualification - ",
          "info":
              "After two years of Internship and\n one year of Community service.\n Can be employed by Government,\n working in Private Practice or \nfall under EDOPS. \nSAMJ included.",
          "month": "R404.43",
          "annual": "R4853.16"
        },
        {
          "title": "Registrar",
          "info":
              "Studying for a Speciality.\n Full time in Government\n or Military Hospital\n. SAMJ included.",
          "month": "R404.43",
          "annual": "R4853.16"
        },
        {
          "title": "Full Time MP",
          "info":
              "Full time employed by Government\n or Full time employed \nand doing RWOPS (Remuneration outside\n Public Service) or employed by NHLS \n(National Health Lab Services).\n SAMJ Included.",
          "month": "R0.00",
          "annual": "R 545.87"
        },
        {
          "title": "Part Time MP",
          "info":
              "Working part time in Private\n Practice, Government or \nEDOPS. SAMJ included.",
          "month": "R 320.27",
          "annual": "R6550.44"
        },
        {
          "title": "Spouse of Member",
          "info":
              "The spouse of a full SAMA\n member will pay a reduced member rate.\n The spouse will not receive a separate journal \nas the SAMJ will be posted to the\n main member only. Should a spouse\n like to receive his/her own copy\n of the SAMJ, a special reduced \nmember rate will apply for \nthe 2nd copy. Can be employed\n by Government, working in Private \nPractice or fall under EDOPS\n (Employed Doctors Outside Public Sector).",
          "month": "R 315.60",
          "annual": "R3787.2"
        },
        {
          "title": "Retired",
          "info":
              "Retired members only. SAMJ not included.\n If a member would like to participate\n in the CPD programme, they need to subscribe\n to the SAMJ. A special reduced member \nrate will apply",
          "month": "R1472.76",
          "annual": "R122.73"
        },
        {
          "title": "Life Member",
          "info":
              "Member for 40 years. No SAMJ\n included. Should a Life member\n like to receive a copy the SAMJ, \na special reduced member rate\n will apply. Can still be in Private \nPractice, employed by Government or\n fall under EDOPS or can be retired.",
          "month": "R0.00",
          "annual": "R 0.00"
        },
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width / 1.5,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Membership Sign Up",
              style: GoogleFonts.openSans(
                textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                color: Color.fromRGBO(0, 159, 158, 1),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                MemberCategoryTabStyle(
                  onpress: changePageIndex,
                  index: pageIndex,
                  value: 0,
                  description: 'APPLICATION TYPE',
                ),
                SizedBox(
                  width: 15,
                ),
                MemberCategoryTabStyle(
                  onpress: changePageIndex,
                  index: pageIndex,
                  value: 1,
                  description: 'CATEGORY',
                ),
                SizedBox(
                  width: 15,
                ),
                MemberCategoryTabStyle(
                  onpress: changePageIndex,
                  index: pageIndex,
                  value: 2,
                  description: 'PAYMENT METHODS',
                ),
                SizedBox(
                  width: 15,
                ),
                MemberCategoryTabStyle(
                  onpress: changePageIndex,
                  index: pageIndex,
                  value: 3,
                  description: 'YOUR PROFILE',
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: sectionIndex == 0,
              child: ApplicationType(
                  applicationTypes: applicationTypes,
                  nextSection: nextSection,
                  applicationTypeSelected: applicationTypeSelected),
            ),
            Visibility(
              visible: sectionIndex == 1,
              child: MemberCategoryReg(
                  title: applicationSelected,
                  options: applicationOptions,
                  nextSection: nextSection,
                  priceSelected: priceSelected,
                  applicationPrice: applicationPrice),
            ),
            Visibility(
              visible: sectionIndex == 2,
              child: PaymentMethod(
                  title: applicationSelected,
                  nextSection: nextSection,
                  applicationPrice: applicationPrice),
            ),
          ],
        ),
      ),
    );
  }
}
