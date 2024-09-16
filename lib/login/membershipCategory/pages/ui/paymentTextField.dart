import 'package:flutter/material.dart';
import 'package:sama/components/utility.dart';

class PaymentTextField extends StatefulWidget {
  String hintText;
  final TextEditingController textfieldController;

  PaymentTextField(
      {super.key, required this.hintText, required this.textfieldController});

  @override
  State<PaymentTextField> createState() => _PaymentTextFieldState();
}

class _PaymentTextFieldState extends State<PaymentTextField> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;

    return Center(
      child: Container(
        width: isMobile
            ? MyUtility(context).width - 25
            : MyUtility(context).width / 3,
        height: isMobile ? 55 : 45,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            border: Border.all(
              color: const Color.fromARGB(255, 51, 51, 51),
            ),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: TextFormField(
          controller: widget.textfieldController,
          style: TextStyle(
            color: Color.fromARGB(255, 153, 147, 147),
            fontSize: isMobile ? 18 : 16,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            border: InputBorder.none,
            hintText: " ${widget.hintText}",
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 199, 199, 199),
              fontSize: isMobile ? 22 : 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
