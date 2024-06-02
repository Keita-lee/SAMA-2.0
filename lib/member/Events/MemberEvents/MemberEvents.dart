import 'package:flutter/material.dart';
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
  //Popup Events dialog
  Future OpenMemberEventsDialog(id) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: MemberEventDetails(
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
            fontSize: 24,
            color: Color(0xFF3D3D3D),
            fontWeight: FontWeight.normal,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 10),
          child: Text(
            'Upcoming',
            style: TextStyle(
              fontSize: 24,
              color: Color(0xFF3D3D3D),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Row(
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
      ],
    );
  }
}
