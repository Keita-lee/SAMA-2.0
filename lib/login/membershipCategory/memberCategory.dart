import 'package:flutter/material.dart';
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
      width: MyUtility(context).width / 4.5,
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
      width: MyUtility(context).width / 4.5,
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
  String? membershipType;

  String? description;
  MemberShipTypeContainer(
      {super.key, required this.membershipType, required this.description});

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
      width: MyUtility(context).width / 4.5,
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

class MemberCategory extends StatefulWidget {
  const MemberCategory({super.key});

  @override
  State<MemberCategory> createState() => _MemberCategoryState();
}

class _MemberCategoryState extends State<MemberCategory> {
  var applicationTypeSelected = 'Student';
  var paymentTypeSelected = 'Monthly';
  var memberShipTypeSelected = 'Student';

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          updateApplicationTypeSelected("Student");
                        },
                        child: ContainerStyle(
                            description: "Student",
                            applicationTypeSelected: applicationTypeSelected),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                          onTap: () {
                            updateApplicationTypeSelected("Private Practice");
                          },
                          child: ContainerStyle(
                              description: "Private Practice",
                              applicationTypeSelected: applicationTypeSelected))
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          updateApplicationTypeSelected("Public Sector");
                        },
                        child: ContainerStyle(
                            description: "Public Sector",
                            applicationTypeSelected: applicationTypeSelected),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                          onTap: () {
                            updateApplicationTypeSelected(
                                "Doctors Employed Outside Public Service");
                          },
                          child: ContainerStyle(
                              description:
                                  "Doctors Employed Outside Public Service",
                              applicationTypeSelected: applicationTypeSelected))
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            updateApplicationTypeSelected("Not Sure");
                          },
                          child: ContainerStyle(
                              description: "Not Sure",
                              applicationTypeSelected: applicationTypeSelected))
                    ],
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
                  if (applicationTypeSelected != "Student")
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
                        GestureDetector(
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
                  if (applicationTypeSelected != "Student")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
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
                        GestureDetector(
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
                  Visibility(
                    visible: paymentTypeSelected == "Monthly" &&
                            applicationTypeSelected == "Student"
                        ? true
                        : false,
                    child: Text(
                      "Membership Monthly Fees",
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    ),
                  ),

                  Visibility(
                    visible: paymentTypeSelected == "Annually" &&
                            applicationTypeSelected == "Student"
                        ? true
                        : false,
                    child: Text(
                      "Annual Fees",
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    ),
                  ),

//Student
                  Visibility(
                    visible: paymentTypeSelected == "Monthly" &&
                            applicationTypeSelected == "Student"
                        ? true
                        : false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            updateMembershipTypeSelected("Student - R0.00");
                          },
                          child: MemberShipTypeContainer(
                              description: "Student - R0.00",
                              membershipType: memberShipTypeSelected),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),

                  //Private Practice
                  Visibility(
                    visible: paymentTypeSelected == "Monthly" &&
                            applicationTypeSelected == "Private Practice"
                        ? true
                        : false,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "4th Year after qualification - R404.30");
                              },
                              child: MemberShipTypeContainer(
                                  description:
                                      "4th Year after qualification - R404.30",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Private Practice - R515.15");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Private Practice - R515.15",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Part Time MP - R302.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Part Time MP - R302.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Spouse Of Member - R320.27");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Spouse Of Member - R320.27",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Retired - R122.73");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Retired - R122.73",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Life Member - R00.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Life Member - R00.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //Public Sector
                  Visibility(
                    visible: paymentTypeSelected == "Monthly" &&
                            applicationTypeSelected == "Public Sector"
                        ? true
                        : false,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Intern - R234.91");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Intern - R234.91",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Community Service - R320.27");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Community Service - R320.27",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "4th Year After Qualification - R404.00");
                              },
                              child: MemberShipTypeContainer(
                                  description:
                                      "4th Year After Qualification - R404.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Registrar - R404.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Registrar - R404.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Full Time MP - R320.27");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Full Time MP - R320.27",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Part Time - R320.27");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Part Time - R320.27",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Spouse of Member - R315.20");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Spouse of Member - R315.20",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Retired - R122.27");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Retired - R122.27",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Life Member - R0.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Life Member - R0.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //Doctors Employed Outside Public Service
                  Visibility(
                    visible: paymentTypeSelected == "Monthly" &&
                            applicationTypeSelected ==
                                "Doctors Employed Outside Public Service"
                        ? true
                        : false,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "4th Year After Qualification - R404.00");
                              },
                              child: MemberShipTypeContainer(
                                  description:
                                      "4th Year After Qualification - R404.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Full Time Other MP - R515.17");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Full Time Other MP - R515.17",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Part Time MP - R302.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Part Time MP - R302.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Other Practitioner - R515.27");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Other Practitioner - R515.27",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Full Time MP - R320.27");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Full Time MP - R320.27",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Part Time - R320.27");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Part Time - R320.27",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Spouse of Member - R315.20");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Spouse of Member - R315.20",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Unattached with Journals - R552.27");
                              },
                              child: MemberShipTypeContainer(
                                  description:
                                      "Unattached with Journals - R552.27",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Unattached - R125.20");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Unattached - R125.20",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Retired - R115.27");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Retired - R115.27",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Life Member - R125.20");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Life Member - R125.20",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
//Anually/////////////////////////////
//Private Practice/////////////////////////////
                  Visibility(
                      visible: paymentTypeSelected == "Annually" &&
                              applicationTypeSelected == "Private Practice"
                          ? true
                          : false,
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "4th Year After Qualification - R 4 853.20");
                              },
                              child: MemberShipTypeContainer(
                                  description:
                                      "4th Year After Qualification - R 4 853.20",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Private Practice - R 6 550.41");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Private Practice - R 6 550.41",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Part Time MP - R3624.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Part Time MP - R3624.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Spouse of Member - R 3 843.28");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Spouse of Member - R 3 843.28",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Retired - R 1 472.79");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Retired - R 1 472.79",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Life Member - R0.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Life Member - R0.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                      ])),

                  //Public Sector/////////////////////////////
                  Visibility(
                      visible: paymentTypeSelected == "Annually" &&
                              applicationTypeSelected == "Public Sector"
                          ? true
                          : false,
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Intern - R2664.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Intern - R2664.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Community Service - R3624.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Community Service - R3624.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "4th Year After Qualification - R4584.00");
                              },
                              child: MemberShipTypeContainer(
                                  description:
                                      "4th Year After Qualification - R4584.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Registrar - R4584.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Registrar - R4584.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Full Time MP - R6180.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Full Time MP - R6180.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Part Time MP - R3624.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Part Time MP - R3624.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Spouse of Member - R3576.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Spouse of Member - R3576.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Retired - R1380.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Retired - R1380.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Life Member - R0.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Life Member - R0.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                      ])),

                  SizedBox(
                    height: 15,
                  ),

                  //Private Practice/////////////////////////////
                  Visibility(
                      visible: paymentTypeSelected == "Annually" &&
                              applicationTypeSelected ==
                                  "Doctors Employed Outside Public Service"
                          ? true
                          : false,
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "4th Year After Qualification - R4584.00");
                              },
                              child: MemberShipTypeContainer(
                                  description:
                                      "4th Year After Qualification - R4584.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Full Time Other MP - R6189.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Full Time Other MP - R6189.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Part Time MP - R3624.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Part Time MP - R3624.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Other Practitioner - R6180.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Other Practitioner - R6180.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Spouse of Member - R3576.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Spouse of Member - R3576.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Unattached (with journals) - R6624.00");
                              },
                              child: MemberShipTypeContainer(
                                  description:
                                      "Unattached (with journals) - R6624.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Unattached - R1500.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Unattached - R1500.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Retired - R1380.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Retired - R1380.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateMembershipTypeSelected(
                                    "Life Member - R0.00");
                              },
                              child: MemberShipTypeContainer(
                                  description: "Life Member - R0.00",
                                  membershipType: memberShipTypeSelected),
                            ),
                          ],
                        ),
                      ])),

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
