import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/login/registerFullProfile.dart';

enum SingingCharacter { eft, debit }

class Payments extends StatefulWidget {
  String payType;
  Payments({super.key, required this.payType});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  continueToRegisterUser() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Material(child: RegisterFullProfile())));
  }

  @override
  Widget build(BuildContext context) {
    SingingCharacter? _character = SingingCharacter.eft;
    return Container(
      width: MyUtility(context).width,
      height: MyUtility(context).height,
      color: const Color.fromARGB(255, 8, 55, 145),
      alignment: Alignment.center, // where to position the child
      child: Container(
        width: MyUtility(context).width / 4,
        height: MyUtility(context).height / 1.3,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                    width: MyUtility(context).width / 5,
                    height: MyUtility(context).height / 5,
                    image: AssetImage('images/sama_logo.png')),
                Text(
                  "Payment",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total: ",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: MyUtility(context).width / 6,
                      child: Text(
                        widget.payType,
                        style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 8, 55, 145)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    color: Color.fromARGB(255, 8, 55, 145),
                    width: MyUtility(context).width / 4.5,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Process secure online Payment now",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'images/lock.svg',
                      color: Color(0xFF174486),
                      width: 35,
                      height: 35,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Secure",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF174486),
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    SvgPicture.asset(
                      'images/visa_logo.svg',
                      color: Color(0xFF174486),
                      width: 35,
                      height: 35,
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    SvgPicture.asset(
                      'images/card.svg',
                      color: Color(0xFF174486),
                      width: 35,
                      height: 35,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /* Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 72, 74, 77),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    )
                    SizedBox(
                      width: 10,
                    ),,*/
                    Text(
                      "Other methods of Payment",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StyleButton(
                        description: "EFT",
                        height: 45,
                        width: 125,
                        onTap: () {}),
                    SizedBox(
                      width: 8,
                    ),
                    StyleButton(
                        description: "Debit Order",
                        height: 45,
                        width: 125,
                        onTap: () {}),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      continueToRegisterUser();
                    },
                    child: Container(
                        color: Color.fromARGB(255, 72, 74, 77),
                        width: 185,
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Text(
                              "Complete Profile",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    /* 
    Container(
      width: MyUtility(context).width,
      height: MyUtility(context).height,
      color: const Color.fromARGB(255, 8, 55, 145),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MyUtility(context).width / 6,
          height: MyUtility(context).height / 2,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Payment",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total ",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Visibility(
                      visible: widget.payType == "Monthly" ? true : false,
                      child: Text(
                        "200 per month:",
                        style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 8, 55, 145)),
                      ),
                    ),
                    Visibility(
                      visible: widget.payType == "Annually" ? true : false,
                      child: Text(
                        "R1000 per Year:",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 8, 55, 145),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    color: Color.fromARGB(255, 8, 55, 145),
                    width: MyUtility(context).width / 4.5,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Process Secure Online Payment",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 72, 74, 77),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Other methods of Payment",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    continueToRegisterUser();
                  },
                  child: Container(
                      color: Color.fromARGB(255, 72, 74, 77),
                      width: 140,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  */
  }
}
