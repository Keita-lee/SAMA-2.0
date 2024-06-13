import 'package:flutter/material.dart';
import 'package:sama/admin/media/mediaForm/mediaForm.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/components/styleButton.dart';

class MediaHeaderSection extends StatefulWidget {
  TextEditingController controller;
  VoidCallback openMediaForm;
  Function(String) getCategoryValue;
  MediaHeaderSection(
      {super.key,
      required this.controller,
      required this.openMediaForm,
      required this.getCategoryValue});

  @override
  State<MediaHeaderSection> createState() => _MediaHeaderSectionState();
}

class _MediaHeaderSectionState extends State<MediaHeaderSection> {
  List items = [
    'Webinar',
    'SAMA News',
    'General',
    'Conferences',
    'Virtual Meeting',
    'Office of the Chair',
    'Corona Virus - COVID-19',
    'Courses',
  ];
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select a Category",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF6A6A6A),
                ),
              ),
              DropdownMenu<String>(
                width: 250,
                controller: widget.controller,
                requestFocusOnTap: true,
                label: const Text(''),
                onSelected: (value) {
                  setState(() {
                    widget.getCategoryValue(value!);
                  });
                },
                dropdownMenuEntries:
                    items.map<DropdownMenuEntry<String>>((value) {
                  return DropdownMenuEntry<String>(
                    value: value,
                    label: value,
                  );
                }).toList(),
              ),
            ],
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
