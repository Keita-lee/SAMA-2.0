import 'package:flutter/material.dart';
import 'package:sama/admin/Events/EventDetails/EventDetailComp/AdminEventContainer.dart';
import 'package:sama/components/myutility.dart';

class EventMemberList extends StatefulWidget {
  const EventMemberList({Key? key}) : super(key: key);

  @override
  State<EventMemberList> createState() => _EventMemberListState();
}

class _EventMemberListState extends State<EventMemberList> {
  final List<Map<String, String>> events = [
    {'memberName': 'Event 1', 'area': '15 June 2024'},
    {'memberName': 'Event 2', 'area': '20 June 2024'},
    {'memberName': 'Event 3', 'area': '24 June 2024'},
    {'memberName': 'Event 4', 'area': '29 June 2024'},
  ];

  @override
  Widget build(BuildContext context) {
    final double width = MyUtility(context).width;
    final double height = MyUtility(context).height;

    return Container(
      width: width * 0.75,
      height: height * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildEventList(),
          SizedBox(height: height * 0.05),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: SizedBox(
        width: MyUtility(context).width * 0.75,
        height: MyUtility(context).height * 0.05,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Member Name',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF3D3D3D),
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: MyUtility(context).width * 0.15,
                child: Text(
                  'Area',
                  style: TextStyle(
                    fontSize: 24,
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
    );
  }

  Widget _buildEventList() {
    return Flexible(
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return AdminEventContainer(
            memberName: event['memberName']!,
            area: event['area']!,
          );
        },
      ),
    );
  }
}
