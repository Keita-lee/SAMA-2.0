import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/login/membershipCategory/pages/applicationProfile.dart';
import 'package:sama/login/membershipCategory/pages/category.dart';
import 'package:sama/login/membershipCategory/pages/paymentMethods.dart';

import 'memberCategory.dart';
import 'pages/applicationType.dart';
import 'ui/memberCategoryTabStyle.dart';

class MembershipSignUp extends StatefulWidget {
  int? pageIndex;
  MembershipSignUp({super.key, this.pageIndex});

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
  var paymentType = "";
  var paymentRef = "";
  var prodCatCde = "";
  var paymentDetails = {};
  var debitOrder = {
    "bankAccHolder": "",
    "bankAccNo": "",
    "bankAccType": "",
    "bankBranchCde": "",
    "bankBranchName": "",
    "bankDisclaimer": "",
    "bankName": "",
    "bankPaymAnnual": "",
    "bankPaymMonthly": ""
  };
  bool accepted = false;

  @override
  void initState() {
    setState(() {
      sectionIndex = widget.pageIndex ?? 0;
    });
    super.initState();
  }

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

  priceSelected(value, categoryName, paymentType1, valueprodCatCde) {
    setState(() {
      applicationCategory = categoryName;
      applicationPrice = value;
      paymentType = paymentType1;
      prodCatCde = valueprodCatCde;
    });
  }

  getPaymentDetails(type, categoryType) {
    setState(() {
      paymentDetails = {
        "type": type,
        "ref": paymentRef,
        "categoryType": categoryType,
        "bankPayType": paymentType
      };
    });
  }

  getPaymentRef(value) {
    setState(() {
      paymentRef = value;
    });
  }

  getDebitOrder(value) {
    setState(() {
      debitOrder["bankAccHolder"] = value["bankAccHolder"];
      debitOrder["bankAccNo"] = value["bankAccNo"];
      debitOrder["bankAccType"] = value["bankAccType"];
      debitOrder["bankBranchCde"] = value["bankBranchCde"];
      debitOrder["bankBranchName"] = value["bankBranchName"];
      debitOrder["bankDisclaimer"] = value["bankDisclaimer"];
      debitOrder["bankName"] = value["bankName"];
      debitOrder["bankPaymAnnual"] = value["bankPaymAnnual"];
      debitOrder["bankPaymMonthly"] = value["bankPaymMonthly"];
    });
  }

  getProdCatCde(value) {
    setState(() {
      prodCatCde = value;
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
            widget.pageIndex == null
                ? Row(
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
                  )
                : const SizedBox.shrink(),
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
                applicationPrice: applicationPrice,
                accepted: accepted,
              ),
            ),
            Visibility(
              visible: sectionIndex == 2,
              child: PaymentMethod(
                  title: applicationSelected,
                  nextSection: nextSection,
                  applicationPrice: applicationPrice,
                  applicationCategory: applicationCategory,
                  paymentType: paymentType,
                  getPaymentRef: getPaymentRef,
                  getDebitOrder: getDebitOrder,
                  getPaymentDetails: getPaymentDetails),
            ),
            Visibility(
              visible: sectionIndex == 3,
              child: ApplicationProfile(
                nextSection: nextSection,
                debitOrder: debitOrder,
                paymentType: paymentType,
                prodCatCde: prodCatCde,
                paymentDetails: paymentDetails,
                shouldShowPrevBtn: widget.pageIndex == null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
