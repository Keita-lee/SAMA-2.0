import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/components/styleButton.dart';

class EventsHeaderSection extends StatefulWidget {
  TextEditingController controller;
  VoidCallback openMediaForm;
  EventsHeaderSection(
      {super.key, required this.controller, required this.openMediaForm});

  @override
  State<EventsHeaderSection> createState() => _EventsHeaderSectionState();
}

class _EventsHeaderSectionState extends State<EventsHeaderSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: StyleButton(
                  description: "Add Event",
                  height: 55,
                  width: 125,
                  onTap: () {
                    widget.openMediaForm();
                  }),
            ),
          )
        ],
      ),
    );
  }
}
