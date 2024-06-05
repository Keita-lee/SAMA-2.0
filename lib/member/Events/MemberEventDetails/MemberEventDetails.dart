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
  TextEditingController bookingnumber = TextEditingController();
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /*void _previousImage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextImage() {
    if (_currentPage < imagePaths.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }*/

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
      "peopleAmmount": bookingnumber.text
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
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            ImageNetwork(
              image: eventsImage,
              width: MyUtility(context).width * 0.2,
              height: MyUtility(context).height * 0.35,
            ),
            /*  SizedBox(
              width: MyUtility(context).width * 0.75,
              height: MyUtility(context).height * 0.3,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: imagePaths.length,
                    onPageChanged: (int index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: EventImage(eventImage: imagePaths[index]),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 10.0,
                    left: 0.0,
                    right: 0.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(imagePaths.length, (index) {
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MyUtility(context).width * 0.75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: _previousImage,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: _nextImage,
                  ),
                ],
              ),
            ),*/
            Text(
              'Events Details',
              style: TextStyle(
                fontSize: 32,
                color: Color(0xFF3D3D3D),
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: MyUtility(context).height * 0.02),
            Container(
              width: MyUtility(context).width * 0.75,
              height: MyUtility(context).height * 0.2,
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
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MyUtility(context).width * 0.15,
                          child: EventText(
                              title: _title.text,
                              date: _date.text,
                              timeFrom: _times.text,
                              timeTill: '')),
                      SizedBox(
                        width: MyUtility(context).width * 0.55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                            Text(
                              _description.text,
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF3D3D3D),
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MyUtility(context).height * 0.025,
            ),
            SizedBox(
              width: MyUtility(context).width * 0.75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EventTxtField(
                    controller: bookingnumber,
                    textSection: 'How many people',
                  ),
                  StyleButton(
                    description: 'Confirm Booking',
                    height: 55,
                    width: 150,
                    onTap: confirmBooking(),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
