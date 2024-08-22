import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../components/styleButton.dart';
import 'ui/applicationContainerStyle.dart';

class ApplicationType extends StatefulWidget {
  List applicationTypes;
  Function(int) nextSection;
  Function(String) applicationTypeSelected;
  ApplicationType(
      {super.key,
      required this.applicationTypes,
      required this.nextSection,
      required this.applicationTypeSelected});

  @override
  State<ApplicationType> createState() => _ApplicationTypeState();
}

class _ApplicationTypeState extends State<ApplicationType> {
  var pageIndex = 0;

  //update page index
  changePageIndex(value) {
    setState(() {
      pageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (var i = 0; i < widget.applicationTypes.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Applicationcontainerstyle(
              onpress: changePageIndex,
              applicationTypeSelected: widget.applicationTypeSelected,
              index: pageIndex,
              value: i,
              description: widget.applicationTypes[i],
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StyleButton(
                description: "Continue",
                height: 55,
                width: 125,
                onTap: () {
                  widget.nextSection(1);
                })
          ],
        )
      ],
    );
  }
}
