import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../myutility.dart';
import '../styleButton.dart';

class PleaseLogin extends StatefulWidget {
  const PleaseLogin({super.key});

  @override
  State<PleaseLogin> createState() => _PleaseLoginState();
}

class _PleaseLoginState extends State<PleaseLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MyUtility(context).width * 0.80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
                color: Color.fromARGB(255, 212, 210, 210), width: 1.5)),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
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
                        width: MyUtility(context).width / 5,
                        height: MyUtility(context).height / 4,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 255, 51, 0), width: 4),
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage('images/lock.png'),
                            fit: BoxFit.scaleDown,
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
                            fontSize: 25,
                            color: Color.fromARGB(255, 8, 55, 145),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Access to this content is restricted. Please log in to view or sign up for membership today.',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 116, 116, 116),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MyUtility(context).width / 2.8,
                          ),
                          StyleButton(
                              buttonColor:
                                  const Color.fromARGB(255, 87, 87, 87),
                              description: "LOGIN",
                              height: 55,
                              width: 125,
                              onTap: () {}),
                          SizedBox(
                            width: 15,
                          ),
                          StyleButton(
                              buttonColor:
                                  const Color.fromARGB(255, 87, 87, 87),
                              description: "REGISTER",
                              height: 55,
                              width: 125,
                              onTap: () {})
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
