import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/Events/AdminEvents/UI/EventsHeaderSection.dart';
import 'package:sama/admin/Events/NewEvent/NewEvent.dart';
import 'package:sama/components/banner/samaBlueBanner.dart';
import 'package:sama/components/utility.dart';
import 'package:sama/components/yesNoDialog.dart';

import '../NewEvent/NewEventComp/eventAttendees.dart';

class AdminEvents extends StatefulWidget {
  const AdminEvents({Key? key}) : super(key: key);

  @override
  State<AdminEvents> createState() => _AdminEventsState();
}

class _AdminEventsState extends State<AdminEvents> {
  final selectCategory = TextEditingController();

  //Remove member from db
  removeEvents(id) {
    FirebaseFirestore.instance.collection('events').doc(id).delete();
  }

  //Dialog to Remove Item
  Future removeEventsPopup(id) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: YesNoDialog(
          description: "Are you sure you want to remove this item",
          closeDialog: () => Navigator.pop(context!),
          callFunction: () {
            removeEvents(id);
          },
        ));
      });
//Popup view atten
  Future openViewEventAtt(attending) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: EventAttendees(
          attendeesList: attending,
          closeDialog: () => Navigator.pop(context!),
        ));
      });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SamaBlueBanner(pageName: 'EVENTS'),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 25),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
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
                              closeDialog: () => Navigator.pop(context),
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
                  color: Colors.white,
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
                                  return Text('Error: ${snapshot.error}');
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
                                      0: FlexColumnWidth(3),
                                      1: FlexColumnWidth(1.5),
                                      2: FlexColumnWidth(1.5),
                                      3: FlexColumnWidth(1.5),
                                      4: FlexColumnWidth(2),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          Text('Title',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          Text('Type',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          Text('From',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          Text('To',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          Text('Actions',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                        ],
                                      ),
                                      ...documents.map((DocumentSnapshot document) {
                                        Map<String, dynamic>? data =
                                            document.data() as Map<String, dynamic>?;
                                        bool isEven =
                                            documents.indexOf(document) % 2 == 0;
                                        return TableRow(
                                          decoration: BoxDecoration(
                                            color: isEven
                                                ? Colors.transparent
                                                : Colors.grey[200],
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Color(0xFFD1D1D1),
                                              ),
                                            ),
                                          ),
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                data != null &&
                                                        data.containsKey('title')
                                                    ? data['title']
                                                    : 'N/A',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                data != null &&
                                                        data.containsKey('_event')
                                                    ? data['_event']
                                                    : 'N/A',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                data != null &&
                                                        data.containsKey('date')
                                                    ? data['date']
                                                    : 'N/A',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                data != null &&
                                                        data.containsKey('endDate')
                                                    ? data['endDate']
                                                    : 'N/A',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      // Edit action
                                                      showDialog(
                                                        context: context,
                                                        barrierDismissible: true,
                                                        barrierColor: Colors.black
                                                            .withOpacity(0.5),
                                                        builder:
                                                            (BuildContext context) {
                                                          return Dialog(
                                                            backgroundColor:
                                                                Colors.transparent,
                                                            insetPadding:
                                                                EdgeInsets.all(10),
                                                            child: Container(
                                                              color:
                                                                  Colors.transparent,
                                                              child: NewEvent(
                                                                id: document.id,
                                                                closeDialog: () =>
                                                                    Navigator.pop(
                                                                        context),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Text('Edit',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.blue)),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      openViewEventAtt(
                                                          data!['attending']);
                                                    },
                                                    child: Text('Attendees',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.blue)),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      removeEventsPopup(data!['id']);
                                                    },
                                                    child: Text('Delete',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.blue)),
                                                  ),
                                                ],
                                              ),
                                            ),
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
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
