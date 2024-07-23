import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/admin/Events/EventDetails/EventDetailComp/EventText.dart';
import 'package:sama/admin/Events/EventDetails/EventDetailComp/EventsImage.dart';
import 'package:sama/admin/Events/NewEvent/NewEventComp/EventTextField.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/login/popups/validateDialog.dart';
import 'package:sama/member/media/mediaPopup/mediaPopup.dart';

class MemberEventDetails extends StatefulWidget {
  String id;
  VoidCallback closeDialog;

  MemberEventDetails({Key? key, required this.closeDialog, required this.id})
      : super(key: key);

  @override
  _MemberEventDetailsState createState() => _MemberEventDetailsState();
}

class _MemberEventDetailsState extends State<MemberEventDetails> {
  //Text editing controllers
  TextEditingController bookings = TextEditingController();
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

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  var myJSON;
  QuillController quillController = QuillController.basic();

  //String
  String eventsImage = "";
  List attending = [];
  int _currentPage = 0;
  final PageController _pageController = PageController(viewportFraction: .33);
  int _selectedNumber = 1;

  bool checkIfMadeBooking = false;
  double attendeesAlreadyAdded = 0;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

//retrieve event data
  getEventData() async {
    final data = await FirebaseFirestore.instance
        .collection('events')
        .doc(widget.id)
        .get();

    if (data.exists) {
      setState(() {
        _title.text = data.get('title');
        _date.text = data.get('date');
        endDate.text = data.get('date');
        _times.text = data.get('_times');
        _event.text = data.get('_event');
        // _description.text = data.get('_description');
        _location.text = data.get('_location');
        _area.text = data.get('_area');
        _memberPricing.text = data.get('memberPricing');
        _eventProvider.text = data.get('eventProvider');
        _CPDAccreditation.text = data.get('CPDAccreditation');
        eventsImage = data.get('eventsImage');
        attending = data.get('attending');
        _memberAmount.text = data.get('_memberAmount');
        myJSON = jsonDecode(data.get('_description'));
        quillController = QuillController(
            document: Document.fromJson(myJSON),
            selection: TextSelection.collapsed(offset: 0));
      });
    }
    setState(() {});
    print('events captured');
  }

  getUserData() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (data.exists) {
      setState(() {
        firstName.text = data.get('firstName');
        lastName.text = data.get('lastName');
        email.text = data.get('email');
      });
    }
  }

  //Dialog  already made booking
  Future validateBooking(description) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: ValidateDialog(
                description: description,
                closeDialog: () => Navigator.pop(context!)));
      });
