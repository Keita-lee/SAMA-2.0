import 'package:flutter/material.dart';
import 'package:sama/admin/Events/AdminEvents/UI/EventsList.dart';
import 'package:sama/components/myutility.dart';

class UpcommingEvents extends StatefulWidget {
  const UpcommingEvents({Key? key}) : super(key: key);

  @override
  State<UpcommingEvents> createState() => _UpcommingEventsState();
}

class _UpcommingEventsState extends State<UpcommingEvents> {
  final List<Map<String, String>> events = [
    {
      'eventName': 'Event 1',
      'date': '15 June 2024',
      'location': 'Caesars Palace',
      'area': 'Gauteng',
      'attending': '4',
    },
    {
      'eventName': 'Event 2',
      'date': '20 June 2024',
      'location': 'Sun Arena',
      'area': 'Pretoria',
      'attending': '7',
    },
    {
      'eventName': 'Event 3',
      'date': '24 June 2024',
      'location': 'Caesars Palace',
      'area': 'Gauteng',
      'attending': '103',
    },
    {
      'eventName': 'Event 4',
      'date': '29 June 2024',
      'location': 'Sun Arena',
      'area': 'Pretoria',
      'attending': '5',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: SizedBox(
            width: MyUtility(context).width * 0.8,
            height: MyUtility(context).height * 0.05,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Event Name',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF3D3D3D),
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF3D3D3D),
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF3D3D3D),
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Area',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF3D3D3D),
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Attending',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF3D3D3D),
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return EventsList(
                eventName: event['eventName']!,
                date: event['date']!,
                location: event['location']!,
                area: event['area']!,
                attending: event['attending']!,
              );
            },
          ),
        ),
      ],
    );
  }
}
