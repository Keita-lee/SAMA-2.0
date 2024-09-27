import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/admin/memberBenefits/memberBenifitsDialog.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:url_launcher/url_launcher.dart';

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
  openUrl(url) {
    final Uri urlParse = Uri.parse(url);

    launchUrl(urlParse);
  }

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

  /*BuildContext? dialogContext;

  //Dialog for benifits
  Future openMemberDialog(benifitId) => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
          child: MemberBenifitsDialogState(
            id: benifitId,
            closeDialog: () => Navigator.pop(dialogContext!),
          ),
        );
      });*/
  @override
  void initState() {
    getCompanyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                StyleButton(
                    description: 'Back',
                    height: 50,
                    width: 60,
                    fontSize: 16,
                    buttonColor: Color.fromRGBO(0, 159, 158, 1),
                    onTap: () => widget.closeDialog()),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MyUtility(context).width,
              height: MyUtility(context).height < 800
                  ? MyUtility(context).height * 0.645 // No fixed height
                  : MyUtility(context).height * 0.685,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color.fromARGB(255, 173, 173, 173),
                  )),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ImageNetwork(
                        image: widget.logo!,
                        width: 100,
                        height: 100,
                        fitWeb: BoxFitWeb.contain,
                      ),
                      Text(
                        companyName,
                        style: TextStyle(
                          color: Color.fromRGBO(0, 159, 158, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        companyDescription,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        companyBenifits,
                        style: TextStyle(
                          color: Color.fromARGB(255, 19, 19, 19),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1,
                        ),
                      ),
                      Visibility(
                        visible: MyUtility(context).width < 600,
                        child: SizedBox(
                          height: 10,
                        ),
                      ),
                      Visibility(
                        visible: phoneNumber == "" ? false : true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Phone:    ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                            Text(
                              phoneNumber,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w200,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: email == "" ? false : true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Email:     ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                final Uri a = Uri.parse('mailto:${email}');

                                launchUrl(a);
                              },
                              child: SelectableText(
                                email,
                                style: TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Color.fromRGBO(0, 159, 158, 1),
                                  color: Color.fromRGBO(0, 159, 158, 1),
                                  fontWeight: FontWeight.w200,
                                  height: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: web == "" ? false : true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Web:       ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                final Uri a = Uri.parse(web);

                                launchUrl(a);
                              },
                              child: Text(
                                web,
                                style: TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Color.fromRGBO(0, 159, 158, 1),
                                  color: Color.fromRGBO(0, 159, 158, 1),
                                  fontWeight: FontWeight.w200,
                                  height: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: address == "" ? false : true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Address: ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                            SizedBox(
                              width: MyUtility(context).width / 2,
                              child: Text(
                                address,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Wrap(
                        children: [
                          Visibility(
                            visible: facebook == "" ? false : true,
                            child: InkWell(
                              onTap: () {
                                openUrl(facebook);
                              },
                              child: SvgPicture.asset(
                                'images/facebook.svg',
                                width: 25,
                                height: 25,
                                colorFilter: ColorFilter.mode(
                                    Color.fromRGBO(0, 159, 158, 1),
                                    BlendMode.srcIn),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Visibility(
                            visible: twitter == "" ? false : true,
                            child: InkWell(
                              onTap: () {
                                openUrl(twitter);
                              },
                              child: SvgPicture.asset(
                                'images/twitter3.svg',
                                width: 25,
                                height: 25,
                                colorFilter: ColorFilter.mode(
                                    Color.fromRGBO(0, 159, 158, 1),
                                    BlendMode.srcIn),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Visibility(
                            visible: linkedIn == "" ? false : true,
                            child: InkWell(
                              onTap: () {
                                openUrl(linkedIn);
                              },
                              child: SvgPicture.asset(
                                'images/linkedin_icon_135436.svg',
                                width: 25,
                                height: 25,
                                colorFilter: ColorFilter.mode(
                                    Color.fromRGBO(0, 159, 158, 1),
                                    BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //const SizedBox(height: 15,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox(
        width: MyUtility(context).width * 0.60,
        child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                StyleButton(
                    description: 'Back',
                    height: 40,
                    width: 60,
                    fontSize: 13,
                    buttonColor: Color.fromRGBO(0, 159, 158, 1),
                    onTap: () => widget.closeDialog()),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: MyUtility(context).width * 0.60,
              //height: MyUtility(context).height / 1.4,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color.fromARGB(255, 173, 173, 173),
                  )),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImageNetwork(
                            image: widget.logo!,
                            width: 100,
                            height: 100,
                            fitWeb: BoxFitWeb.contain,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                companyName,
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 159, 158, 1),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  height: 1,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: MyUtility(context).width * 0.60 - 225,
                                child: Text(
                                  companyDescription,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    height: 1,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: MyUtility(context).width * 0.60 - 225,
                                child: Text(
                                  companyBenifits,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 19, 19, 19),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Visibility(
                                visible: phoneNumber == "" ? false : true,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Phone:    ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        height: 1,
                                      ),
                                    ),
                                    Text(
                                      phoneNumber,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w200,
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: email == "" ? false : true,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email:     ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        height: 1,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        final Uri a =
                                            Uri.parse('mailto:${email}');

                                        launchUrl(a);
                                      },
                                      child: SelectableText(
                                        email,
                                        style: TextStyle(
                                          fontSize: 16,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              Color.fromRGBO(0, 159, 158, 1),
                                          color: Color.fromRGBO(0, 159, 158, 1),
                                          fontWeight: FontWeight.w200,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: web == "" ? false : true,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Web:       ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        height: 1,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        final Uri a = Uri.parse(web);

                                        launchUrl(a);
                                      },
                                      child: Text(
                                        web,
                                        style: TextStyle(
                                          fontSize: 16,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              Color.fromRGBO(0, 159, 158, 1),
                                          color: Color.fromRGBO(0, 159, 158, 1),
                                          fontWeight: FontWeight.w200,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: address == "" ? false : true,
                                child: SizedBox(
                                  width: MyUtility(context).width * 0.60,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Address: ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          height: 1,
                                        ),
                                      ),
                                      Text(
                                        address,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w200,
                                          height: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Wrap(
                                children: [
                                  Visibility(
                                    visible: facebook == "" ? false : true,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            openUrl(facebook);
                                          },
                                          child: SvgPicture.asset(
                                            'images/facebook.svg',
                                            width: 25,
                                            height: 25,
                                            colorFilter: ColorFilter.mode(
                                                Color.fromRGBO(0, 159, 158, 1),
                                                BlendMode.srcIn),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        /*Text(
                                        facebook,
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 159, 158, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w200,
                                          height: 1,
                                        ),
                                      ),*/
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Visibility(
                                    visible: twitter == "" ? false : true,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            openUrl(twitter);
                                          },
                                          child: SvgPicture.asset(
                                            'images/twitter3.svg',
                                            width: 25,
                                            height: 25,
                                            colorFilter: ColorFilter.mode(
                                                Color.fromRGBO(0, 159, 158, 1),
                                                BlendMode.srcIn),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        /*Text(
                                        twitter,
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 159, 158, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w200,
                                          height: 1,
                                        ),
                                      ),*/
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Visibility(
                                    visible: linkedIn == "" ? false : true,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            openUrl(linkedIn);
                                          },
                                          child: SvgPicture.asset(
                                            'images/linkedin_icon_135436.svg',
                                            width: 25,
                                            height: 25,
                                            colorFilter: ColorFilter.mode(
                                                Color.fromRGBO(0, 159, 158, 1),
                                                BlendMode.srcIn),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        /*Text(
                                        linkedIn,
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 159, 158, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w200,
                                          height: 1,
                                        ),
                                      ),*/
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      /**/

                      /* Visibility(
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
                          
                        ],
                      ),
                    ),*/

                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
