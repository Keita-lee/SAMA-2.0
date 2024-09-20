import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/admin/centerOfExcellence/CenterOfExcellenceDialog.dart';
import 'package:sama/components/banner/samaBlueBanner.dart';
import 'package:sama/member/centerOfExcellence/ui/NewsContainer.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';

class CenterOfExcellence extends StatefulWidget {
  Function(int?)? changePage;
  Function(String?, String?)? getArticleId;
  CenterOfExcellence(
      {super.key, required this.changePage, required this.getArticleId});

  @override
  State<CenterOfExcellence> createState() => _CenterOfExcellenceState();
}

class _CenterOfExcellenceState extends State<CenterOfExcellence> {
  List allArticles = [];
  String userType = "";

  BuildContext? dialogContext;

  getAllArticles() async {
    setState(() {});
    allArticles.clear();
    final data = await FirebaseFirestore.instance.collection('articles').get();
    setState(() {
      for (var i = 0; i < data.docs.length; i++) {
        allArticles.add(data.docs[i]);
      }
    });
  }

  //Dialog for benifits
  Future openArticleDialog(id) => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: CenterOfExcellenceDialog(
          id: id,
          closeDialog: () => Navigator.pop(dialogContext!),
          getAllArticles: getAllArticles,
        ));
      });

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

  @override
  void initState() {
    getAllArticles();
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return Material(
      color: Colors.white,
      child: Container(
        height: isMobile
            ? MyUtility(context).height / 1.4
            : MyUtility(context).height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SamaBlueBanner(pageName: 'CENTRE OF EXCELLENCE'),
              SizedBox(
                height: 30,
              ),
              Visibility(
                visible: userType != "Admin" ? true : false,
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: isMobile ? 16 : 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Coming Soon !',
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: isMobile
                              ? MyUtility(context).width
                              : MyUtility(context).width / 1.5,
                          child: Align(
                            child: Text(
                              'We are excited to announce the upcoming launch of the Centre of Excellence, your future premier resource for expert insights and practical advice from leading doctors in the medical field. Our platform will soon offer a collection of articles penned by experienced professionals, sharing their knowledge and best practices to help you excel in your career. Stay tuned for clinical guidance, professional development tips, and cutting-edge research that will make our Centre of Excellence your go-to destination for invaluable expertise and inspiration.',
                              textAlign:
                                  TextAlign.center, // Center aligns the text
                              style: GoogleFonts.openSans(
                                fontSize:
                                    MyUtility(context).width < 400 ? 14 : 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Wrap(
                          children: [
                            Align(
                              child: Text(
                                'To be a contributor, please contact ',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.openSans(
                                    fontSize: MyUtility(context).width < 400
                                        ? 14
                                        : 16),
                              ),
                            ),
                            Align(
                              child: Text(
                                'online@samedical.org',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.openSans(
                                    fontSize: MyUtility(context).width < 400
                                        ? 14
                                        : 16,
                                    color: Colors
                                        .teal), // Moved color parameter inside GoogleFonts.openSans
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
              Visibility(
                visible: userType == "Admin" ? true : false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    width: MyUtility(context).width / 1.5,
                    child: Text(
                      'Welcome to the Centre of Excellence, your premier resource for expert insights and practical advice from leading doctors in the medical field. Here, you\'ll find a collection of articles written by experienced professionals, sharing their knowledge and best practices to help you excel in your career. Whether you\'re seeking clinical guidance, professional development tips, or cutting-edge research, our Centre of Excellence is your go-to destination for invaluable expertise and inspiration.',
                      style: GoogleFonts.openSans(
                          fontSize: MyUtility(context).width < 400 ? 14 : 16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Visibility(
                  visible: userType == "Admin" ? true : false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: MyUtility(context).width -
                            MyUtility(context).width / 3.5,
                      ),
                      StyleButton(
                          description: "Add Article",
                          height: 55,
                          width: 125,
                          onTap: () {
                            openArticleDialog("");
                          })
                    ],
                  )),
              Visibility(
                visible: userType == "Admin" ? true : false,
                child: Padding(
                  padding: isMobile
                      ? EdgeInsets.all(0)
                      : const EdgeInsets.only(left: 35),
                  child: Container(
                    width: isMobile
                        ? MyUtility(context).width
                        : MyUtility(context).width -
                            (MyUtility(context).width * 0.25),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children: [
                        for (var i = 0; i < allArticles.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: NewsContainer(
                                openArticleDialog: openArticleDialog,
                                articleId: allArticles[i]['id'],
                                userType: userType,
                                image: allArticles[i]['image'],
                                category: allArticles[i]['category'],
                                date: allArticles[i]['date'],
                                header: allArticles[i]['title'],
                                onPressed: () {
                                  setState(() {
                                    widget.getArticleId!(allArticles[i]['id'],
                                        allArticles[i]['image']);
                                  });

                                  widget.changePage!(6);
                                },
                                onArticleEdit: () {
                                  openArticleDialog(allArticles[i]['id']);
                                }),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MyUtility(context).height * 0.03,
              )
            ],
          ),
        ),
      ),
    );
  }
}
