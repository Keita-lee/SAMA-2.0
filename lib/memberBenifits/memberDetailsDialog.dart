import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/admin/memberBenefits/memberBenifitsDialog.dart';
import 'package:sama/components/myutility.dart';

class MemberDetailsDialog extends StatefulWidget {
  String? id;
  String? logo;
  String? userType;
  Function closeDialog;
  MemberDetailsDialog(
      {super.key,
      required this.id,
      required this.logo,
      required this.userType,
      required this.closeDialog});

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
        benefitsImageUrl = data.get('logo').toString();
        print(data.get('logo'));
      });
    }
  }

  BuildContext? dialogContext;

  //Dialog for benifits
  Future openMemberDialog(benifitId) => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: MemberBenifitsDialogState(
                id: benifitId,
                closeDialog: () => Navigator.pop(dialogContext!)));
      });
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
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
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
              /**/ ImageNetwork(
                image: widget.logo!,
                width: MyUtility(context).width / 2.5 - 15,
                height: 350,
                fitWeb: BoxFitWeb.contain,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Color.fromARGB(255, 8, 55, 145),
                //   height: 80,
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
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        companyDescription,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
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
                height: 25,
              ),
              Visibility(
                visible: phoneNumber == "" ? false : true,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'images/phone.svg',
                      width: 35,
                      height: 35,
                      colorFilter: ColorFilter.mode(
                          Color.fromARGB(255, 8, 55, 145), BlendMode.srcIn),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      phoneNumber,
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
              SizedBox(
                height: 25,
              ),
              Visibility(
                visible: email == "" ? false : true,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'images/email.svg',
                      width: 35,
                      height: 35,
                      colorFilter: ColorFilter.mode(
                          Color.fromARGB(255, 8, 55, 145), BlendMode.srcIn),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      email,
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
              SizedBox(
                height: 25,
              ),
              Visibility(
                visible: web == "" ? false : true,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'images/web.svg',
                      width: 35,
                      height: 35,
                      colorFilter: ColorFilter.mode(
                          Color.fromARGB(255, 8, 55, 145), BlendMode.srcIn),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      web,
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
              SizedBox(
                height: 25,
              ),
              Visibility(
                visible: address == "" ? false : true,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'images/address.svg',
                      width: 35,
                      height: 35,
                      colorFilter: ColorFilter.mode(
                          Color.fromARGB(255, 8, 55, 145), BlendMode.srcIn),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      address,
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
              SizedBox(
                height: 25,
              ),
              Visibility(
                visible: facebook == "" ? false : true,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'images/facebook.svg',
                      width: 35,
                      height: 35,
                      colorFilter: ColorFilter.mode(
                          Color.fromARGB(255, 8, 55, 145), BlendMode.srcIn),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      facebook,
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
              SizedBox(
                height: 25,
              ),
              Visibility(
                visible: twitter == "" ? false : true,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'images/twitter3.svg',
                      width: 35,
                      height: 35,
                      colorFilter: ColorFilter.mode(
                          Color.fromARGB(255, 8, 55, 145), BlendMode.srcIn),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      twitter,
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
              SizedBox(
                height: 25,
              ),
              Visibility(
                visible: linkedIn == "" ? false : true,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'images/linkedin_icon_135436.svg',
                      width: 35,
                      height: 35,
                      colorFilter: ColorFilter.mode(
                          Color.fromARGB(255, 8, 55, 145), BlendMode.srcIn),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      linkedIn,
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
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
