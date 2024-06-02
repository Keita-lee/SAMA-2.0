import 'package:flutter/material.dart';
import 'package:sama/admin/Events/EventDetails/EventDetailComp/EventText.dart';
import 'package:sama/admin/Events/EventDetails/EventDetailComp/EventsImage.dart';
import 'package:sama/admin/Events/NewEvent/NewEventComp/EventTextField.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/media/mediaPopup/mediaPopup.dart';

class MemberEventDetails extends StatefulWidget {
  Function closeDialog;

  MemberEventDetails({Key? key, required this.closeDialog}) : super(key: key);

  @override
  _MemberEventDetailsState createState() => _MemberEventDetailsState();
}

class _MemberEventDetailsState extends State<MemberEventDetails> {
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

  void _previousImage() {
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
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController bookingnumber = TextEditingController();
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
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
            ),
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
                              title: 'Event Name',
                              date: 'Date Here',
                              timeFrom: 'Time',
                              timeTill: 'Time')),
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
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nisl condimentum id venenatis a condimentum vitae sapien',
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
                  ElevatedButton(
                    onPressed: () {
                      MediaPopup(
                        closeDialog: () {
                          Navigator.of(context).pop();
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Confirm Booking',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3D3D3D),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
