import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';

import '../../../../../../../components/myutility.dart';

class DiscusStyle extends StatefulWidget {
  final String profileUrl;
  final String name;
  final String date;
  final String description;

  DiscusStyle({
    super.key,
    required this.profileUrl,
    required this.name,
    required this.date,
    required this.description,
  });

  @override
  State<DiscusStyle> createState() => _DiscusStyleState();
}

class _DiscusStyleState extends State<DiscusStyle> {
  late final QuillController quillController;
  late final DateTime parsedDate;

  @override
  void initState() {
    super.initState();

    // Parse JSON description
    var myJSON = jsonDecode(widget.description);
    quillController = QuillController(
      readOnly: true,
      document: Document.fromJson(myJSON),
      selection: TextSelection.collapsed(offset: 0),
    );

    // Parse the custom date format
    final dateFormat = DateFormat('dd-MMM-yyyy');
    parsedDate = dateFormat.parse(widget.date);
  }

  @override
  Widget build(BuildContext context) {
    // Format the date
    String formattedDate = DateFormat('MMMM d, y, h:mm a').format(parsedDate);

    return Column(
      children: [
        Container(
          width: MyUtility(context).width / 1.3,
          height: 100,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 241, 241),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            border: Border.all(
              color: Color(0xFFD1D1D1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: widget.profileUrl.isNotEmpty
                          ? Image.network(
                              widget.profileUrl,
                              width: 75,
                              height: 75,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.grey,
                                );
                              },
                            )
                          : Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 19,
                            color: Color.fromARGB(255, 8, 55, 145),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'Other',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Student, Intern, and Community Service Doctors Community (your community)',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 8, 55, 145),
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: MyUtility(context).width / 1.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            border: Border.all(
              color: Color(0xFFD1D1D1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            // Your delete action here
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 8, 55, 145),
                          ),
                          label: Text(
                            'Delete',
                            style: TextStyle(
                              color: Color.fromARGB(255, 8, 55, 145),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        TextButton.icon(
                          onPressed: () {
                            // Your edit action here
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Color.fromARGB(255, 8, 55, 145),
                          ),
                          label: Text(
                            'Edit',
                            style: TextStyle(
                              color: Color.fromARGB(255, 8, 55, 145),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Container(
                    height: 0.5,
                    width: MyUtility(context).width / 1.2,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 8),
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
      ],
    );
  }
}
