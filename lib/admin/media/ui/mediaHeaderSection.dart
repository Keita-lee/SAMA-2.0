import 'package:flutter/material.dart';
import 'package:sama/admin/media/mediaForm/mediaForm.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/components/styleButton.dart';

class MediaHeaderSection extends StatefulWidget {
  TextEditingController controller;
  VoidCallback openMediaForm;
  MediaHeaderSection(
      {super.key, required this.controller, required this.openMediaForm});

  @override
  State<MediaHeaderSection> createState() => _MediaHeaderSectionState();
}

class _MediaHeaderSectionState extends State<MediaHeaderSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MyUtility(context).width / 1.8,
          ),
          ProfileDropDownField(
            description: "Select a Category",
            items: [],
            customSize: 250,
            textfieldController: widget.controller,
          ),
          SizedBox(
            width: 15,
          ),
          StyleButton(
              description: "Upload New",
              height: 55,
              width: 125,
              onTap: () {
                widget.openMediaForm();
              })
        ],
      ),
    );
  }
}
