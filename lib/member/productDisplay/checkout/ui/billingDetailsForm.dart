import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/CheckCircle.dart';
import 'package:sama/components/profileTextField.dart';

import '../../../../components/myutility.dart';

class BillingDetailsForm extends StatefulWidget {
  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;

  const BillingDetailsForm(
      {super.key, required this.formKey, required this.emailController});

  @override
  State<BillingDetailsForm> createState() => _BillingDetailsFormState();
}

class _BillingDetailsFormState extends State<BillingDetailsForm> {
  // form controllers
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final companyName = TextEditingController();
  final street = TextEditingController();
  final addres = TextEditingController();
  final town = TextEditingController();
  final state = TextEditingController();
  final postal = TextEditingController();

  final bool isMember =
      FirebaseAuth.instance.currentUser == null ? false : true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(
              color: Color(0xFFD1D1D1),
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: widget.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Billing Details',
                    style: GoogleFonts.openSans(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ProfileTextField(
                          isRounded: false,
                          isBold: false,
                          description: 'First Name',
                          customSize: MyUtility(context).width * 0.20,
                          textFieldType: 'stringType',
                          textfieldController: firstName),
                      const SizedBox(
                        width: 30,
                      ),
                      ProfileTextField(
                          isRounded: false,
                          isBold: false,
                          description: 'Last Name',
                          customSize: MyUtility(context).width * 0.20,
                          textFieldType: 'stringType',
                          textfieldController: lastName)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProfileTextField(
                          isRounded: false,
                          isBold: false,
                          description: 'Company Name (optional)',
                          customSize: MyUtility(context).width * 0.20,
                          textFieldType: '',
                          textfieldController: companyName),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          CheckCircle(
                            name: 'Invoice company',
                            isCircle: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                  /*  const SizedBox(
                    height: 20,
                  ),
                  ProfileTextField(
                      isRounded: false,
                      isBold: false,
                      description: 'Email',
                      customSize: MyUtility(context).width * 0.20,
                      textFieldType: 'stringType',
                      textfieldController: email),*/
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileTextField(
                      isRounded: false,
                      isBold: false,
                      hintText: 'Street Number',
                      description: 'Street Address',
                      customSize: MyUtility(context).width * 0.42,
                      textFieldType: 'stringType',
                      textfieldController: street),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileTextField(
                      isRounded: false,
                      isBold: false,
                      hintText: 'Street Name',
                      customSize: MyUtility(context).width * 0.42,
                      textFieldType: 'stringType',
                      textfieldController: addres),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileTextField(
                      isRounded: false,
                      isBold: false,
                      description: 'Town / City',
                      customSize: MyUtility(context).width * 0.42,
                      textFieldType: 'stringType',
                      textfieldController: town),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileDropDownField(
                      isBold: false,
                      description: 'Province / State',
                      customSize: MyUtility(context).width * 0.42,
                      items: [
                        "Eastern Cape",
                        "Free State",
                        "Gauteng",
                        "KwaZulu-Natal",
                        "Limpopo",
                        "Mpumalanga",
                        "North West",
                        "Northern Cape",
                        "Western Cape[n 2]"
                      ],
                      textfieldController: state),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileTextField(
                      isRounded: false,
                      isBold: false,
                      description: 'Postal Code',
                      customSize: MyUtility(context).width * 0.42,
                      textFieldType: 'intType',
                      textfieldController: postal),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: !isMember,
                    child: ProfileTextField(
                        isRounded: false,
                        isBold: false,
                        description: 'Email Address',
                        customSize: MyUtility(context).width * 0.42,
                        textFieldType: 'emailType',
                        textfieldController: widget.emailController),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
