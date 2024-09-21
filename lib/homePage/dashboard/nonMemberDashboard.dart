import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/mobile/Navbar/login_button.dart';
import 'package:sama/components/mobile/Navbar/register_button.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/homePage/dashboard/ui/onHoverButtons.dart';
import 'package:sama/login/loginPages.dart';

import '../../components/myutility.dart';

class NonMemberDashboard extends StatefulWidget {
  final bool? visible; // Changed to nullable
  final String? userType; // Changed to nullable
  const NonMemberDashboard(
      {super.key, this.visible, this.userType}); // Updated constructor

  @override
  State<NonMemberDashboard> createState() => _NonMemberDashboardState();
}

class _NonMemberDashboardState extends State<NonMemberDashboard> {
  bool isHoverd = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;

    if (isMobile) {
      return Material(
        color: Colors.white,
        child: Container(
          width: MyUtility(context).width,
          // height: MyUtility(context).height / 1.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(
                  color: Color.fromARGB(255, 212, 210, 210), width: 1.5)),
          child: Column(children: [
            SizedBox(
              width: MyUtility(context).width - 50,
              height: MyUtility(context).height / 1.55,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to our all-encompassing medical portal',
                        style: TextStyle(
                            fontSize: MyUtility(context).width < 400 ? 18 : 20,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      Text(
                        'Designed to cater to the diverse needs of healthcare professionals at every stage of their careers. Whether you’re a student, intern, community service doctor, or an experienced practitioner, our platform offers a wealth of resources and support tailored just for you.',
                        style: TextStyle(
                            fontSize: MyUtility(context).width < 400 ? 14 : 16,
                            color: const Color.fromARGB(255, 116, 116, 116),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'By signing up, you’ll gain exclusive access to a comprehensive library of educational materials, expert articles, and best practices to enhance your knowledge and skills. Our portal also provides a unique opportunity to connect with a vibrant community of peers and mentors, offering invaluable networking and collaboration opportunities.',
                        style: TextStyle(
                            fontSize: MyUtility(context).width < 400 ? 14 : 16,
                            color: const Color.fromARGB(255, 116, 116, 116),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'For those who are just exploring, we invite you to browse our selection of free resources, including insightful articles and introductory guides that provide a glimpse into the rich content available to our members. Don’t miss out on the full range of benefits our platform has to offer. Join us today and elevate your career in the medical field with the support and expertise you need to succeed.',
                        style: TextStyle(
                            fontSize: MyUtility(context).width < 400 ? 14 : 16,
                            color: const Color.fromARGB(255, 116, 116, 116),
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      //  Login Button
                      Row(
                        children: [
                          Visibility(
                            visible: true, // Changed to always visible
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: LoginButton(
                                  onPressed: () => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Material(
                                                      child: LoginPages(
                                                        pageIndex: 0,
                                                      ),
                                                    )))
                                      }),
                            ),
                          ),
                          Spacer(),
                          // Register Button
                          Visibility(
                            visible: true, // Changed to always visible
                            child: RegisterButton(
                                onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Material(
                                                    child: LoginPages(
                                                      pageIndex: 9,
                                                    ),
                                                  )))
                                    }),
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Spacer(),
                      //     InkWell(
                      //       onTap: () {},
                      //       child: MouseRegion(
                      //         onEnter: (event) {
                      //           setState(() {
                      //             isHoverd = true;
                      //           });
                      //         },
                      //         onExit: (event) {
                      //           setState(() {
                      //             isHoverd = false;
                      //           });
                      //         },
                      //         child: ElevatedButton(
                      //           style: ElevatedButton.styleFrom(
                      //             backgroundColor: isHoverd
                      //                 ? Color.fromRGBO(19, 43, 81, 1)
                      //                 : Color(0xFF174486),
                      //             shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(5),
                      //             ),
                      //           ),
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Text(
                      //               'BECOME A MEMBER',
                      //               style: const TextStyle(
                      //                 color: Colors.white,
                      //                 fontSize: 13,
                      //               ),
                      //             ),
                      //           ),
                      //           onPressed: () {
                      //             Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                     builder: (context) => Material(
                      //                           child: LoginPages(
                      //                             pageIndex: 9,
                      //                           ),
                      //                         )));
                      //           },
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MyUtility(context).width,
              height: 35,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                image: DecorationImage(
                  image: AssetImage('images/bannerBackground.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ]),
        ),
      );
    } else {
      return Container(
        width: MyUtility(context).width < 1600
            ? MyUtility(context).width * 0.75
            : MyUtility(context).width * 0.55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
                color: Color.fromARGB(255, 212, 210, 210), width: 1.5)),
        child: Column(children: [
          SizedBox(
            height: 15,
          ),
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: MyUtility(context).width / 8,
                        height: MyUtility(context).height / 6.5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('images/sama_logo.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: MyUtility(context).width < 1600
                        ? MyUtility(context).width * 0.57
                        : MyUtility(context).width * 0.37,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to our all-encompassing medical portal',
                          style: TextStyle(
                              fontSize: MyUtility(context).width < 400
                                  ? 18
                                  : 20, // Adjusted font size based on screen width
                              color: Colors.teal,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Designed to cater to the diverse needs of healthcare professionals at every stage of their careers. Whether you’re a student, intern, community service doctor, or an experienced practitioner, our platform offers a wealth of resources and support tailored just for you.',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 116, 116, 116),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'By signing up, you’ll gain exclusive access to a comprehensive library of educational materials, expert articles, and best practices to enhance your knowledge and skills. Our portal also provides a unique opportunity to connect with a vibrant community of peers and mentors, offering invaluable networking and collaboration opportunities.',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 116, 116, 116),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'For those who are just exploring, we invite you to browse our selection of free resources, including insightful articles and introductory guides that provide a glimpse into the rich content available to our members. Don’t miss out on the full range of benefits our platform has to offer. Join us today and elevate your career in the medical field with the support and expertise you need to succeed.',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 116, 116, 116),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            InkWell(
                              onTap: () {},
                              child: MouseRegion(
                                onEnter: (event) {
                                  setState(() {
                                    isHoverd = true;
                                  });
                                },
                                onExit: (event) {
                                  setState(() {
                                    isHoverd = false;
                                  });
                                },
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isHoverd
                                        ? Color.fromRGBO(19, 43, 81, 1)
                                        : Color(0xFF174486),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'BECOME A MEMBER',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Material(
                                                  child: LoginPages(
                                                    pageIndex: 9,
                                                  ),
                                                )));
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 15,
          ),
          Container(
            width: MyUtility(context).width * 0.80,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              image: DecorationImage(
                image: AssetImage('images/bannerBackground.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ]),
      );
    }
  }
}
