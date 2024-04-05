import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/memberBenefits/memberBenifitsDialog.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';

class MemberBenefitsList extends StatefulWidget {
  const MemberBenefitsList({super.key});

  @override
  State<MemberBenefitsList> createState() => _MemberBenefitsListState();
}

class _MemberBenefitsListState extends State<MemberBenefitsList> {


  BuildContext? dialogContext;
  //Dialog for benifits
  Future openMemberDialog(benifitId) => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: MemberBenifitsDialogState(
                id: benifitId,
                closeDialog: () => Navigator.pop(dialogContext!)));
      });

 


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 10,
            ),
            StyleButton(
                description: "Add Benefit",
                height: 55,
                width: 125,
                onTap: () {
                  openMemberDialog("");
                })
          ],
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('memberBenefits')
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
                return Center(child: Text('No class yet'));
              }

              return Container(
                width: MyUtility(context).width -
                    (MyUtility(context).width * 0.25),
                height: 500,
                //color: Colors.transparent,
                child: ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot document = documents[index];
                    return GestureDetector(
                      onTap: () {
                        openMemberDialog(document['id']);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xFF174486),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                document['companyName'],
                                style: TextStyle(
                                    fontSize: 18,
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255)),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            })
      ],
    );
  }
}
