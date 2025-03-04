import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/imageAdd.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleButtonYellow.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/components/utility.dart';
import 'package:sama/components/yesNoDialog.dart';

class MemberBenifitsDialogState extends StatefulWidget {
  String? id;
  Function closeDialog;
  MemberBenifitsDialogState(
      {super.key, required this.id, required this.closeDialog});

  @override
  State<MemberBenifitsDialogState> createState() =>
      _MemberBenifitsDialogStateState();
}

class _MemberBenifitsDialogStateState extends State<MemberBenifitsDialogState> {
  // Text controllers
  final companyName = TextEditingController();
  final companyDescription = TextEditingController();
  final companyBenifits = TextEditingController();

  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final web = TextEditingController();
  final address = TextEditingController();
  final facebook = TextEditingController();
  final twitter = TextEditingController();
  final linkedIn = TextEditingController();
  //var
  String benefitsImageUrl = "";

//Set value for benifits image
  setBenifitsImage(value) {
    setState(() {
      benefitsImageUrl = value;
    });
  }

  createEditBenifit() async {
    var companyBenefitData = {
      "companyName": companyName.text,
      "companyDescription": companyDescription.text,
      "companyBenifits": companyBenifits.text,
      "phoneNumber": phoneNumber.text,
      "email": email.text,
      "web": web.text,
      "address": address.text,
      "facebook": facebook.text,
      "twitter": twitter.text,
      "linkedIn": linkedIn.text,
      "logo": benefitsImageUrl,
      "id": widget.id
    }; /*   */

    if (widget.id == "") {
      final doc = FirebaseFirestore.instance.collection('memberBenefits').doc();
      companyBenefitData["id"] = doc.id;

      final json = companyBenefitData;
      doc.set(json);
    } else {
      FirebaseFirestore.instance
          .collection('memberBenefits')
          .doc(widget.id)
          .update(companyBenefitData);
    }

    widget.closeDialog();
  }

  //If editing call data
  getCompanyData() async {
    final data = await FirebaseFirestore.instance
        .collection('memberBenefits')
        .doc(widget.id)
        .get();

    if (data.exists) {
      setState(() {
        companyName.text = data.get('companyName');
        companyDescription.text = data.get('companyDescription');
        companyBenifits.text = data.get('companyBenifits');

        phoneNumber.text = data.get('phoneNumber');
        email.text = data.get('email');
        web.text = data.get('web');
        address.text = data.get('address');
        facebook.text = data.get('facebook');
        twitter.text = data.get('twitter');
        linkedIn.text = data.get('linkedIn');
        benefitsImageUrl = data.get('logo');
      });
    }
  }

//Remove member from db
  removeMember() {
    FirebaseFirestore.instance
        .collection('memberBenefits')
        .doc(widget.id)
        .delete()
        .whenComplete(() => widget.closeDialog!());
  }

  BuildContext? dialogContext;
  //Dialog for password Validate
  Future removeMemberPopup() => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: YesNoDialog(
          description: "Are you sure you want to remove this item",
          closeDialog: () => Navigator.pop(dialogContext!),
          callFunction: removeMember,
        ));
      });
  @override
  void initState() {
    if (widget.id != "") {
      getCompanyData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 680,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(255, 8, 55, 145)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      widget.closeDialog!();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "X",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ImageAdd(
                customWidth: MyUtility(context).width / 4,
                customHeight: MyUtility(context).height / 3.5,
                description: "Benefits Image",
                networkImageUrl: benefitsImageUrl,
                setUrl: setBenifitsImage),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Row(
                children: [
                  Text(
                    "Company Name:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFieldStyling(
                hintText: 'Add Company Name',
                textfieldController: companyName,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Row(
                children: [
                  Text(
                    "Company Description:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFieldStyling(
                hintText: 'Add Company description',
                textfieldController: companyDescription,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Row(
                children: [
                  Text(
                    "Company Benefits:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                    width: MyUtility(context).width,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(
                          color: const Color.fromARGB(255, 51, 51, 51),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextFormField(
                        minLines: 5,
                        maxLines: 5,
                        controller: companyBenifits,
                        style: TextStyle(
                          color: Color.fromARGB(255, 153, 147, 147),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: ' Add Company Benefits',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 199, 199, 199),
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ))),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Row(
                children: [
                  Text(
                    "Contact:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFieldStyling(
                hintText: 'Company Phone Number',
                textfieldController: phoneNumber,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFieldStyling(
                hintText: 'Company Email',
                textfieldController: email,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFieldStyling(
                hintText: 'Company Web',
                textfieldController: web,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFieldStyling(
                hintText: 'Company Address',
                textfieldController: address,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFieldStyling(
                hintText: 'Company Facebook',
                textfieldController: facebook,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFieldStyling(
                hintText: 'Company Twitter',
                textfieldController: twitter,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFieldStyling(
                hintText: 'Company Linked In',
                textfieldController: linkedIn,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Spacer(),
                  StylrButtonYellow(
                      description: "Remove",
                      height: 55,
                      width: 125,
                      onTap: () {
                        removeMemberPopup();
                      }),
                  SizedBox(
                    width: 8,
                  ),
                  StylrButtonYellow(
                      description: "Save Changes",
                      height: 55,
                      width: 125,
                      onTap: () {
                        createEditBenifit();
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
