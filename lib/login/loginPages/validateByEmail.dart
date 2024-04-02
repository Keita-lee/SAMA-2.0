import 'package:flutter/material.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/components/utility.dart';

class ValidateByEmail extends StatefulWidget {
  Function(int) changePage;
  ValidateByEmail({super.key, required this.changePage});

  @override
  State<ValidateByEmail> createState() => _ValidateByEmailState();
}

class _ValidateByEmailState extends State<ValidateByEmail> {
  // Text controllers
  final otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MyUtility(context).width / 3,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Validate by Email",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "An reset password link has been sent to.",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
              Text(
                "Please add the OTP to continue.",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Wrong email address? Re-enter",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
              SizedBox(
                height: 30,
              ),
              TextFieldStyling(
                hintText: 'Add OTP',
                textfieldController: otp,
              ),
              /* SizedBox(
                height: 15,
              ),
              Text(
                "Your OTP has expired, please request a new OTP",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),*/
              SizedBox(
                height: 15,
              ),
              StyleButton(
                description: "Validate",
                height: 55,
                width: 100,
                onTap: () {
                  
                },
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Need help? CONTACT SAMA",
                style: TextStyle(
                    fontSize: 16, color: const Color.fromARGB(255, 8, 55, 145)),
              ),
            ]));
  }
}
