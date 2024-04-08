import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sama/Login/loginPages.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/login/registerFullProfile.dart';

class RegisterFinished extends StatefulWidget {
  RegisterFinished({
    super.key,
  });

  @override
  State<RegisterFinished> createState() => _RegisterFinishedState();
}

class _RegisterFinishedState extends State<RegisterFinished> {
  backToLogin() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Material(child: LoginPages())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width,
      height: MyUtility(context).height,
      color: const Color.fromARGB(255, 8, 55, 145),
      alignment: Alignment.center, // where to position the child
      child: Container(
        width: MyUtility(context).width / 4,
        height: MyUtility(context).height / 1.8,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                    width: MyUtility(context).width / 4,
                    height: MyUtility(context).height / 4,
                    image: AssetImage('images/sama_logo.png')),
                Text(
                  "Thank you for Registering with SAMA ",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "your membership is pending for approval",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 12,
                ),
                /* StyleButton(
                    description: "Back to Login",
                    height: 55,
                    width: 175,
                    onTap: () {
                      backToLogin();
                    }),*/
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
