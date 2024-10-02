import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/mobile/components/Themes/font_text.dart';

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
  double? fontSize;
  bool? isPassword;
  ProfileTextField(
      {super.key,
      this.lines,
      required this.customSize,
      this.customHeight,
      this.fontSize,
      required this.textFieldType,
      required this.textfieldController,
      this.description,
      this.isBold,
      this.isRounded,
      this.hintText,
      this.isPassword});

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
          child: Text(widget.description == null ? '' : widget.description!,
              style: FontText(context).bodyRegularBlack
              // style: GoogleFonts.openSans(
              //   fontWeight:
              //       widget.isBold == null ? FontWeight.w500 : FontWeight.normal,
              //   fontSize: widget.fontSize == null ? 16 : widget.fontSize,
              //   letterSpacing: -0.5,
              //   color: Color(0xFF6A6A6A),
              // ),
              ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: widget.customSize,
          height: widget.customHeight != null ? widget.customHeight : 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: widget.isRounded == null
                ? BorderRadius.circular(5)
                : BorderRadius.circular(0),
            border: Border.all(
              color: Colors.black, // Changed border color to black
            ),
          ),
          child: Padding(
            padding: widget.customHeight != null
                ? EdgeInsets.only(top: 10.0)
                : EdgeInsets.zero,
            child: TextFormField(
              obscureText: widget.isPassword == null ? false : true,
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
              style: GoogleFonts.openSans(
                color: /*Color.fromARGB(255, 153, 147, 147)*/ Color(0xFF6A6A6A),
                fontSize: widget.fontSize == null ? 16 : widget.fontSize,
                //fontWeight: FontWeight.normal,
                fontWeight: FontWeight.w500,
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
        ),
      ],
    );
  }
}

class ProfileDropDownField extends StatefulWidget {
  double customSize;
  String? description;
  final bool? focusTap;
  List items;
  final bool? enableSearch;
  final bool? isBold;
  final TextEditingController textfieldController;
  final Function? onChanged;
  ProfileDropDownField(
      {super.key,
      required this.customSize,
      this.description,
      required this.items,
      required this.textfieldController,
      this.isBold,
      this.onChanged,
      this.enableSearch,
      this.focusTap});

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
              style: GoogleFonts.openSans(
                fontWeight:
                    widget.isBold == null ? FontWeight.w500 : FontWeight.normal,
                fontSize: 16,
                letterSpacing: -0.5,
                color: Color(0xFF6A6A6A),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          DropdownMenu<String>(
            enableFilter: false,
            enableSearch: widget.enableSearch ?? true,
            width: widget.customSize,
            controller: widget.textfieldController,
            requestFocusOnTap: widget.focusTap ?? true,
            label: const Text(''),
            onSelected: (value) {
              setState(() {
                widget.textfieldController.text = value!;
              });

              if (widget.onChanged != null) {
                widget.onChanged!();
              }
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
