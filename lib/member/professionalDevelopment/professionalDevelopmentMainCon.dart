import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/banner/samaBlueBanner.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/member/professionalDevelopment/CourseInfo.dart';
import 'package:sama/member/professionalDevelopment/professionalDevQuiz.dart';
import 'package:sama/member/professionalDevelopment/ui/courseInfoContainer.dart';
import 'package:sama/member/professionalDevelopment/ui/professionalDevelopmentDisplayItem.dart';
import 'package:sama/member/professionalDevelopment/ui/userCpdList.dart';

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
  bool isLoading = true;
  CourseModel selectedCourse =
      CourseModel(id: '0', imageUrl: '', title: '', cpdPoints: '', level: '');
  List<Map<String, dynamic>> coursesList = [];
  @override
  void initState() {
    _getCourses();
    super.initState();
  }

  Future<void> _getCourses() async {
    try {
      QuerySnapshot<Map<String, dynamic>> coursesSnapshot =
          await _firestore.collection('cpd').get();
      if (coursesSnapshot.docs.isNotEmpty) {
        setState(() {
          coursesList =
              coursesSnapshot.docs.map((course) => course.data()).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('no courses found');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('error getting courses: $e');
    }
  }

  void changePageIndex(int value) {
    setState(() {
      pageIndex = value;
    });
  }

  void setSelectedCourse(CourseModel course) {
    selectedCourse = course;
  }

  void showCourseInfo(CourseModel course) {
    changePageIndex(2);
    setSelectedCourse(course);
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return SizedBox(
      height: isMobile
          ? MyUtility(context).height * 0.7
          : MyUtility(context).height * 2.2,
      child: Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          SamaBlueBanner(pageName: 'PROFESSIONAL DEVELOPMENT'),
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
                  ? MyUtility(context).height * 0.6
                  : MyUtility(context).height * 2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        StyleButton(
                          fontSize: 13,
                          description: 'View All',
                          height: 40,
                          width: 110,
                          buttonTextColor: Colors.white,
                          buttonColor: pageIndex == 0
                              ? const Color.fromRGBO(0, 159, 159, 1)
                              : Colors.grey,
                          onTap: () {
                            changePageIndex(0);
                          },
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        StyleButton(
                          fontSize: 13,
                          description: 'My CPD',
                          height: 40,
                          width: 110,
                          buttonTextColor: Colors.white,
                          buttonColor: pageIndex == 3
                              ? const Color.fromRGBO(0, 159, 159, 1)
                              : Colors.grey,
                          onTap: () {
                            changePageIndex(3);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
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
                      visible: pageIndex == 0 && !isMobile,
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
                                    : MyUtility(context).width / 1.5,
                                height: isMobile
                                    ? MyUtility(context).height * 1.5
                                    : MyUtility(context).height * 2,
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: isMobile ? 1 : 3,
                                      childAspectRatio: isMobile ? 0.9 : 0.8,
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
                                                course: CourseModel(
                                                  id: document['id'],
                                                  imageUrl:
                                                      document['cpdImage'],
                                                  title: document['title'],
                                                  cpdPoints: document[
                                                      'subDescription'],
                                                  level: document[
                                                      'subDescription'],
                                                ),
                                              ),
                                            )
                                          ]);
                                    }));
                          }),
                    ),
                    Visibility(
                        visible: pageIndex == 0 && isMobile,
                        child: Column(
                          children: [
                            ...coursesList.map((course) {
                              return professionalDevelopmentDisplayItem(
                                onPressed: showCourseInfo,
                                imageUrl: course['cpdImage'],
                                title: course['title'],
                                cpdPoints: "3.0 Clinical Point",
                                level: "Level 2",
                                subDescription: course['subDescription'],
                                course: CourseModel(
                                  id: course['id'],
                                  imageUrl: course['cpdImage'],
                                  title: course['title'],
                                  cpdPoints: course['subDescription'],
                                  level: course['subDescription'],
                                ),
                              );
                            }).toList(),
                          ],
                        )),
                    Visibility(
                        visible: pageIndex == 1,
                        child: ProfessionalDevQuiz(
                          hasPassed: false,
                          isResultsScreen: false,
                          course: selectedCourse,
                          isQuizInProgress: false,
                        )),
                    Visibility(
                      visible: pageIndex == 2,
                      child: CourseInfo(
                        course: CourseModel(
                          id: selectedCourse.id,
                          imageUrl: selectedCourse.imageUrl,
                          title: selectedCourse.title,
                          cpdPoints: selectedCourse.cpdPoints,
                          level: selectedCourse.level,
                        ),
                        userType: 'nonMember',
                        isAccessed: false,
                      ),
                    ),
                    Visibility(visible: pageIndex == 3, child: UserCpdList()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/*

 final String id;
  final String imageUrl;
  final String title;
  final String cpdPoints;
  final String level;

 */