//complete booking
  confirmBooking() async {
    var checkIfExist = false;
    var attendingAmount = 0.0;

    for (int i = 0; i < attending.length; i++) {
      setState(() {
        attendingAmount = attendingAmount + attending[i]['peopleAmmount'];
      });

      if (attending[i]["email"] == email.text) {
        setState(() {
          checkIfExist = true;
        });
      }
    }

    var bookingData = {
      "email": email.text.toLowerCase(),
      "firstName": firstName.text,
      "lastName": lastName.text,
      "peopleAmmount": _selectedNumber
    };
    setState(() {
      attending.add(bookingData);
    });

    if (checkIfExist) {
      validateBooking("Booking already made");
    } else if (attendingAmount >= double.parse(_memberAmount.text)) {
      validateBooking(
          "Member amount reached ${double.parse(_memberAmount.text)} ${attendingAmount}");
    } else {
      final data = await FirebaseFirestore.instance
          .collection('events')
          .doc(widget.id)
          .update({"attending": attending}).whenComplete(() {
        validateBooking("Booking made successfully");
      });
    }
  }

  var attendingAmount = 0.0;
  updateBooking() async {
    attendingAmount = 0;
    var bookingData = {
      "email": email.text.toLowerCase(),
      "firstName": firstName.text,
      "lastName": lastName.text,
      "peopleAmmount": _selectedNumber
    };

    for (int i = 0; i < attending.length; i++) {
      setState(() {
        attendingAmount = attendingAmount + attending[i]['peopleAmmount'];
      });
    }
    setState(() {
      attending.add(bookingData);
    });

    if (((attendingAmount + _selectedNumber) - attendeesAlreadyAdded) >
        double.parse(_memberAmount.text)) {
      validateBooking("Member amount reached ");
    } else {
      for (int i = 0; i < attending.length; i++) {
        if (attending[i]["email"] == email.text) {
          setState(() {
            attending.removeAt(i);
          });
        }
      }

      final data = await FirebaseFirestore.instance
          .collection('events')
          .doc(widget.id)
          .update({"attending": attending}).whenComplete(
              validateBooking("Booking Updated") as FutureOr<void> Function());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.id != "") {
      getEventData();
      getUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    //check if user already made booking
    for (int i = 0; i < attending.length; i++) {
      if (attending[i]["email"] == email.text) {
        setState(() {
          checkIfMadeBooking = true;
          attendeesAlreadyAdded = attending[i]["peopleAmmount"];
        });
      }
    }

    return Container(
      color: Colors.white,
      width: MyUtility(context).width * 0.50,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 5, bottom: 25),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Spacer(),
                    StyleButton(
                        description: "View Events",
                        height: 55,
                        width: 125,
                        onTap: () {
                          widget.closeDialog();
                        }),
                  ],
                ),
              ),
              Text(
                'Events Details',
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFF3D3D3D),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Visibility(
                        visible: eventsImage == "" ? true : false,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/imageIcon.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            width: MyUtility(context).width * 0.15,
                            height: MyUtility(context).height * 0.15,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: eventsImage == "" ? false : true,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: ImageNetwork(
                              image: eventsImage,
                              width: MyUtility(context).width * 0.15,
                              height: MyUtility(context).height * 0.15,
                              fitWeb: BoxFitWeb.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  SizedBox(
                    width: MyUtility(context).width * 0.25,
                    child: Text(
                      _title.text,
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF3D3D3D),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Start Date: ' + _date.text,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF3D3D3D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '   ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF3D3D3D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'End Date: ' + endDate.text,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF3D3D3D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Time ' + _times.text,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF3D3D3D),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              /*     Container(
                width: MyUtility(context).width * 0.75,
                height: MyUtility(context).height * 0.13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(42, 81, 125, 162)),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            //width: MyUtility(context).width * 0.15,
                            child: EventText(
                                title: _title.text,
                                date: _date.text,
                                endDate: endDate.text,
                                timeFrom: _times.text,
                                timeTill: '')),
                      ],
                    ),
                  ),
                ),
              ),
          */
              Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QuillEditor.basic(
                      configurations: QuillEditorConfigurations(
                        controller: quillController,
                        sharedConfigurations: const QuillSharedConfigurations(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Member Pricing:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF3D3D3D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _memberPricing.text,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3D3D3D),
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Event Provider:',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF3D3D3D),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _eventProvider.text,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF3D3D3D),
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'CPD Accreditation:',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF3D3D3D),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _CPDAccreditation.text,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF3D3D3D),
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MyUtility(context).width * 0.75,
                child: Row(
                  children: [
                    Container(
                      width: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'How many people:',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF3D3D3D),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10),
                              DropdownButton<int>(
                                value: _selectedNumber,
                                items: List.generate(10, (index) {
                                  return DropdownMenuItem<int>(
                                    value: index + 1,
                                    child: Text((index + 1).toString()),
                                  );
                                }),
                                onChanged: (int? newValue) {
                                  setState(() {
                                    _selectedNumber = newValue!;
                                  });
                                },
                              ),
                            ],
                          ),
                          Visibility(
                            visible: checkIfMadeBooking ? true : false,
                            child: Text(
                              'Booking amount made - ${attendeesAlreadyAdded}',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF3D3D3D),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Visibility(
                      visible: checkIfMadeBooking ? true : false,
                      child: StyleButton(
                        description: 'Update Booking',
                        height: 55,
                        width: 150,
                        onTap: () {
                          updateBooking();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Visibility(
                      visible: checkIfMadeBooking ? false : true,
                      child: StyleButton(
                        description: 'Confirm Booking',
                        height: 55,
                        width: 150,
                        onTap: () {
                          confirmBooking();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
