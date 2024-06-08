import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/admin/Events/EventDetails/EventDetailComp/EventText.dart';
import 'package:sama/admin/Events/EventDetails/EventDetailComp/EventsImage.dart';
import 'package:sama/admin/Events/NewEvent/NewEventComp/EventTextField.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/member/media/mediaPopup/mediaPopup.dart';

class MemberEventDetails extends StatefulWidget {
  String id;
  Function closeDialog;

  MemberEventDetails({Key? key, required this.closeDialog, required this.id})
      : super(key: key);

  @override
  _MemberEventDetailsState createState() => _MemberEventDetailsState();
}

class _MemberEventDetailsState extends State<MemberEventDetails> {
  TextEditingController bookings = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _times = TextEditingController();
  TextEditingController _event = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _area = TextEditingController();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();

  String eventsImage = "";
  List attending = [];
  final List<String> imagePaths = [
    'images/coffee.jpg',
    'images/coffee.jpg',
    'images/coffee.jpg',
    'images/coffee.jpg',
    'images/coffee.jpg',
    'images/coffee.jpg',
  ];

  int _currentPage = 0;
  final PageController _pageController = PageController(viewportFraction: .33);
  int _selectedNumber = 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
        attending = data.get('attending');
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

  confirmBooking() async {
    var bookingData = {
      "email": email.text,
      "firstName": firstName.text,
      "lastName": lastName.text,
      "peopleAmmount": _selectedNumber
    };
    attending.add(bookingData);

    final data = await FirebaseFirestore.instance
        .collection('events')
        .doc(widget.id)
        .update({"attending": attending}).whenComplete(widget.closeDialog());
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
    return Container(
      width: MyUtility(context).width * 0.50,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.scale(
              scale: 0.8,
              child: Container(
                padding: const EdgeInsets.only(top: 5, bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Events Details',
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF3D3D3D),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        widget.closeDialog();
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            ),
            Transform.scale(
              scale: 0.8,
              child: Container(
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
                                timeFrom: _times.text,
                                timeTill: '')),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Transform.scale(
              scale: 0.8,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF3D3D3D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _description.text,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3D3D3D),
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            Transform.scale(
              scale: 0.8,
              child: SizedBox(
                width: MyUtility(context).width * 0.75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 300,
                      child: Row(
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
                    ),
                    // EventTxtField(
                    //   controller: bookingnumber,
                    //   textSection: 'How many people',
                    // ),
                    StyleButton(
                      description: 'Confirm Booking',
                      height: 55,
                      width: 150,
                      onTap: () {
                        confirmBooking();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
