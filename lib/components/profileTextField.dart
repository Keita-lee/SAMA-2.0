import 'package:flutter/material.dart';

class ProfileTextField extends StatefulWidget {
  double customSize;
  String textFieldType;
  final TextEditingController textfieldController;
  String description;
  ProfileTextField(
      {super.key,
      required this.customSize,
      required this.textFieldType,
      required this.textfieldController,
      required this.description});

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.description,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF6A6A6A),
          ),
        ),
        Container(
          width: widget.customSize,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a value';
              }

              if (num.tryParse(value) == null &&
                  widget.textFieldType == "intType") {
                return 'Please enter number value';
              }
              if ((value == null ||
                      value.isEmpty ||
                      !value.contains('@') ||
                      !value.contains('.')) &&
                  widget.textFieldType == "emailType") {
                return 'Invalid Email';
              }

              return null;
            },
            controller: widget.textfieldController,
            style: TextStyle(
              color: Color.fromARGB(255, 153, 147, 147),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              contentPadding: new EdgeInsets.only(left: 12.0),
              border: InputBorder.none,
              hintText: "",
              hintStyle: TextStyle(
                color: Color.fromARGB(255, 199, 199, 199),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileDropDownField extends StatefulWidget {
  double customSize;
  String description;
  List items;
  final TextEditingController textfieldController;
  ProfileDropDownField(
      {super.key,
      required this.customSize,
      required this.description,
      required this.items,
      required this.textfieldController});

  @override
  State<ProfileDropDownField> createState() => _ProfileDropDownFieldState();
}

class _ProfileDropDownFieldState extends State<ProfileDropDownField> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF6A6A6A),
            ),
          ),
          DropdownMenu<String>(
            width: widget.customSize,
            // height: 50,

            controller: widget.textfieldController,
            requestFocusOnTap: true,
            label: const Text(''),
            onSelected: (value) {
              setState(() {
                widget.textfieldController.text = value!;
              });
            },
            dropdownMenuEntries:
                widget.items.map<DropdownMenuEntry<String>>((value) {
              return DropdownMenuEntry<String>(
                value: value,
                label: value,
              );
            }).toList(),
          )
        ]);
  }
}
