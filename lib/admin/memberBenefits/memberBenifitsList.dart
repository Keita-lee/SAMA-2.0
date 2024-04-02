import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/memberBenefits/memberBenifitsDialog.dart';
import 'package:sama/components/styleButton.dart';

class MemberBenefitsList extends StatefulWidget {
  const MemberBenefitsList({super.key});

  @override
  State<MemberBenefitsList> createState() => _MemberBenefitsListState();
}

class _MemberBenefitsListState extends State<MemberBenefitsList> {
  @override
  Widget build(BuildContext context) {
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

    return Column(
      children: [
        Row(
          children: [
            Spacer(),
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
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  onTap: (){openMemberDialog(document['id']);},
                  child: Container(
                  
                    child: Row(children: [
                       Text(
                                document['companyName'],
                                style: TextStyle(fontSize: 18, color: Colors.black),
                       ),
                          Spacer(),
                                
                       
                    ],),
                  ),
                );},),);

        })
     
      ],
    );
  }
}
