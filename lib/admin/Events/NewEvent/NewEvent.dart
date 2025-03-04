import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sama/admin/Events/AdminEvents/UI/addEventsImage.dart';
import 'package:sama/admin/Events/NewEvent/NewEventComp/EventDescriptionTextField.dart';
import 'package:sama/admin/Events/NewEvent/NewEventComp/EventTextField.dart';
import 'package:sama/admin/Events/NewEvent/NewEventComp/eventAttendees.dart';
import 'package:sama/admin/Events/NewEvent/NewEventComp/startEndTimeSelect.dart';
import 'package:sama/components/dateSelecter.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/utility.dart';
import 'dart:io';

import 'package:sama/components/yesNoDialog.dart';

import '../../../Login/popups/validateDialog.dart';

class NewEvent extends StatefulWidget {
  Function closeDialog;
  String id;
  NewEvent({Key? key, required this.id, required this.closeDialog})
      : super(key: key);

  @override
  State<NewEvent> createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  //Text controllers
  TextEditingController _title = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController _times = TextEditingController();
  TextEditingController _event = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _area = TextEditingController();
  TextEditingController _memberPricing = TextEditingController();
  TextEditingController _eventProvider = TextEditingController();
  TextEditingController _CPDAccreditation = TextEditingController();
  TextEditingController _memberAmount = TextEditingController();

  var myJSON;
  QuillController quillController = QuillController.basic();

  //var
  String eventsImage = "";
  List attending = [];
  getEventsImageUrl(value) {
    setState(() {
      eventsImage = value;
    });
  }

  DateTime? releaseDate;

  //Dialog  already made booking
  Future descriptionPopup(description) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: ValidateDialog(
                description: description,
                closeDialog: () => Navigator.pop(context!)));
      });

//create new event / update
  createUpdateEvent() async {
    var eventData = {
      "title": _title.text,
      "date": _date.text,
      "endDate": endDate.text,
      "_times": _times.text,
      "_event": _event.text,
      "_description": jsonEncode(quillController.document.toDelta().toJson()),
      "_location": _location.text,
      "_area": _area.text,
      "id": widget.id,
      "eventsImage": eventsImage,
      //"releaseDate": releaseDate,
      "attending": attending,
      "memberPricing": _memberPricing.text,
      "eventProvider": _eventProvider.text,
      "CPDAccreditation": _CPDAccreditation.text,
      "_memberAmount": _memberAmount.text
    };

    if (widget.id == "") {
      var myNewDoc =
          await FirebaseFirestore.instance.collection("events").add(eventData);

      FirebaseFirestore.instance.collection("events").doc(myNewDoc.id).update({
        "id": myNewDoc.id,
      }).whenComplete(() => widget.closeDialog());
    } else {
      FirebaseFirestore.instance
          .collection("events")
          .doc(widget.id)
          .update(eventData)
          .whenComplete(() => descriptionPopup("Event Saved"));
    }
  }

//get event data
  getEventData() async {
    final data = await FirebaseFirestore.instance
        .collection('events')
        .doc(widget.id)
        .get();

    if (data.exists) {
      setState(() {
        _title.text = data.get('title');
        _date.text = data.get('date');
        endDate.text = data.get('endDate');
        _times.text = data.get('_times');
        _event.text = data.get('_event');
        // _description.text = data.get('_description');

        _location.text = data.get('_location');
        _area.text = data.get('_area');
        eventsImage = data.get('eventsImage');
        //releaseDate = data.get('releaseDate');
        attending.addAll(data.get('attending'));

        _memberPricing.text = data.get('memberPricing');
        _eventProvider.text = data.get('eventProvider');
        _CPDAccreditation.text = data.get('CPDAccreditation');
        _memberAmount.text = data.get('_memberAmount');
        myJSON = jsonDecode(data.get('_description'));
        quillController = QuillController(
            document: Document.fromJson(myJSON),
            selection: TextSelection.collapsed(offset: 0));
      });
    }
  }

//Popup view atten
  Future openViewEventAtt() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: EventAttendees(
          attendeesList: attending,
          closeDialog: () => Navigator.pop(context!),
        ));
      });

  getTimes(value) {
    setState(() {
      _times.text = value;
    });
  }

  //Popup view start end time
  Future openStartEndTimes() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: StartEndTimeSelect(
          getTimes: getTimes,
          closeDialog: () => Navigator.pop(context!),
        ));
      });
  @override
  void initState() {
    super.initState();
    if (widget.id != "") {
      getEventData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent, // Set Scaffold background to transparent
      body: Center(
        child: Transform.scale(
          scale: 0.8,
          child: Container(
            width: MyUtility(context).width * 0.55,
            height: MyUtility(context).height * 2,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Container(
              height: MyUtility(context).height * 1.8,
              child: SingleChildScrollView(
                child: SizedBox(
                  width: MyUtility(context).width * 0.515,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text(
                              'Events',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color(0xFF174486),
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  widget.closeDialog();
                                },
                                child: Icon(Icons.cancel),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AddEventsImage(
                          networkImageUrl: eventsImage,
                          updateUrl: getEventsImageUrl,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            EventTxtField(
                              controller: _title,
                              textSection: 'Title',
                              customWidth:
                                  MediaQuery.of(context).size.width * 0.515,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DateSelecter(
                              customSize:
                                  MediaQuery.of(context).size.width * 0.25,
                              controller: _date,
                              refresh: () {},
                              description: 'Start Date',
                            ),
                            DateSelecter(
                              customSize:
                                  MediaQuery.of(context).size.width * 0.25,
                              controller: endDate,
                              refresh: () {},
                              description: 'End Date',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: EventTxtField(
                                controller: _times,
                                textSection: 'Start-EndTime',
                              ),
                            ),
                            StyleButton(
                              description: 'Select time',
                              onTap: () {
                                openStartEndTimes();
                              },
                              height: 55,
                              width: 150,
                            ),
                            EventTxtField(
                              controller: _event,
                              textSection: 'Type of Event',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            EventTxtField(
                              controller: _location,
                              textSection: 'Location',
                            ),
                            EventTxtField(
                              controller: _area,
                              textSection: 'Area',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            EventTxtField(
                              controller: _memberPricing,
                              textSection: 'Member Pricing',
                            ),
                            EventTxtField(
                              controller: _eventProvider,
                              textSection: 'Event Provider',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            EventTxtField(
                              controller: _CPDAccreditation,
                              textSection: 'CPD Accreditation',
                            ),
                            EventTxtField(
                              controller: _memberAmount,
                              textSection: 'Maximum Attendees ',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: QuillToolbar.simple(
                          configurations: QuillSimpleToolbarConfigurations(
                            controller: quillController,
                            sharedConfigurations:
                                const QuillSharedConfigurations(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MyUtility(context).width * 0.51,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: QuillEditor.basic(
                            configurations: QuillEditorConfigurations(
                              controller: quillController,
                              sharedConfigurations:
                                  const QuillSharedConfigurations(),
                            ),
                          ),
                        ),
                      ),
                      /*    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: EventDescriptionTextField(
                          controller: _description,
                          textSection: 'Description',
                        ),
                      ),*/
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            StyleButton(
                              description: 'Save Event',
                              onTap: () {
                                createUpdateEvent();
                              },
                              height: 55,
                              width: 150,
                            ),
                            /*  SizedBox(
                              width: 10,
                            ),
                            Visibility(
                              visible: widget.id != "" ? true : false,
                              child: StyleButton(
                                description: 'View Attendees',
                                onTap: () {
                                  openViewEventAtt();
                                },
                                height: 55,
                                width: 150,
                              ),
                            ),*/
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
