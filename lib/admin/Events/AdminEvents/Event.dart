import 'package:flutter/material.dart';
import 'package:sama/admin/Events/AdminEvents/UI/EventsHeaderSection.dart';
import 'package:sama/admin/Events/AdminEvents/UI/UpcommingEvents.dart';
import 'package:sama/components/utility.dart';
import 'package:sama/admin/Events/NewEvent/NewEvent.dart';

class AdminEvents extends StatefulWidget {
  const AdminEvents({Key? key}) : super(key: key);

  @override
  State<AdminEvents> createState() => _AdminEventsState();
}

class _AdminEventsState extends State<AdminEvents> {
  final selectCategory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Events',
            style: TextStyle(
              fontSize: 32,
              color: Color(0xFF3D3D3D),
              fontWeight: FontWeight.normal,
            ),
          ),
          EventsHeaderSection(
            controller: selectCategory,
            openMediaForm: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.5),
                builder: (BuildContext context) {
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: EdgeInsets.all(10),
                    child: Container(
                      color: Colors
                          .transparent, // Ensure content's background is transparent
                      child: NewEvent(),
                    ),
                  );
                },
              );
            },
          ),
          Text(
            'Upcoming',
            style: TextStyle(
              fontSize: 24,
              color: Color(0xFF3D3D3D),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MyUtility(context).height * 0.025,
          ),
          Container(
            width: MyUtility(context).width * 0.8,
            height: MyUtility(context).height * 0.4,
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
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Align(
                alignment: Alignment.topCenter,
                child: UpcommingEvents(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
