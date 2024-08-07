import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../../../components/myutility.dart';
import '../../../../../components/styleButton.dart';

class ComTextView extends StatefulWidget {
  String title;
  String details;
  List tags;
  ComTextView(
      {super.key,
      required this.title,
      required this.details,
      required this.tags});

  @override
  State<ComTextView> createState() => _ComTextViewState();
}

class _ComTextViewState extends State<ComTextView> {
  QuillController quillController = QuillController.basic();
  var myJSON;

  @override
  void initState() {
    myJSON = jsonDecode(widget.details);
    quillController = QuillController(
        readOnly: true,
        document: Document.fromJson(myJSON),
        selection: TextSelection.collapsed(offset: 0));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: MyUtility(context).width / 1.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color(0xFFD1D1D1),
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '${widget.title}',
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              'Tags :${widget.title}',
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: MyUtility(context).width / 1.3,
                          decoration: BoxDecoration(),
                          child: QuillEditor.basic(
                            configurations: QuillEditorConfigurations(
                              controller: quillController,
                              sharedConfigurations:
                                  const QuillSharedConfigurations(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    )))));
    /* */
  }
}
