import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'ui/comPdfView.dart';
import 'ui/comTextView.dart';

class Resources extends StatefulWidget {
  String resourceType;
  Function(int, String) changePageIndex;
  Resources(
      {super.key, required this.resourceType, required this.changePageIndex});

  @override
  State<Resources> createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> {
  List resources = [];

//get list of resources based on type
  getResourcesForType() async {
    //resources.clear();
    final data =
        await FirebaseFirestore.instance.collection('communities').get();
    setState(() {
      for (var i = 0; i < data.docs.length; i++) {
        if (data.docs[i]['communities'].contains(widget.resourceType)) {
          setState(() {
            resources.add(data.docs[i]);
          });
        }
      }
    });
  }

  @override
  void initState() {
    getResourcesForType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < resources.length; i++)
          Column(
            children: [
              if (resources[i]["type"] == "PDF")
                Visibility(
                    visible: resources[i]["type"] == "PDF",
                    child: ComPdfView(
                      downloadUrl: resources[i]["pdfLink"],
                      title: resources[i]["title"],
                      tags: [],
                    )),
              if (resources[i]["type"] == "TEXT")
                Visibility(
                    visible: resources[i]["type"] == "TEXT",
                    child: ComTextView(
                      details: resources[i]["details"],
                      title: resources[i]["title"],
                      tags: [],
                    )), /* */
            ],
          )
      ],
    );
  }
}
