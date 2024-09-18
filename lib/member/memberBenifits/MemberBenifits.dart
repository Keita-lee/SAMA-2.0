import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/memberBenefits/memberBenifitsDialog.dart';
import 'package:sama/components/CompanyContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sama/member/centerOfExcellence/ui/NewsContainer.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/member/memberBenifits/memberDetailsDialog.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

import '../../components/banner/samaBlueBanner.dart';

class MemberBenifits extends StatefulWidget {
  const MemberBenifits({super.key});

  @override
  State<MemberBenifits> createState() => _MemberBenifitsState();
}

class _MemberBenifitsState extends State<MemberBenifits> {
  final ScrollController _scrollController = ScrollController();
  String userType = "";
  var pageIndex = 0;
  var benefitsId = '';

  var logoImage = '';

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

  opMemberDetails(id, image) {
    setState(() {
      logoImage = image;
      benefitsId = id;
      pageIndex = 1;
    });
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
    bool isMobile = MyUtility(context).width < 600 ? true : false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SamaBlueBanner(
          pageName: 'MEMBER BENEFITS',
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: isMobile
              ? EdgeInsets.all(0)
              : EdgeInsets.symmetric(horizontal: 50),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Visibility(
                  visible: userType == "Admin" ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MyUtility(context).width -
                              MyUtility(context).width / 3,
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
                ),
                Visibility(
                  visible: pageIndex == 0,
                  child: StreamBuilder<QuerySnapshot>(
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

                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;
                        if (documents.isEmpty) {
                          return Center(child: Text('No class yet'));
                        }

                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            width: isMobile
                                ? MyUtility(context).width
                                : MyUtility(context).width * 0.55,
                            height: isMobile
                                ? MyUtility(context).width < 400
                                    ? MyUtility(context).height / 1.6
                                    : MyUtility(context).height / 1.7
                                : MyUtility(context).height / 1.8,
                            //color: Colors.transparent,
                            /* child: DraggableScrollbar.rrect(
                            alwaysVisibleScrollThumb: true,
                            backgroundColor: Color.fromARGB(255, 8, 55, 145),
                            controller: _scrollController,
                            padding: EdgeInsets.zero,*/
                            child: ListView.builder(
                                controller: _scrollController,
                                itemCount: documents.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final DocumentSnapshot document =
                                      documents[index];

                                  return InkWell(
                                    onTap: () {
                                      opMemberDetails(
                                          document['id'], document['logo']);
                                      /*openMemberDetailsDialog(
                                        document['id'], document['logo']);*/
                                    },
                                    child: CompanyContainer(
                                      userType: userType,
                                      image: document['logo'],
                                      companyname: document['companyName'],
                                      discription:
                                          document['companyDescription'],
                                      editCompanyDetails: () {
                                        openMemberDialog(document['id']);
                                      },
                                      openMemberDetails: () {
                                        opMemberDetails(
                                            document['id'], document['logo']);
                                        /*openMemberDetailsDialog(
                                          document['id'], document['logo']);*/
                                      },
                                    ),
                                  );
                                }),
                          ),
                        );
                      }),
                ),
                Visibility(
                    visible: pageIndex == 1,
                    child: MemberDetailsDialog(
                        id: benefitsId,
                        userType: userType,
                        logo: logoImage,
                        closeDialog: () {
                          setState(() {
                            pageIndex = 0;
                          });
                        }))

                /*  CompanyContainer(
                  image: 'images/company.jpg',
                  companyname: 'Company name',
                  discription: 'Description of company')*/
              ],
            ),
          ),
        )
      ],
    );
  }
}
