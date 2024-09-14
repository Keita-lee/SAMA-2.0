import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/profileTextField.dart';

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
  List _resources = [];
  List _filteredResources = [];
  List _tags = ['Clear Filter'];
  final TextEditingController _tagController = TextEditingController();
//get list of resources based on type
  getResourcesForType() async {
    _tags.clear();
    //resources.clear();
    final data =
        await FirebaseFirestore.instance.collection('communities').get();
    setState(() {
      for (var i = 0; i < data.docs.length; i++) {
        if (data.docs[i]['communities'].contains(widget.resourceType)) {
          if (!_tags.contains(data.docs[i]['title'])) {
            _tags.add(data.docs[i]['title']);
          }
          setState(() {
            _resources.add(data.docs[i]);
            _filteredResources = _resources;
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

  void filterResources() {
    List filteredResources = [];
    if (_tagController.text == '')
      filteredResources = _resources;
    else {
      filteredResources = _resources
          .where((resource) =>
              resource['title'].toString().toLowerCase() ==
              _tagController.text.toLowerCase())
          .toList();
    }

    setState(() {
      _filteredResources = filteredResources;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: isMobile
                ? MyUtility(context).width
                : MyUtility(context).width * 0.78,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ProfileDropDownField(
                      isBold: false,
                      description: 'Filter Tags',
                      customSize: 250,
                      items: _tags,
                      onChanged: filterResources,
                      textfieldController: _tagController),
                  _tagController.text != ''
                      ? TextButton(
                          onPressed: () {
                            setState(() {
                              _tagController.text = '';
                            });
                            filterResources();
                          },
                          child: const Text(
                            'Clear Filter',
                            style: TextStyle(color: Colors.teal),
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ),
          SizedBox(
            height: isMobile
                ? MyUtility(context).height / 1.7
                : MyUtility(context).height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < _filteredResources.length; i++)
                    Column(
                      children: [
                        if (_filteredResources[i]["type"] == "PDF")
                          Visibility(
                              visible: _filteredResources[i]["type"] == "PDF",
                              child: ComPdfView(
                                downloadUrl: _filteredResources[i]["pdfLink"],
                                title: _filteredResources[i]["title"],
                                tags: [],
                              )),
                        if (_filteredResources[i]["type"] == "TEXT")
                          Visibility(
                              visible: _filteredResources[i]["type"] == "TEXT",
                              child: ComTextView(
                                details: _filteredResources[i]["details"],
                                title: _filteredResources[i]["title"],
                                tags: [],
                              )), /* */
                      ],
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
