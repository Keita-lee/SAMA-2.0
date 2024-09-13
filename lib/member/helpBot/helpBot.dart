import 'package:flutter/material.dart';
import 'package:sama/components/styleButton.dart';

import '../../admin/products/UI/myProductTextField.dart';
import '../../components/email/sendHelpBotEmail.dart';
import '../../components/myutility.dart';

class HelpBot extends StatefulWidget {
  Function closeDialog;
  HelpBot({super.key, required this.closeDialog});

  @override
  State<HelpBot> createState() => _HelpBotState();
}

class _HelpBotState extends State<HelpBot> {
  //Controllers
  final name = TextEditingController();
  final emailAddress = TextEditingController();
  final message = TextEditingController();
  //var
  var bugType = "";
  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;

    sendEmailFromChatBot() async {
      await sendHelpbotEmail(
          email: 'online@samedical.org',
          emailAddress: emailAddress.text,
          message: message.text,
          bugType: bugType,
          name: name.text);

      widget.closeDialog();
    }

    return Container(
      width: isMobile ? MyUtility(context).width : MyUtility(context).width / 4,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Color(0xFFD1D1D1),
          )),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "How can we help you?",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        widget.closeDialog();
                      },
                      child: Icon(Icons.cancel),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              StyleButton(
                  buttonColor:
                      bugType == "REPORT A BUG" ? Colors.teal : Colors.grey,
                  description: "REPORT A BUG",
                  height: 55,
                  width: isMobile
                      ? MyUtility(context).width
                      : MyUtility(context).width / 4,
                  onTap: () {
                    setState(() {
                      bugType = "REPORT A BUG";
                    });
                  }),
              SizedBox(
                height: 15,
              ),
              StyleButton(
                  buttonColor:
                      bugType == "ACCOUNT QUERY" ? Colors.teal : Colors.grey,
                  description: "ACCOUNT QUERY",
                  height: 55,
                  width: isMobile
                      ? MyUtility(context).width
                      : MyUtility(context).width / 4,
                  onTap: () {
                    setState(() {
                      bugType = "ACCOUNT QUERY";
                    });
                  }),
              SizedBox(
                height: 15,
              ),
              StyleButton(
                  buttonColor: bugType == "GENERAL" ? Colors.teal : Colors.grey,
                  description: "GENERAL",
                  height: 55,
                  width: isMobile
                      ? MyUtility(context).width
                      : MyUtility(context).width / 4,
                  onTap: () {
                    setState(() {
                      bugType = "GENERAL";
                    });
                  }),
              MyProductTextField(
                hintText: 'Name',
                textfieldController: name,
                textFieldWidth: isMobile
                    ? MyUtility(context).width
                    : MyUtility(context).width * 0.60,
                topPadding: 0,
                header: 'Your Name',
              ),
              MyProductTextField(
                hintText: 'Email',
                textfieldController: emailAddress,
                textFieldWidth: isMobile
                    ? MyUtility(context).width
                    : MyUtility(context).width * 0.60,
                topPadding: 0,
                header: 'Email Address',
              ),
              MyProductTextField(
                hintText: 'Message',
                textfieldController: message,
                textFieldWidth: isMobile
                    ? MyUtility(context).width
                    : MyUtility(context).width * 0.60,
                topPadding: 0,
                header: 'Message',
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  StyleButton(
                      buttonColor: Colors.teal,
                      description: "Send",
                      height: 55,
                      width: 125,
                      onTap: () {
                        sendEmailFromChatBot();
                      }),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
