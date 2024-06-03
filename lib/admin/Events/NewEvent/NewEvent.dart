import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sama/admin/Events/AdminEvents/UI/addEventsImage.dart';
import 'package:sama/admin/Events/NewEvent/NewEventComp/EventDescriptionTextField.dart';
import 'package:sama/admin/Events/NewEvent/NewEventComp/EventTextField.dart';
import 'package:sama/components/utility.dart';
import 'dart:io';

class NewEvent extends StatefulWidget {
  Function closeDialog;
  String id;
  NewEvent({Key? key, required this.id, required this.closeDialog})
      : super(key: key);

  @override
  State<NewEvent> createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  TextEditingController _title = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _times = TextEditingController();
  TextEditingController _event = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _area = TextEditingController();
  String eventsImage = "";
  List attending = [];
  getEventsImageUrl(value) {
    setState(() {
      eventsImage = value;
    });
  }

  DateTime? releaseDate;

  createUpdateEvent() async {
    var eventData = {
      "title": _title.text,
      "date": _date.text,
      "_times": _times.text,
      "_event": _event.text,
      "_description": _description.text,
      "_location": _location.text,
      "_area": _area.text,
      "id": widget.id,
      "eventsImage": eventsImage,
      "releaseDate": releaseDate,
      "attending": attending
    };

    if (widget.id == "") {
      var myNewDoc =
          await FirebaseFirestore.instance.collection("events").add(eventData);

      FirebaseFirestore.instance.collection("events").doc(myNewDoc.id).update({
        "id": myNewDoc.id,
        "releaseDate": DateTime.now()
      }).whenComplete(() => widget.closeDialog());
    } else {
      FirebaseFirestore.instance
          .collection("events")
          .doc(widget.id)
          .update(eventData)
          .whenComplete(() => widget.closeDialog());
    }
  }

  getEventData() async {
    final data = await FirebaseFirestore.instance
        .collection('events')
        .doc(widget.id)
        .get();

    if (data.exists) {
      setState(() {
        _title.text = data.get('title');
        _date.text = data.get('date');
        _times.text = data.get('_times');
        _event.text = data.get('_event');
        _description.text = data.get('_description');
        _location.text = data.get('_location');
        _area.text = data.get('_area');
        eventsImage = data.get('eventsImage');
        releaseDate = data.get('releaseDate'); /**/
        // attending = data.get('attending');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.id);
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
        child: Container(
          width: MyUtility(context).width * 0.55,
          //  height: MyUtility(context).height * 0.7,
          decoration: ShapeDecoration(
            color: Color(0xFFFFF5F5),
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
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AddEventsImage(
                    networkImageUrl: eventsImage,
                    updateUrl: getEventsImageUrl,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        EventTxtField(
                          controller: _title,
                          textSection: 'Title',
                        ),
                        EventTxtField(
                          controller: _date,
                          textSection: 'Date',
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
                          controller: _times,
                          textSection: 'Start-EndTime',
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
                    child: EventDescriptionTextField(
                      controller: _description,
                      textSection: 'Description',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        createUpdateEvent();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        'Save Event',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF3D3D3D),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
