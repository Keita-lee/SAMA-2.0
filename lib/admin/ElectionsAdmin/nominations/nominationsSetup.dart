import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/NominationHeader.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/nominationForm.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/previewElection/sections/previewNominations.dart';
import 'package:sama/components/myutility.dart';

class NominationSetup extends StatefulWidget {
  const NominationSetup({super.key});

  @override
  State<NominationSetup> createState() => _NominationSetupState();
}

class _NominationSetupState extends State<NominationSetup> {
  // Text controllers
  final selectBranch = TextEditingController();

  //get value of branch
  getBranchValue(value) {
    setState(() {
      selectBranch.text = value;
    });
  }

  //Open dialog for media
  Future openNominationForm(id) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: NominationFrom(
          id: id,
          closeDialog: () => Navigator.pop(context),
        ));
      });

//Get amount of days between dates
  getDaysAmount(date1, date2) {
    if (date1 != "" && date2 != "") {
      DateTime d1 = DateTime.parse(date1);
      DateTime d2 = DateTime.parse(date2);

      return "${d2.difference(d1).inDays} days";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Nominations & Elections',
        style: TextStyle(
            fontSize: 32,
            color: Color(0xFF3D3D3D),
            fontWeight: FontWeight.normal),
      ),
      SizedBox(
        height: 25,
      ),
      NominationHeader(
        controller: selectBranch,
        openNominationForm: openNominationForm,
      ),
      SizedBox(
        height: 25,
      ),
      Row(
        children: [
          SizedBox(
            width: 15,
          ),
          SizedBox(
            width: MyUtility(context).width / 8,
            child: Text('Status',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          SizedBox(
            width: MyUtility(context).width / 5,
            child: Text('Branch',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          SizedBox(
            width: MyUtility(context).width / 10,
            child: Text('Count',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          SizedBox(
            width: MyUtility(context).width / 8,
            child: Text('Nominations',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          SizedBox(
            width: MyUtility(context).width / 8,
            child: Text('Collections',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          SizedBox(
            width: MyUtility(context).width / 10,
            child: Text('Elections',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
        ],
      ),
      SizedBox(
        height: 25,
      ),
      StreamBuilder<QuerySnapshot>(
          stream: selectBranch.text == ""
              ? FirebaseFirestore.instance.collection('elections').snapshots()
              : FirebaseFirestore.instance
                  .collection('elections')
                  .where('selectBranch', isEqualTo: selectBranch.text)
                  .snapshots(),
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
              color: Colors.transparent,
              width:
                  MyUtility(context).width - (MyUtility(context).width * 0.18),
              height: 550,
              child: ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot document = documents[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          openNominationForm(document['id']);
                        },
                        child: Container(
                          width: MyUtility(context).width,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Color(0xFFD1D1D1),
                              )),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              SizedBox(
                                width: MyUtility(context).width / 8,
                                child: Text(
                                  document['status'] != "Complete"
                                      ? "InComplete"
                                      : "Complete",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF3D3D3D),
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              SizedBox(
                                width: MyUtility(context).width / 5,
                                child: Text(
                                  document['selectBranch'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF3D3D3D),
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              SizedBox(
                                width: MyUtility(context).width / 14,
                                child: Text(
                                  document['count'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF3D3D3D),
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              SizedBox(
                                  width: MyUtility(context).width / 8,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        document['nominateStartDate'],
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF3D3D3D),
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        document['nominateEndDate'],
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF3D3D3D),
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        getDaysAmount(
                                            document['nominateStartDate'],
                                            document['nominateEndDate']),
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF3D3D3D),
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                  width: MyUtility(context).width / 8,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        document['nominateAcceptStartDate'],
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF3D3D3D),
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        document['nominateAcceptEndDate'],
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF3D3D3D),
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        getDaysAmount(
                                            document['nominateAcceptStartDate'],
                                            document['nominateAcceptEndDate']),
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF3D3D3D),
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                  width: MyUtility(context).width / 8,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        document['electionDateStart'],
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF3D3D3D),
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        document['electionDateEnd'],
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF3D3D3D),
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        getDaysAmount(
                                            document['electionDateStart'],
                                            document['electionDateEnd']),
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF3D3D3D),
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }),
    ]));
  }
}
