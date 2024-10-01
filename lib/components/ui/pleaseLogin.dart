import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/login/loginPages.dart';

import '../myutility.dart';
import '../styleButton.dart';

class PleaseLogin extends StatefulWidget {
  final String pleaseLoginText;
  const PleaseLogin({super.key, required this.pleaseLoginText});

  @override
  State<PleaseLogin> createState() => _PleaseLoginState();
}

class _PleaseLoginState extends State<PleaseLogin> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return Container(
      width:
          isMobile ? MyUtility(context).width : MyUtility(context).width / 1.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
              color: Color.fromARGB(255, 212, 210, 210), width: 1.5)),
      child: Padding(
        padding: isMobile ? EdgeInsets.all(5) : EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage('images/lock.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please Login',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 8, 55, 145),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: isMobile
                          ? MyUtility(context).width / 1.5
                          : MyUtility(context).width / 2,
                      child: Text(
                        widget.pleaseLoginText,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 116, 116, 116),
                        ),
                      ),
                    ),
                    Container(
                      height: 15,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 50,
                ),
                Spacer(),
                StyleButton(
                    buttonColor: const Color.fromARGB(255, 87, 87, 87),
                    description: "LOGIN",
                    height: 40,
                    width: 80,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Material(
                                    child: LoginPages(
                                      pageIndex: 0,
                                    ),
                                  )));
                    }),
                SizedBox(
                  width: 15,
                ),
                StyleButton(
                    buttonColor: const Color.fromARGB(255, 87, 87, 87),
                    description: "REGISTER",
                    height: 40,
                    width: 100,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Material(
                                    child: LoginPages(
                                      pageIndex: 9,
                                    ),
                                  )));
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
