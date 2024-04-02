import 'package:flutter/material.dart';
import 'package:sama/components/CompanyContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sama/components/NewsContainer.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/memberBenifits/memberDetailsDialog.dart';

class MemberBenifits extends StatefulWidget {
  const MemberBenifits({super.key});

  @override
  State<MemberBenifits> createState() => _MemberBenifitsState();
}

class _MemberBenifitsState extends State<MemberBenifits> {
  BuildContext? dialogContext;
  //Dialog for benifits
  Future openMemberDetailsDialog(benifitId) => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: MemberDetailsDialog(
                id: benifitId,
                closeDialog: () => Navigator.pop(dialogContext!)));
      });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SAMA Member Benefits',
            style: TextStyle(
                fontSize: 32,
                color: Color(0xFF3D3D3D),
                fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: MyUtility(context).height * 0.05,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('memberBenefits')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: snapshot error');
                }
                if (!snapshot.hasData) {
                  return const Text('Loading...');
                }

                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                if (documents.isEmpty) {
                  return Center(child: Text('No class yet'));
                }

                return Container(
                    width: 500,
                    height: 500,
                    //color: Colors.transparent,
                    child: ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          final DocumentSnapshot document = documents[index];

                          return GestureDetector(
                            onTap: () {
                              openMemberDetailsDialog(document['id']);
                            },
                            child: CompanyContainer(
                                image: document['logo'],
                                companyname: document['companyName'],
                                discription: document['companyDescription']),
                          );
                        }));
              })

          /*  CompanyContainer(
              image: 'images/company.jpg',
              companyname: 'Company name',
              discription: 'Description of company')*/
        ],
      ),
    );
  }
}
