import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/login/payments/payments.dart';

class ContainerStyle extends StatefulWidget {
  String? applicationTypeSelected;

  String? description;
  ContainerStyle(
      {super.key,
      required this.applicationTypeSelected,
      required this.description});

  @override
  State<ContainerStyle> createState() => _ContainerStyleState();
}

class _ContainerStyleState extends State<ContainerStyle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.applicationTypeSelected == widget.description
          ? Color.fromARGB(255, 8, 55, 145)
          : Color.fromARGB(255, 124, 127, 134),
      width: MyUtility(context).width / 3.8,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Text(
              widget.description!,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentContainerStyles extends StatefulWidget {
  String? paymentType;

  String? description;
  PaymentContainerStyles(
      {super.key, required this.paymentType, required this.description});

  @override
  State<PaymentContainerStyles> createState() => _PaymentContainerStylesState();
}

class _PaymentContainerStylesState extends State<PaymentContainerStyles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.paymentType == widget.description
          ? Color.fromARGB(255, 8, 55, 145)
          : Color.fromARGB(255, 124, 127, 134),
      width: MyUtility(context).width / 3.8,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Text(
              widget.description!,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class MemberShipTypeContainer extends StatefulWidget {
  String? info;
  String? membershipType;

  String? description;
  MemberShipTypeContainer(
      {super.key,
      required this.info,
      required this.membershipType,
      required this.description});

  @override
  State<MemberShipTypeContainer> createState() =>
      _MemberShipTypeContainerState();
}

class _MemberShipTypeContainerState extends State<MemberShipTypeContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.membershipType == widget.description
          ? Color.fromARGB(255, 8, 55, 145)
          : Color.fromARGB(255, 124, 127, 134),
      width: MyUtility(context).width / 3.8,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Text(
              widget.description!,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Spacer(),
            Tooltip(
              message: widget.info,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color.fromARGB(255, 59, 59, 59),
              ),
              //  height: 150,
              margin: EdgeInsets.only(right: 50),
              padding: const EdgeInsets.all(8.0),
              preferBelow: true,
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              child: SvgPicture.asset(
                'images/info2.svg',
                width: 35,
                height: 35,
                colorFilter: ColorFilter.mode(
                    Color.fromARGB(255, 255, 255, 255), BlendMode.srcIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MemberCategory extends StatefulWidget {
  const MemberCategory({super.key});

  @override
  State<MemberCategory> createState() => _MemberCategoryState();
}

class _MemberCategoryState extends State<MemberCategory> {
  var applicationTypeSelected = 'Student';
  var paymentTypeSelected = 'Monthly';
  var memberShipTypeSelected = 'Student';
  List applicationTypes = [
    'Student',
    'Private Practice',
    'Public Sector',
    'Doctors Employed Outside Public Service',
    'Not Sure'
  ];
//,{"title":"","info":""}
  List paymentTypes = [
    {
      "applicationType": "Student",
      "paymentType": {"Monthly": [], "Annually": []}
    },
    {
      "applicationType": "Private Practice",
      "paymentType": {
        "Monthly": [
          {
            "title": '4th Year After Qualification - R404.43',
            "info":
                "After two years of Internship and \none year of Community service.\n Can be employed by Government,\n working in Private Practice or fall\n under EDOPS. SAMJ included."
          },
          {
            "title": "Private Practice - R515.00",
            "info":
                "Private Practice or Private\n and Hospital Sessions.\n SAMJ included."
          },
          {
            "title": "Part Time MP - R302.00",
            "info":
                "Working part time in \nPrivate Practice, Government or\n EDOPS. SAMJ included."
          },
          {
            "title": "Spouse of Member - R320.27",
            "info":
                "The spouse of a full SAMA member \nwill pay a reduced member rate. \nThe spouse will not receive a separate \njournal as the SAMJ will be \nposted to the main member only. \nShould a spouse like to receive \nhis/her own copy of the SAMJ,\n a special reduced member rate will\n apply for the 2nd copy. Can\n be employed by Government, working in Private \nPractice or fall under EDOPS \n(Employed Doctors Outside \nPublic Sector)."
          },
          {
            "title": "Retired - R122.73",
            "info":
                "Retired members only. SAMJ not\n included. If a member\n would like to participate \nin the CPD programme, \nthey need to subscribe to the\n SAMJ. A special reduced \nmember rate will apply."
          },
          {
            "title": "Life Member - R0.00",
            "info":
                "Member for 40 years. No \nSAMJ included. Should a\n Life member like to receive\n a copy the SAMJ, a special reduced\n member rate will apply. Can \nstill be in Private Practice,\n employed by Government or fall\n under EDOPS or can be retired."
          },
        ],
        "Annually": [
          {
            "title": '4th Year After Qualification - R 4 853.16',
            "info":
                "After two years of Internship and one year of Community\n service. Can be employed by Government,\n working in Private Practice or\n fall under EDOPS. SAMJ included."
          },
          {
            "title": "Private Practice - R 6180.00",
            "info":
                "Private Practice or\n Private and Hospital \nSessions. SAMJ included."
          },
          {
            "title": "Part Time MP - R3624.00",
            "info":
                "Working part time in Private\n Practice, Government or\n EDOPS. SAMJ included."
          },
          {
            "title": "Spouse of Member - R 3 843.24",
            "info":
                "The spouse of a full SAMA member will\n pay a reduced member rate. The spouse\n will not receive a separate journal\n as the SAMJ will be posted \nto the main member only.\n Should a spouse like to\n receive his/her own \ncopy of the SAMJ, a special reduced \nmember rate will apply for\n the 2nd copy. Can be employed\n by Government, working in Private \nPractice or fall under EDOPS (Employed \nDoctors Outside Public Sector)."
          },
          {
            "title": "Retired - R 1 472.76",
            "info":
                "Retired members only. SAMJ not included.\n If a member would like to participate\n in the CPD programme, they need to subscribe to\n the SAMJ. A special reduced\n member rate will apply."
          },
          {
            "title": "Life Member - R0.00",
            "info":
                "Member for 40 years. No SAMJ included. \nShould a Life member like \nto receive a copy the SAMJ,\n a special reduced member rate will\n apply. Can still be in Private \nPractice, employed by Government \nor fall under EDOPS or can be retired."
          }
        ]
      },
    },
    {
      "applicationType": "Public Sector",
      "paymentType": {
        "Monthly": [
          {
            "title": "Intern - R234.91",
            "info":
                "After completing 6 years of study\n becomes 1st year Intern then \n2nd year Intern. Qualifying\n month can vary. Government\n employed. SAMJ (SA Medical\n Journal) included."
          },
          {
            "title": "Community Service - R320.27",
            "info":
                "One year Community service\n - after two years Internship.\n SAMJ included.",
          },
          {
            "title": "4th Year After Qualification - R404.43",
            "info":
                "After two years of Internship and\n one year of Community service.\n Can be employed by Government,\n working in Private Practice or \nfall under EDOPS. \nSAMJ included."
          },
          {
            "title": "Registrar - R404.43",
            "info":
                "Studying for a Speciality.\n Full time in Government\n or Military Hospital\n. SAMJ included."
          },
          {
            "title": "Full Time MP - R 545.87",
            "info":
                "Full time employed by Government\n or Full time employed \nand doing RWOPS (Remuneration outside\n Public Service) or employed by NHLS \n(National Health Lab Services).\n SAMJ Included."
          },
          {
            "title": "Part Time MP - R 320.27",
            "info":
                "Working part time in Private\n Practice, Government or \nEDOPS. SAMJ included."
          },
          {
            "title": "Spouse of Member - R 315.60",
            "info":
                "The spouse of a full SAMA\n member will pay a reduced member rate.\n The spouse will not receive a separate journal \nas the SAMJ will be posted to the\n main member only. Should a spouse\n like to receive his/her own copy\n of the SAMJ, a special reduced \nmember rate will apply for \nthe 2nd copy. Can be employed\n by Government, working in Private \nPractice or fall under EDOPS\n (Employed Doctors Outside Public Sector)."
          },
          {
            "title": "Retired - R122.73",
            "info":
                "Retired members only. SAMJ not included.\n If a member would like to participate\n in the CPD programme, they need to subscribe\n to the SAMJ. A special reduced member \nrate will apply"
          },
          {
            "title": "Life Member - R0.00",
            "info":
                "Member for 40 years. No SAMJ\n included. Should a Life member\n like to receive a copy the SAMJ, \na special reduced member rate\n will apply. Can still be in Private \nPractice, employed by Government or\n fall under EDOPS or can be retired."
          },
        ],
        "Annually": [
          {
            "title": "Intern - 2818.92",
            "info":
                "After completing 6 years of study\n becomes 1st year Intern then 2nd year Intern. \nQualifying month can vary. Government employed.\n SAMJ (SA Medical Journal) included."
          },
          {
            "title": "Community Service - R3843.24",
            "info":
                "One year Community service - \nafter two years \nInternship. SAMJ include"
          },
          {
            "title": "4th Year After Qualification - R4853.16",
            "info":
                "After two years of Internship\n and one year of Community service. \nCan be employed by Government, \nworking in Private Practice \nor fall under EDOPS. SAMJ included."
          },
          {
            "title": "Registrar - R4853.16",
            "info":
                "Studying for a Speciality. Full time in Government or Military Hospital. SAMJ included."
          },
          {
            "title": "Full Time MP - R6550.44",
            "info":
                "Full time employed by Government or Full time\n employed and doing RWOPS (Remuneration\n outside Public Service) or employed by NHLS \n(National Health Lab \nServices). SAMJ Included."
          },
          {
            "title": "Part Time MP - R3843.24",
            "info":
                "Working part time in \nPrivate Practice, Government or\n EDOPS. SAMJ included."
          },
          {
            "title": "Spouse of Member - R3787.2",
            "info":
                "The spouse of a full SAMA \nmember will pay a reduced member \nrate. The spouse will not receive\n a separate journal as the SAMJ will\n be posted to the main member only.\n Should a spouse like to receive \nhis/her own copy of the SAMJ, \na special reduced member rate \nwill apply for the 2nd copy. Can be employed \nby Government, working in Private Practice \nor fall under EDOPS (Employed \nDoctors Outside Public Sector)."
          },
          {
            "title": "Retired - 1472.76",
            "info":
                "Retired members only. \nSAMJ not included. If a member\n would like to participate in the CPD\n programme, they need to subscribe\n to the SAMJ. A special\n reduced member rate will apply."
          },
          {
            "title": "Life Member - R0.00",
            "info":
                "Member for 40 years.\n No SAMJ included. Should a Life member\n like to receive a copy the SAMJ, \na special reduced member rate will \napply. Can still be in Private Practice,\n employed by Government or fall \nunder EDOPS or can be retired."
          },
        ]
      },
    },
    {
      "applicationType": "Doctors Employed Outside Public Service",
      "paymentType": {
        "Monthly": [
          {
            "title": "4th Year After Qualification - R382.00",
            "info":
                "After two years of Internship and one year of \nCommunity service. Can be employed by Government, \nworking in Private Practice or fall under EDOPS. \nSAMJ included."
          },
          {
            "title": "Full Time Other MP - R515.75",
            "info":
                "EDOPS (Employed Doctors Outside Public\n Sector). Municipality/Research. Regional/Community Health.\n SA Defence Force Permanent. National\n Health Insurance. SAMJ \nincluded. Full time University/Private/Mine\n hospital/NGO/ Contracted to Government \nemployed. SAMJ included."
          },
          {
            "title": "Part Time MP - R302.00",
            "info":
                "Working part time \nin Private Practice, \nGovernment or EDOPS. SAMJ included."
          },
          {
            "title": "Other Practitioner - R515.00",
            "info":
                "Working/ employed in the\n Industry, Commercial, Medical Aid\n or Managed Health Care. \nSAMJ included."
          },
          {
            "title": "Spouse of Member - R298.00",
            "info":
                "The spouse of a full SAMA \nmember will pay a reduced member rate. \nThe spouse will not receive a separate journal\n as the SAMJ will be posted to the main \nmember only. Should a spouse like \nto receive his/her own copy of\n the SAMJ, a special reduced member\n rate will apply for the 2nd copy\n. Can be employed by Government, \nworking in Private Practice or \nfall under EDOPS (Employed Doctors Outside \nPublic Sector)."
          },
          {
            "title": "Unattached (with journals) - R552.00",
            "info": "Overseas membership\n receiving the SAMJ."
          },
          {
            "title": "Unattached - R125.00",
            "info": "Overseas membership\n without receiving the SAMJ."
          },
          {
            "title": "Retired - R115.00",
            "info":
                "Retired members only. SAMJ not\n included. If a member would like \nto participate in the CPD programme,\n they need to subscribe to the SAMJ. A \nspecial reduced member rate\n will apply."
          },
          {
            "title": "Life Member - R0.00",
            "info":
                "Member for 40 years. \nNo SAMJ included. Should a Life\n member like to receive a copy the SAMJ,\n a special reduced member rate will\n apply. Can still be in Private \nPractice, employed by Government or fall under\n EDOPS or can be retired."
          },
        ],
        "Annually": [
          {
            "title": "4th Year After Qualification - R4584.00",
            "info":
                "After two years of Internship and one year of Community service. Can be employed by Government, working in Private Practice or fall under EDOPS. SAMJ included."
          },
          {
            "title": "Full Time Other MP - R6189.00",
            "info":
                "EDOPS (Employed Doctors\n Outside Public Sector).\n Municipality/Research. Regional/Community Health. \nSA Defence Force Permanent. National Health\n Insurance. SAMJ included. Full time \nUniversity/Private/Mine hospital/NGO/ Contracted to\n Government employed. SAMJ included."
          },
          {
            "title": "Part Time MP - R3624.00",
            "info":
                "Working part time in Private \nPractice, Government or EDOPS.\n SAMJ included"
          },
          {
            "title": "Other Practitioner - R6180.00",
            "info":
                "Working/ employed in the Industry,\n Commercial, Medical Aid or\n Managed Health Care. SAMJ included."
          },
          {
            "title": "Spouse of Member - R3576.00",
            "info":
                "The spouse of a full SAMA\n member will pay a reduced \nmember rate. The spouse will\n not receive a separate journal as the\n SAMJ will be posted to the main \nmember only. Should a spouse like to receive \nhis/her own copy of the SAMJ, a special\n reduced member rate will \napply for the 2nd copy. Can be employed by \nGovernment, working in Private Practice or fall under\n EDOPS (Employed Doctors Outside Public Sector)."
          },
          {
            "title": "Unattached (with journals) - R6624.00",
            "info": "Overseas membership \nreceiving the SAMJ."
          },
          {
            "title": "Unattached - R1500.00",
            "info": "Overseas membership \nwithout receiving the SAMJ."
          },
          {
            "title": "Retired - R1380.00",
            "info":
                "Retired members only. SAMJ not included.\n If a member would like to participate in the\n CPD programme, they need to subscribe\n to the SAMJ. A special reduced member \nrate will apply."
          },
          {
            "title": "Life Member - R0.00",
            "info":
                "Member for 40 years. No SAMJ included.\n Should a Life member like to receive \na copy the SAMJ, a special reduced \nmember rate will apply. \nCan still be in Private Practice, \nemployed by Government or fall under\n EDOPS or can be retired."
          },
        ]
      },
    },
  ];

  updateApplicationTypeSelected(value) {
    setState(() {
      applicationTypeSelected = value;
    });
  }

  updatePaymentTypeSelected(value) {
    setState(() {
      paymentTypeSelected = value;
    });
  }

  updateMembershipTypeSelected(value) {
    setState(() {
      memberShipTypeSelected = value;
    });
  }

  continueToPaymentPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Material(
                  child: Payments(
                    payType: memberShipTypeSelected,
                  ),
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width,
      height: MyUtility(context).height,
      color: const Color.fromARGB(255, 8, 55, 145),
      child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            width: MyUtility(context).width / 1.5,
            height: MyUtility(context).height / 1.2,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Row(children: [
              Image(
                  width: MyUtility(context).width / 4,
                  height: MyUtility(context).height / 3.5,
                  image: AssetImage('images/sama_logo.png')),
              SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Membership Fees",
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Application Type",
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                      Text(
                        "  (Required)",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: MyUtility(context).width / 1.5,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        for (var i = 0; i < applicationTypes.length; i++)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                updateApplicationTypeSelected(
                                    applicationTypes[i]);
                              },
                              child: ContainerStyle(
                                  description: applicationTypes[i],
                                  applicationTypeSelected:
                                      applicationTypeSelected),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        applicationTypeSelected,
                        style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 61, 61, 61)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    color: const Color.fromARGB(255, 61, 61, 61),
                    height: 2,
                    width: MyUtility(context).width / 2.5,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (applicationTypeSelected != "Student" &&
                      applicationTypeSelected != "Not Sure")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Payment Period",
                          style: TextStyle(fontSize: 22, color: Colors.black),
                        ),
                        Text(
                          "  (Required)",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  if (applicationTypeSelected == "Student")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            updatePaymentTypeSelected("Free Membership");
                          },
                          child: PaymentContainerStyles(
                              description: "Free Membership",
                              paymentType: paymentTypeSelected),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 12,
                  ),
                  if (applicationTypeSelected != "Student" &&
                      applicationTypeSelected != "Not Sure")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            updatePaymentTypeSelected("Monthly");
                          },
                          child: PaymentContainerStyles(
                              description: "Monthly",
                              paymentType: paymentTypeSelected),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        InkWell(
                          onTap: () {
                            updatePaymentTypeSelected("Annually");
                          },
                          child: PaymentContainerStyles(
                              description: "Annually",
                              paymentType: paymentTypeSelected),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: MyUtility(context).width / 1.5,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        for (var i = 0; i < paymentTypes.length; i++)
                          if (paymentTypes[i]['applicationType'] ==
                                  applicationTypeSelected &&
                              paymentTypeSelected == "Monthly")
                            for (var j = 0;
                                j <
                                    paymentTypes[i]['paymentType']['Monthly']
                                        .length;
                                j++)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    updateMembershipTypeSelected(paymentTypes[i]
                                        ['paymentType']['Monthly'][j]['title']);
                                  },
                                  child: MemberShipTypeContainer(
                                      info: paymentTypes[i]['paymentType']
                                          ['Monthly'][j]['info'],
                                      description: paymentTypes[i]
                                              ['paymentType']['Monthly'][j]
                                          ['title'],
                                      membershipType: memberShipTypeSelected),
                                ),
                              ),
                        for (var i = 0; i < paymentTypes.length; i++)
                          if (paymentTypes[i]['applicationType'] ==
                                  applicationTypeSelected &&
                              paymentTypeSelected == "Annually")
                            for (var j = 0;
                                j <
                                    paymentTypes[i]['paymentType']['Annually']
                                        .length;
                                j++)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    updateMembershipTypeSelected(paymentTypes[i]
                                            ['paymentType']['Annually'][j]
                                        ['title']);
                                  },
                                  child: MemberShipTypeContainer(
                                      info: paymentTypes[i]['paymentType']
                                          ['Annually'][j]['info'],
                                      description: paymentTypes[i]
                                              ['paymentType']['Annually'][j]
                                          ['title'],
                                      membershipType: memberShipTypeSelected),
                                ),
                              ),
                      ],
                    ),
                  ),
                  StyleButton(
                      description: "Continue",
                      height: 55,
                      width: 125,
                      onTap: () {
                        continueToPaymentPage();
                      }),
                  SizedBox(
                    height: 15,
                  ),
                ]),
              ),
            ]),
          )),
    );
  }
}
