import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/components/myutility.dart';

class MemberDetailsDialog extends StatefulWidget {
  String? id;
  Function closeDialog;
  MemberDetailsDialog({super.key, required this.id, required this.closeDialog});

  @override
  State<MemberDetailsDialog> createState() => _MemberDetailsDialogState();
}

class _MemberDetailsDialogState extends State<MemberDetailsDialog> {
  //Text editors
  String companyName = "";
  String companyDescription = "";
  String companyBenifits = "";

  String phoneNumber = "";
  String email = "";
  String web = "";
  String address = "";
  String facebook = "";
  String twitter = "";
  String linkedIn = "";
  //var
  String benefitsImageUrl = "";

  getCompanyData() async {
    final data = await FirebaseFirestore.instance
        .collection('memberBenefits')
        .doc(widget.id)
        .get();

    if (data.exists) {
      setState(() {
        companyName = data.get('companyName');
        companyDescription = data.get('companyDescription');
        companyBenifits = data.get('companyBenifits');

        phoneNumber = data.get('phoneNumber');
        email = data.get('email');
        web = data.get('web');
        address = data.get('address');
        facebook = data.get('facebook');
        twitter = data.get('twitter');
        linkedIn = data.get('linkedIn');
        benefitsImageUrl = data.get('logo');
        print(data.get('logo'));
      });
    }
  }

  @override
  void initState() {
    getCompanyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width / 2.5 - 15,
      height: MyUtility(context).height / 1.4,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              ImageNetwork(
                image: benefitsImageUrl,
                width: MyUtility(context).width / 2.5 - 15,
                height: 350,
                fitWeb: BoxFitWeb.cover,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Color.fromARGB(255, 8, 55, 145),
                height: 80,
                width: MyUtility(context).width / 2.5 - 45,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        companyName,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 0,
                        ),
                      ),
                      Text(
                        companyDescription,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We are able to offer SAMA members the following",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                companyBenifits,
                style: TextStyle(
                  color: Color.fromARGB(255, 19, 19, 19),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Contact",
                style: TextStyle(
                  color: Color.fromARGB(255, 8, 55, 145),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "PHONE NUMBER",
                style: TextStyle(
                  color: Color.fromARGB(255, 8, 55, 145),
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "EMAIL",
                style: TextStyle(
                  color: Color.fromARGB(255, 8, 55, 145),
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "WEB",
                style: TextStyle(
                  color: Color.fromARGB(255, 8, 55, 145),
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "ADDRESS",
                style: TextStyle(
                  color: Color.fromARGB(255, 8, 55, 145),
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "FACEBOOK",
                style: TextStyle(
                  color: Color.fromARGB(255, 8, 55, 145),
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "TWITTER HANDLE",
                style: TextStyle(
                  color: Color.fromARGB(255, 8, 55, 145),
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "LINKEDIN",
                style: TextStyle(
                  color: Color.fromARGB(255, 8, 55, 145),
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                  height: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
