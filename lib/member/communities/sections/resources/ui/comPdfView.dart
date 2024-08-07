import 'package:flutter/material.dart';

import '../../../../../components/myutility.dart';
import '../../../../../components/styleButton.dart';

class ComPdfView extends StatefulWidget {
  String title;
  String downloadUrl;
  List tags;
  ComPdfView(
      {super.key,
      required this.title,
      required this.downloadUrl,
      required this.tags});

  @override
  State<ComPdfView> createState() => _ComPdfViewState();
}

class _ComPdfViewState extends State<ComPdfView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: MyUtility(context).width / 1.3,
            height: 155,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.title}',
                          style: const TextStyle(
                              fontSize: 25,
                              color: Colors.teal,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        StyleButton(
                            buttonColor: Colors.teal,
                            description: "Download",
                            height: 55,
                            width: 125,
                            onTap: () {}),
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
                  ],
                ))));
    /* */
  }
}
