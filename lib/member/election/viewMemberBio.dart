import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/profile/Tables/VolunteerWorkTable.dart';

import '../../components/MyDivider.dart';
import '../../profile/Tables/PublishedArticlesTable.dart';
import '../../profile/Tables/workExperience.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewMemberBio extends StatefulWidget {
  String memberId;
  Function closeDialog;
  ViewMemberBio({super.key, required this.closeDialog, required this.memberId});

  @override
  State<ViewMemberBio> createState() => _ViewMemberBioState();
}

class _ViewMemberBioState extends State<ViewMemberBio> {
  //var
  String dateExists = "";
  String memberName = "";
  String profileImage = "";
  //TextEditing Controller
  final dob = TextEditingController();
  final maritalStatus = TextEditingController();
// Work Experience
  List workExperience = [];
//Qualification
  final qualification = TextEditingController();
//Articles
  List articles = [];

//volunteer

  List volunteerWork = [];

  //QA
  final positionAtSama = TextEditingController();
  final skillToSama = TextEditingController();

  //Organization

  List organizations = [];

  final position = TextEditingController();
  final leaderShipMotivation = TextEditingController();

  //var
  var cv = "";
  bool pendingDiscipline = false;
  bool disciplineAction = false;
  bool civilJudgement = false;
  bool positionRemoved = false;
  bool chargedCrime = false;

// get member selected Bio date
  getBioData() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.memberId)
        .get();

    if (data.exists) {
      if (data.get("bio") == null) {
        print("q");
      } else {
        print("t");

        setState(() {
          profileImage = data.get('profilePic');
          memberName = "${data.get('firstName')} ${data.get('lastName')}";
          cv = data.get('bio.cv');
          articles = data.get('bio.articles');
          chargedCrime = data.get('bio.chargedCrime');
          civilJudgement = data.get('bio.civilJudgement');
          dob.text = data.get('bio.dob');
          maritalStatus.text = data.get('bio.maritalStatus');
          pendingDiscipline = data.get('bio.pendingDiscipline');
          positionRemoved = data.get('bio.positionRemoved');
          qualification.text = data.get('bio.qualifications');
          volunteerWork = data.get('bio.volunteerWork');
          workExperience = data.get('bio.workExperience');
          organizations = data.get('bio.organizations'); /**/
        });
      } /**/
/*      if (data.get('bio.cv')) { } else {
        setState(() {
          dateExists = "Not True";
        });
      }*/
    } else {
      print("Nope");
    }
  }

  downloadCv() {
    final Uri urlMonth = Uri(
      scheme: 'https',
      host: "",
      path: 'paystack.com/pay/ebakeMonth',
    );

    final Uri a = Uri.parse(cv);

    launchUrl(a);
  }

  @override
  void initState() {
    getBioData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width * 0.8,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Color(0xFFD1D1D1),
          )),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
                visible: dob.text == "" ? true : false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            memberName,
                            style: GoogleFonts.openSans(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF174486),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              widget.closeDialog();
                            },
                            icon: Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "No Bio Available",
                      style: GoogleFonts.openSans(
                          fontSize: 18, height: 1, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 25,
                    )
                  ],
                )),
            Visibility(
              visible: dob.text != "" ? true : false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          memberName,
                          style: GoogleFonts.openSans(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF174486),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            widget.closeDialog();
                          },
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ImageNetwork(
                            fitWeb: BoxFitWeb.contain,
                            image: profileImage,
                            width: MyUtility(context).width / 5,
                            height: MyUtility(context).height / 5,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Date of Birth:    ",
                                  style: GoogleFonts.openSans(
                                      fontSize: 18,
                                      height: 1,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  dob.text,
                                  style: GoogleFonts.openSans(
                                    fontSize: 18,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Marital Status:    ",
                                  style: GoogleFonts.openSans(
                                      fontSize: 18,
                                      height: 1,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  maritalStatus.text,
                                  style: GoogleFonts.openSans(
                                    fontSize: 18,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Qualifications:    ",
                                  style: GoogleFonts.openSans(
                                      fontSize: 18,
                                      height: 1,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  qualification.text,
                                  style: GoogleFonts.openSans(
                                      fontSize: 18,
                                      height: 1,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF174486),
                            ),
                            child: TextButton(
                              onPressed: () {
                                downloadCv();
                              },
                              child: Text(
                                'Download Cv',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  MyDidiver(),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Work Experience",
                    style: GoogleFonts.openSans(
                        fontSize: 18, height: 1, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  WorkExperience(
                      workExperienceList: workExperience,
                      removeExperience: (int) {},
                      memberView: "true"),
                  SizedBox(
                    height: 15,
                  ),
                  MyDidiver(),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Published Articles",
                    style: GoogleFonts.openSans(
                        fontSize: 18, height: 1, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  PublishedArticlesTable(
                    removeArticle: (int) {},
                    articlesList: articles,
                    memberView: "true",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  MyDidiver(),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Volunteer Work",
                    style: GoogleFonts.openSans(
                        fontSize: 18, height: 1, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  VolunteerWorkTable(
                    volunteerWork: volunteerWork,
                    removeVolunteerWork: (int) {},
                    memberView: "true",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
