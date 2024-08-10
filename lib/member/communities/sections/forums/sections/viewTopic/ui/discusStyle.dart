import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_network/image_network.dart';

import '../../../../../../../components/myutility.dart';

class DiscusStyle extends StatefulWidget {
  String profileUrl;
  String name;
  String date;
  String description;
  DiscusStyle(
      {super.key,
      required this.profileUrl,
      required this.name,
      required this.date,
      required this.description});

  @override
  State<DiscusStyle> createState() => _DiscusStyleState();
}

class _DiscusStyleState extends State<DiscusStyle> {
  var myJSON;
  QuillController quillController = QuillController.basic();

  @override
  void initState() {
    myJSON = jsonDecode(widget.description);
    quillController = QuillController(
        readOnly: true,
        document: Document.fromJson(myJSON),
        selection: TextSelection.collapsed(offset: 0));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MyUtility(context).width / 1.2,
          height: 100,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 241, 241, 241),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Color(0xFFD1D1D1),
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: 85,
                      height: 85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: widget.profileUrl != ""
                            ? ImageNetwork(
                                image: widget.profileUrl!,
                                height: 85,
                                width: 85,
                              )
                            : Container(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(255, 8, 55, 145),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ), /**/
                ],
              ),
            ),
          ),
        ),
        Container(
          width: MyUtility(context).width / 1.2,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Color(0xFFD1D1D1),
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      widget.date,
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 87, 87, 87),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: MyUtility(context).width / 1.2,
                  height: 100,
                  child: QuillEditor.basic(
                    configurations: QuillEditorConfigurations(
                      controller: quillController,
                      sharedConfigurations: const QuillSharedConfigurations(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        /*  */
      ],
    );
  }
}
