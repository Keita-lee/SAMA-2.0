import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/Events/AdminEvents/UI/EventsHeaderSection.dart';
import 'package:sama/admin/Events/AdminEvents/UI/EventsList.dart';
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
                      color: Colors.transparent,
                      child: NewEvent(
                        id: "",
                        closeDialog: () => Navigator.pop(context!),
                      ),
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
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
                              return Center(child: Text('No Events listed'));
                            }

                            return Container(
                              width: MyUtility(context).width -
                                  (MyUtility(context).width * 0.25),
                              height: 500,
                              child: Table(
                                columnWidths: {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(1),
                                  2: FlexColumnWidth(1),
                                  3: FlexColumnWidth(1),
                                  4: FlexColumnWidth(1),
                                },
                                children: [
                                  TableRow(
                                    children: [
                                      Text('Event Name',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                      Text('Date',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                      Text('Location',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                      Text('Area',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                      Text('Attending',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                    ],
                                  ),
                                  ...documents.map((DocumentSnapshot document) {
                                    return TableRow(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Color(0xFFD1D1D1),
                                          ),
                                        ),
                                      ),
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              barrierColor:
                                                  Colors.black.withOpacity(0.5),
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  insetPadding:
                                                      EdgeInsets.all(10),
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    child: NewEvent(
                                                      id: document['id'],
                                                      closeDialog: () =>
                                                          Navigator.pop(
                                                              context),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Text(document['title'] ??
                                              'N/A'), // Assuming 'title' exists; use 'N/A' if not
                                        ),
                                        Text(document['date'] ??
                                            'N/A'), // Assuming 'date' exists; use 'N/A' if not
                                        Text(document['_location'] ??
                                            'N/A'), // Assuming '_location' exists; use 'N/A' if not
                                        Text(document['_area'] ??
                                            'N/A'), // Assuming '_area' exists; use 'N/A' if not
                                        Text(document['attending']
                                            .length
                                            .toString()), // Assuming 'attending' is a list; convert to string if not
                                      ],
                                    );
                                  }).toList(),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
