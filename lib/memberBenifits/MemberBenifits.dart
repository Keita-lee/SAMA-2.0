import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/memberBenefits/memberBenifitsDialog.dart';
import 'package:sama/components/CompanyContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sama/centerOfExcellence/ui/NewsContainer.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/memberBenifits/memberDetailsDialog.dart';

class MemberBenifits extends StatefulWidget {
  const MemberBenifits({super.key});

  @override
  State<MemberBenifits> createState() => _MemberBenifitsState();
}

class _MemberBenifitsState extends State<MemberBenifits> {
  String userType = "";

  getUserData() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (data.exists) {
      setState(() {
        userType = data.get('userType');
      });
    }
  }

  BuildContext? dialogContext;
  //Dialog for benifits
  Future openMemberDetailsDialog(benifitId, image) => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: MemberDetailsDialog(
                id: benifitId,
                userType: userType,
                logo: image,
                closeDialog: () => Navigator.pop(dialogContext!)));
      });

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
  void initState() {
    getUserData();
    super.initState();
  }

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
          Visibility(
            visible: userType == "Admin" ? true : false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width:
                      MyUtility(context).width - MyUtility(context).width / 3.7,
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
                    width:
                        MyUtility(context).width - MyUtility(context).width / 4,
                    height: 500,
                    //color: Colors.transparent,
                    child: ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          final DocumentSnapshot document = documents[index];

                          return GestureDetector(
                            onTap: () {
                              openMemberDetailsDialog(
                                  document['id'], document['logo']);
                            },
                            child: CompanyContainer(
                                userType: userType,
                                image: document['logo'],
                                companyname: document['companyName'],
                                discription: document['companyDescription'],
                                editCompanyDetails: () {
                                  openMemberDialog(document['id']);
                                }),
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
