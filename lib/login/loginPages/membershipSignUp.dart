import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/login/loginPages.dart';

import '../../components/myutility.dart';
import '../../components/styleButton.dart';
import '../../homePage/PostLoginLandingPage.dart';

class MeshipRegFinished extends StatefulWidget {
  MeshipRegFinished({
    super.key,
  });

  @override
  State<MeshipRegFinished> createState() => _MeshipRegFinishedState();
}

class _MeshipRegFinishedState extends State<MeshipRegFinished> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ), // Straighten the bottom corners
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1.0,
                )),
            width: MyUtility(context).width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Thank you for completing your profile!",
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
                          "Your details have been submitted and are now under review by our Member Department.\nWe will verify your information and activate your account as soon as possible.\n You will receive a confirmation email once your account is fully activated.",
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "We appreciate your patience and are excited to have you fully onboard!",
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        StyleButton(
                          fontSize: 15,
                          description: "CONTINUE",
                          height: 50,
                          buttonColor: Color.fromRGBO(0, 159, 158, 1),
                          width: 130,
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Material(
                                            child: PostLoginLandingPage(
                                          userId: "",
                                          activeIndex: 0,
                                        ))));
                          },
                        ),
                      ],
                    ),
                  ),
                ])),
      );
    } else {
      return Container(
          // color: Color(0xFFF8FAFF),
          width: MyUtility(context).width,
          height: MyUtility(context).height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    // width: MyUtility(context).width / 1.2,
                    //height: MyUtility(context).height / 1.8,

                    child: Padding(
                        padding: isMobile
                            ? EdgeInsets.all(8)
                            : const EdgeInsets.only(top: 35, bottom: 45),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyUtility(context).width * 0.04,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: MyUtility(context).width / 1.8 -
                                            MyUtility(context).width / 15,
                                        height: MyUtility(context).height / 2,
                                        child: Center(
                                          child: Container(
                                            //height: MyUtility(context).height / 1.8,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                ), // Straighten the bottom corners
                                                border: Border.all(
                                                  color: Colors.grey[300]!,
                                                  width: 1.0,
                                                )),
                                            width:
                                                MyUtility(context).width / 1.5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Thank you for completing your profile!",
                                                    style: GoogleFonts.openSans(
                                                      fontSize: 35,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          0, 159, 158, 1),
                                                      letterSpacing: -0.5,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    "Your details have been submitted and are now under review by our Member Department.\nWe will verify your information and activate your account as soon as possible.\n You will receive a confirmation email once your account is fully activated.",
                                                    style: GoogleFonts.openSans(
                                                      fontSize: 18,
                                                      color: Colors.grey[600],
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: -0.5,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    "We appreciate your patience and are excited to have you fully onboard!",
                                                    style: GoogleFonts.openSans(
                                                      fontSize: 18,
                                                      color: Colors.grey[600],
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: -0.5,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  StyleButton(
                                                    fontSize: 14,
                                                    description: "CONTINUE",
                                                    height: 50,
                                                    buttonColor: Color.fromRGBO(
                                                        0, 159, 158, 1),
                                                    width: 130,
                                                    onTap: () {
                                                      FirebaseAuth.instance
                                                          .signOut();
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Material(
                                                                      child:
                                                                          PostLoginLandingPage(
                                                                    userId: "",
                                                                    activeIndex:
                                                                        0,
                                                                  ))));
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))
                                  ])
                            ])))
              ]));
    }
  }
}
