import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class EventAttendees extends StatefulWidget {
  Function closeDialog;
  List attendeesList;
  EventAttendees(
      {super.key, required this.closeDialog, required this.attendeesList});

  @override
  State<EventAttendees> createState() => _EventAttendeesState();
}

class _EventAttendeesState extends State<EventAttendees> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width / 2,
      height: MyUtility(context).height / 2.2,
      decoration: ShapeDecoration(
        color: Colors.white,
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
      child: Container(
        height: MyUtility(context).height * 1.8,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Attendees',
                      style: TextStyle(
                          fontSize: 25,
                          color: Color(0xFF174486),
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          widget.closeDialog();
                        },
                        child: Icon(Icons.cancel),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: MyUtility(context).width / 7,
                      child: Text('Email',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    SizedBox(
                      width: MyUtility(context).width / 8,
                      child: Text('Firstname',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    SizedBox(
                      width: MyUtility(context).width / 8,
                      child: Text('Lastname',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    SizedBox(
                      width: MyUtility(context).width / 12,
                      child: Text('Attending',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ],
                ),
              ),
              for (int i = 0; i < widget.attendeesList.length; i++)
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.5, color: Colors.grey),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MyUtility(context).width / 7,
                          child: Text(widget.attendeesList[i]["email"],
                              style: TextStyle(fontSize: 14)),
                        ),
                        SizedBox(
                          width: MyUtility(context).width / 8,
                          child: Text(widget.attendeesList[i]["firstName"],
                              style: TextStyle(fontSize: 14)),
                        ),
                        SizedBox(
                          width: MyUtility(context).width / 8,
                          child: Text(widget.attendeesList[i]["lastName"],
                              style: TextStyle(fontSize: 14)),
                        ),
                        SizedBox(
                          width: MyUtility(context).width / 16,
                          child: Text(
                              widget.attendeesList[i]["peopleAmmount"]
                                  .toString(),
                              style: TextStyle(fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
