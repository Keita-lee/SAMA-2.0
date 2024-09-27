import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/banner/samaBlueBanner.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/Events/MemberEventDetails/MemberEventDetails.dart';
import 'package:sama/member/Events/MemberEvents/MemberEventsComp/MemberContainer.dart';
import 'package:sama/member/Events/MemberEvents/MemberEventsComp/desktopViewDetailsPopup.dart';
import 'package:sama/member/Events/MemberEvents/MemberEventsComp/eventViewDeatilsButton.dart';
import 'package:sama/member/Events/MemberEvents/MemberEventsComp/mobileEventsDetailsPopUp.dart';
import 'package:sama/member/Events/MemberEvents/calendarViewEvents.dart';

var id = "";

class MemberEvents extends StatefulWidget {
  const MemberEvents({Key? key}) : super(key: key);

  @override
  State<MemberEvents> createState() => _MemberEventsState();
}

class _MemberEventsState extends State<MemberEvents> {
  var pageIndex = 0;

  //Popup member dialog
  Future openMemberEventsDialog(id) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: MemberEventDetails(
          id: id,
          closeDialog: () => Navigator.pop(context!),
        ));
      });

  openEventDetails(idValue) {
    print(id);
    setState(() {
      id = idValue;
      pageIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SamaBlueBanner(pageName: 'EVENTS'),
          SizedBox(
            height: isMobile == true ? 30 : 80,
          ),
            /// NEW CALENDAR VIEW
          // CalendarViewEvents(),
           
         
          Visibility(
            visible: pageIndex == 0 ? true : false,
            child: Padding(
              padding: isMobile
                  ? EdgeInsets.all(0)
                  : EdgeInsets.only(left: 50, top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Events',
                        style: TextStyle(
                          fontSize: 36,
                          color: Color(0xFF3D3D3D),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Events module v1.1',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF3D3D3D),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Upcoming',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF3D3D3D),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),*/
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('events')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: snapshot error');
                      }
                      if (!snapshot.hasData) {
                        return const Text('Loading...');
                      }

                      final List<DocumentSnapshot> documents =
                          snapshot.data!.docs;
                      if (documents.isEmpty) {
                        return Center(child: Text('No Media & Webinars yet'));
                      }

                      return Container(
                        color: Colors.white,
                        width: isMobile
                            ? MyUtility(context).width
                            : MyUtility(context).width * 0.60,
                        height:
                            isMobile ? MyUtility(context).height / 1.3 : 700,
                        child: ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            documents
                                .sort((b, a) => a["date"].compareTo(b["date"]));
                            final DocumentSnapshot document = documents[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: isMobile
                                    ? MyUtility(context).width
                                    : MyUtility(context).width * 0.9,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(255, 212, 210, 210),
                                        width: 1.5)),
                                child: MemberContainer(
                                  eventImage: document['eventsImage']!,
                                  eventName: document['title']!,
                                  location: document['_location']!,
                                  dateFrom: document['date']!,
                                  dateTill: document['endDate']!,
                                  onPressed: () {
                                    openEventDetails(document['id']);
                                    //  openMemberEventsDialog(document['id']);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Visibility(
              visible: pageIndex == 1 ? true : false,
              child: MemberEventDetails(
                id: id,
                closeDialog: () {
                  setState(() {
                    pageIndex = 0;
                    id = "";
                  });
                },
              )),
        ],
      ),
    );
  }
}
