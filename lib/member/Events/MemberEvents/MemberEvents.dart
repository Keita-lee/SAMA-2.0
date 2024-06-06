import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/Events/MemberEventDetails/MemberEventDetails.dart';
import 'package:sama/member/Events/MemberEvents/MemberEventsComp/MemberContainer.dart';

final List<Map<String, String>> events = [
  {
    'eventImage': 'images/coffee.jpg',
    'eventName': 'Event1',
    'location': 'Caesars Palace',
    'dateFrom': '13 June',
    'dateTill': '15 June',
  },
  {
    'eventImage': 'images/coffee.jpg',
    'eventName': 'Event2',
    'location': 'Sun Arena',
    'dateFrom': '20 June',
    'dateTill': '22 June',
  },
  {
    'eventImage': 'images/coffee.jpg',
    'eventName': 'Event3',
    'location': 'Caesars Palace',
    'dateFrom': '24 June',
    'dateTill': '26 June',
  },
  {
    'eventImage': 'images/coffee.jpg',
    'eventName': 'Event4',
    'location': 'Caesars Palace',
    'dateFrom': '13 June',
    'dateTill': '15 June',
  },
  {
    'eventImage': 'images/coffee.jpg',
    'eventName': 'Event5',
    'location': 'Sun Arena',
    'dateFrom': '20 June',
    'dateTill': '22 June',
  },
  {
    'eventImage': 'images/coffee.jpg',
    'eventName': 'Event6',
    'location': 'Caesars Palace',
    'dateFrom': '24 June',
    'dateTill': '26 June',
  },
];

class MemberEvents extends StatefulWidget {
  const MemberEvents({Key? key}) : super(key: key);

  @override
  State<MemberEvents> createState() => _MemberEventsState();
}

class _MemberEventsState extends State<MemberEvents> {
  test(id) {
    print(id);
  }

  //Popup Events dialog
  Future openMemberEventsDialog(id) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: MemberEventDetails(
          id: id,
          closeDialog: () => Navigator.pop(context!),
        ));
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Events',
          style: TextStyle(
            fontSize: 36,
            color: Color(0xFF3D3D3D),
            fontWeight: FontWeight.normal,
          ),
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
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('events').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: snapshot error');
              }
              if (!snapshot.hasData) {
                return const Text('Loading...');
              }

              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              if (documents.isEmpty) {
                return Center(child: Text('No Media Podcast yet'));
              }

              return Container(
                  width: MyUtility(context).width -
                      (MyUtility(context).width * 0.25),
                  height: 550,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        final DocumentSnapshot document = documents[index];
                        return Container(
                          child: Wrap(
                            //mainAxisAlignment: MainAxisAlignment.start,

                            children: [
                              MemberContainer(
                                eventImage: document['eventsImage']!,
                                eventName: document['title']!,
                                location: document['_location']!,
                                dateFrom: document['date']!,
                                dateTill: document['date']!,
                                onPressed: () {
                                  openMemberEventsDialog(document['id']);
                                },
                              ),
                            ],
                          ),
                        );
                      }));
            }),
        /*     Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: events.take(3).map((event) {
                return MemberContainer(
                  eventImage: event['eventImage']!,
                  eventName: event['eventName']!,
                  location: event['location']!,
                  dateFrom: event['dateFrom']!,
                  dateTill: event['dateTill']!,
                  onPressed: () {
                    OpenMemberEventsDialog("");
                  },
                );
              }).toList(),
            ),
            Column(
              children: events.skip(3).map((event) {
                return MemberContainer(
                  eventImage: event['eventImage']!,
                  eventName: event['eventName']!,
                  location: event['location']!,
                  dateFrom: event['dateFrom']!,
                  dateTill: event['dateTill']!,
                  onPressed: () {
                    OpenMemberEventsDialog("");
                  },
                );
              }).toList(),
            ),
          ],
        )
    */
      ],
    );
  }
}
