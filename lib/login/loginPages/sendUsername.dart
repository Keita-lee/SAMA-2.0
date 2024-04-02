import 'package:flutter/material.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';
import 'package:sama/components/utility.dart';

enum SingingCharacter { email, mobile }

class SendUsername extends StatefulWidget {
  Function(int) changePage;
  SendUsername({super.key, required this.changePage});

  @override
  State<SendUsername> createState() => _SendUsernameState();
}

class _SendUsernameState extends State<SendUsername> {
  SingingCharacter? _character = SingingCharacter.email;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Send Username",
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Thank you, validation successful.",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          Text(
            "Where should we send your username?",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Send OTP to:",
            style: TextStyle(fontSize: 17, color: Colors.black),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Radio<SingingCharacter>(
                activeColor: Color.fromARGB(255, 8, 55, 145),
                value: SingingCharacter.email,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              Text(
                "To my Email Address",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Radio<SingingCharacter>(
                activeColor: Color.fromARGB(255, 8, 55, 145),
                value: SingingCharacter.mobile,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              Text(
                "To my mobile no",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          StyleButton(
            description: "Send",
            height: 55,
            width: 145,
            onTap: () {},
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Need help? CONTACT SAMA",
            style: TextStyle(
                fontSize: 16, color: const Color.fromARGB(255, 8, 55, 145)),
          ),
        ],
      ),
    );
  }
}
