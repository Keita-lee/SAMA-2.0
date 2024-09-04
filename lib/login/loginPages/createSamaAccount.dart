import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';

class CreateSamaAccount extends StatefulWidget {
  final Map userData;
  const CreateSamaAccount({super.key, required this.userData});

  @override
  State<CreateSamaAccount> createState() => _CreateSamaAccountState();
}

class _CreateSamaAccountState extends State<CreateSamaAccount> {
  final _firestore = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cellController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController samaNoController = TextEditingController();
  TextEditingController idNoController = TextEditingController();
  TextEditingController hpcsaController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    print(widget.userData);
    setState(() {
      nameController.text = widget.userData['first_name'] ?? '';
      lastNameController.text = widget.userData['lastName'] ?? '';
      cellController.text = widget.userData['cell'] ?? '';
      emailController.text = widget.userData['email'] ?? '';
      samaNoController.text = widget.userData['samaNo'] ?? '';
      idNoController.text = widget.userData['idNo'] ?? '';
      hpcsaController.text = widget.userData['hpcsa'] ?? '';
    });
    super.initState();
  }

  submitUserData() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _firestore.collection('users').add({
        'firstName': nameController.text,
        'lastName': lastNameController.text,
        'mobileNo': cellController.text,
        'email': emailController.text,
        'samaNo': int.parse(samaNoController.text),
        'idNumber': idNoController.text,
        'hpcsaNumber': hpcsaController.text,
      });
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MyUtility(context).width / 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "SAMA Member Registration",
            style: GoogleFonts.openSans(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 159, 158, 1),
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Dear Member,",
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Welcome to our member portal!",
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "It looks like you don't have an online profile set up yet. To help us assist you better, please complete the following to create your profile. We're here to support you every step of the way!",
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Thank you for being with us, and we look forward to helping you get started.",
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: MyUtility(context).width * 0.3,
            child: TextFieldStyling(
              obscure: true,
              hintText: 'Surname',
              textfieldController: lastNameController,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: MyUtility(context).width * 0.3,
            child: TextFieldStyling(
              obscure: true,
              hintText: 'CellNo',
              textfieldController: nameController,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: MyUtility(context).width * 0.3,
            child: TextFieldStyling(
              obscure: true,
              hintText: 'Email Address',
              textfieldController: nameController,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: MyUtility(context).width * 0.3,
            child: TextFieldStyling(
              obscure: true,
              hintText: 'SAMA Number',
              textfieldController: nameController,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: MyUtility(context).width * 0.3,
            child: TextFieldStyling(
              obscure: true,
              hintText: 'ID Number',
              textfieldController: nameController,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: MyUtility(context).width * 0.3,
            child: TextFieldStyling(
              obscure: true,
              hintText: 'HPCSA Number',
              textfieldController: nameController,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          StyleButton(
            waiting: isLoading,
            description: "SUBMIT",
            height: 55,
            width: 100,
            onTap: submitUserData,
          ),
        ],
      ),
    );
  }
}
