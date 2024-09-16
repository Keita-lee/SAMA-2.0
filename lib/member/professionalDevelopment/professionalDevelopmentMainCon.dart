import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/banner/samaBlueBanner.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/member/professionalDevelopment/CourseInfo.dart';
import 'package:sama/member/professionalDevelopment/professionalDevQuiz.dart';
import 'package:sama/member/professionalDevelopment/ui/professionalDevelopmentDisplayItem.dart';

class professionalDevelopmentMainCon extends StatefulWidget {
  final String userType;
  professionalDevelopmentMainCon({super.key, required this.userType});

  @override
  State<professionalDevelopmentMainCon> createState() =>
      _professionalDevelopmentMainConState();
}

class CourseModel {
  final String id;
  final String imageUrl;
  final String title;
  final String cpdPoints;
  final String level;

  CourseModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.cpdPoints,
    required this.level,
  });
}

class _professionalDevelopmentMainConState
    extends State<professionalDevelopmentMainCon> {
  final _firestore = FirebaseFirestore.instance;
  int pageIndex = 0;
  CourseModel selectedCourse =
      CourseModel(id: '0', imageUrl: '', title: '', cpdPoints: '', level: '');

  @override
  void initState() {
    _getCourses();
    super.initState();
  }

  Future<void> _getCourses() async {}

  void changePageIndex(int value) {
    setState(() {
      pageIndex = value;
    });
  }

  void setSelectedCourse(CourseModel course) {
    selectedCourse = course;
  }

  void showCourseInfo(CourseModel course) {
    changePageIndex(1);
    setSelectedCourse(course);
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return SizedBox(
      height: isMobile ? MyUtility(context).height : MyUtility(context).height,
      child: Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          const SamaBlueBanner(pageName: 'PROFESSIONAL DEVELOPMENT'),
          Padding(
            padding: isMobile
                ? EdgeInsets.all(8)
                : EdgeInsets.only(
                    top: 30,
                    left: 80,
                  ),
            child: SizedBox(
              width: isMobile
                  ? MyUtility(context).width
                  : MyUtility(context).width * 0.68,
              height: isMobile
                  ? MyUtility(context).height / 1.5
                  : MyUtility(context).height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyleButton(
                            fontSize: 13,
                            description: 'View All',
                            height: 40,
                            width: 110,
                            buttonTextColor: Colors.white,
                            buttonColor: Color.fromRGBO(0, 159, 159, 1),
                            onTap: () {
                              () {};
                            }),
                        const SizedBox(
                          width: 15,
                        ),
                        StyleButton(
                          fontSize: 13,
                          description: 'My CPD',
                          height: 40,
                          width: 110,
                          buttonTextColor: Colors.white,
                          buttonColor: Color.fromRGBO(200, 200, 200, 1),
                          onTap: () {
                            () {};
                          },
                        ),
                      ],
                    ),*/
                    const SizedBox(height: 30),
                    Visibility(
                      visible: pageIndex == 0,
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'CPD Compliance',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 159, 158, 1),
                              ),
                            ),
                            Text(
                              'Continuing Professional Development (CPD) is essential for healthcare professionals in South Africa to comply with HPCSA guidelines. Professionals must earn 60 CEUs within 24 months, including specific points for ethics. The SA Medical Association (SAMA) is accredited to review and approve CPD activities, with recent updates streamlining the tracking of CPD points automatically to HPCSA profiles. SAMA offers tools for both local and international members to manage their CPD compliance effectively, ensuring they maintain the necessary qualifications and professional integrity. Free for members.',
                              style: GoogleFonts.openSans(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*  */
                    const SizedBox(height: 20),
                    Visibility(
                      visible: pageIndex == 0,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('cpd')
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
                              return Center(child: Text('No cpd yet'));
                            }

                            return Container(
                                width: isMobile
                                    ? MyUtility(context).width
                                    : MyUtility(context).width / 1.6,
                                height: isMobile
                                    ? MyUtility(context).height
                                    : MyUtility(context).height / 1.5,
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: isMobile ? 1 : 3,
                                      childAspectRatio: isMobile ? 0.2 : 0.88,
                                    ),
                                    itemCount: documents.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final DocumentSnapshot document =
                                          documents[index];
                                      return Wrap(
                                          direction: Axis.horizontal,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child:
                                                  professionalDevelopmentDisplayItem(
                                                onPressed: showCourseInfo,
                                                imageUrl: document['cpdImage'],
                                                title: document['title'],
                                                cpdPoints: "3.0 Clinical Point",
                                                level: "Level 2",
                                                subDescription:
                                                    document['subDescription'],
                                              ),
                                            )
                                          ]);
                                    }));
                          }),
                    ),
                    Visibility(
                        visible: pageIndex == 1,
                        child: ProfessionalDevQuiz(
                          hasPassed: false,
                          isResultsScreen: true,
                          course: selectedCourse,
                          isQuizInProgress: false,
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
