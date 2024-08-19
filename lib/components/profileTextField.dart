import 'package:flutter/material.dart';

class ProfileTextField extends StatefulWidget {
  double customSize;
  double? customHeight;
  String textFieldType;
  final TextEditingController textfieldController;
  String? description;
  String? hintText;
  int? lines;
  bool? isBold;
  bool? isRounded;

  ProfileTextField(
      {super.key,
      this.lines,
      required this.customSize,
      this.customHeight,
      required this.textFieldType,
      required this.textfieldController,
      this.description,
      this.isBold,
      this.isRounded,
      this.hintText});

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
        Visibility(
          visible: widget.description == null ? false : true,
          child: Text(
            widget.description == null ? '' : widget.description!,
            style: TextStyle(
              fontWeight:
                  widget.isBold == null ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
              color: Color(0xFF6A6A6A),
            ),
          ),
        ),
        Container(
          width: widget.customSize,
          height: widget.customHeight != null ? widget.customHeight : 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: widget.isRounded == null
                ? BorderRadius.circular(10)
                : BorderRadius.circular(0),
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: TextFormField(
            maxLines: widget.lines == null ? 1 : widget.lines,
            validator: (value) {
              if (widget.textFieldType == "") {
                return null;
              }
              if (value == null ||
                  value.isEmpty && widget.textFieldType != "") {
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
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Color.fromARGB(255, 199, 199, 199),
                fontSize: 16,
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
  String? description;
  List items;
  final bool? isBold;
  final TextEditingController textfieldController;
  ProfileDropDownField(
      {super.key,
      required this.customSize,
      this.description,
      required this.items,
      required this.textfieldController,
      this.isBold});

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
          Visibility(
            visible: widget.description == null ? false : true,
            child: Text(
              widget.description == null ? '' : widget.description!,
              style: TextStyle(
                fontWeight:
                    widget.isBold == null ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
                color: Color(0xFF6A6A6A),
              ),
            ),
          ),
          DropdownMenu<String>(
            width: widget.customSize,
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
