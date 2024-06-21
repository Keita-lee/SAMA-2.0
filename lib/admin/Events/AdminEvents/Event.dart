import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/Events/AdminEvents/UI/EventsHeaderSection.dart';
import 'package:sama/admin/Events/NewEvent/NewEvent.dart';
import 'package:sama/components/utility.dart';

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
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(3),
                                2: FlexColumnWidth(2),
                                3: FlexColumnWidth(2),
                                4: FlexColumnWidth(2),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    Text('State',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    Text('Title',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    Text('Category',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    Text('Publish Date',
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
                                        child: GestureDetector(
                                          onTap: () {
                                            if (data != null) {
                                              bool currentState =
                                                  data['state'] ?? false;
                                              FirebaseFirestore.instance
                                                  .collection('events')
                                                  .doc(document.id)
                                                  .update(
                                                      {'state': !currentState});
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 60),
                                            child: Container(
                                              width: 50,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                color: (data != null &&
                                                        data['state'] == true)
                                                    ? Colors.blue
                                                    : Colors.grey,
                                              ),
                                              child: Align(
                                                alignment: (data != null &&
                                                        data['state'] == true)
                                                    ? Alignment.centerRight
                                                    : Alignment.centerLeft,
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  margin: EdgeInsets.all(5.0),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
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
                                                  data.containsKey('category')
                                              ? data['category']
                                              : 'N/A',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          data != null &&
                                                  data.containsKey(
                                                      'publish_date')
                                              ? data['publish_date']
                                              : 'N/A',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                // View action
                                              },
                                              child: Text('View',
                                                  style: TextStyle(
                                                      color: Colors.blue)),
                                            ),
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
                                                      color: Colors.blue)),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                // Delete action
                                              },
                                              child: Text('Delete',
                                                  style: TextStyle(
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
    );
  }
}
