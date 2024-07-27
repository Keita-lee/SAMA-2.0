import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/CheckCircle.dart';
import 'package:sama/components/profileTextField.dart';

import '../../../../components/myutility.dart';

class BillingDetailsForm extends StatefulWidget {
  const BillingDetailsForm({super.key});

  @override
  State<BillingDetailsForm> createState() => _BillingDetailsFormState();
}

class _BillingDetailsFormState extends State<BillingDetailsForm> {
//Key
  final _formChekoutKey = GlobalKey<FormState>();

//form controllers
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final companyName = TextEditingController();
  final regionName = TextEditingController();
  final street = TextEditingController();
  final addres = TextEditingController();
  final town = TextEditingController();
  final state = TextEditingController();
  final postal = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
         // width: MyUtility(context).width * 0.45,
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
              key: _formChekoutKey,
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
                          textFieldType: '',
                          textfieldController: firstName),
                      const SizedBox(
                        width: 30,
                      ),
                      ProfileTextField(
                          isRounded: false,
                          isBold: false,
                          description: 'Last Name',
                          customSize: MyUtility(context).width * 0.20,
                          textFieldType: '',
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
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileDropDownField(
                      isBold: false,
                      description: 'Country / Region',
                      customSize: MyUtility(context).width * 0.42,
                      //ADD AVAILABLE REGIONS to list
                      items: [],
                      textfieldController: regionName),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileTextField(
                      isRounded: false,
                      isBold: false,
                      hintText: 'Number and street name',
                      description: 'Street Address',
                      customSize: MyUtility(context).width * 0.42,
                      textFieldType: '',
                      textfieldController: street),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileTextField(
                      isRounded: false,
                      isBold: false,
                      customSize: MyUtility(context).width * 0.42,
                      textFieldType: '',
                      textfieldController: addres),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileTextField(
                      isRounded: false,
                      isBold: false,
                      description: 'Town / City',
                      customSize: MyUtility(context).width * 0.42,
                      textFieldType: '',
                      textfieldController: town),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileDropDownField(
                      isBold: false,
                      description: 'Province / State',
                      customSize: MyUtility(context).width * 0.42,
                      //ADD AVAILABLE Province / State to list
                      items: [],
                      textfieldController: state),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileTextField(
                      isRounded: false,
                      isBold: false,
                      description: 'Postal Code',
                      customSize: MyUtility(context).width * 0.42,
                      textFieldType: '',
                      textfieldController: postal),
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
