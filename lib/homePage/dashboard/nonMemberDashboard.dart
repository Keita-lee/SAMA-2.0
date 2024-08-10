import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/styleButton.dart';

import '../../components/myutility.dart';

class NonMemberDashboard extends StatefulWidget {
  const NonMemberDashboard({super.key});

  @override
  State<NonMemberDashboard> createState() => _NonMemberDashboardState();
}

class _NonMemberDashboardState extends State<NonMemberDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width * 0.80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
              color: Color.fromARGB(255, 212, 210, 210), width: 1.5)),
      child: Column(children: [
        Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: MyUtility(context).width / 5,
                      height: MyUtility(context).height / 3.5,
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
                  width: MyUtility(context).width * 0.50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to our all-encompassing medical portal',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Designed to cater to the diverse needs of healthcare professionals at every stage of their careers. Whether youre a student, intern, community service doctor, or an experienced practitioner, our platform offers a wealth of resources and support tailored just for you.',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 116, 116, 116),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'By signing up, youll gain exclusive access to a comprehensive library of educational materials, expert articles, and best practices to enhance your knowledge and skills. Our portal also provides a unique opportunity to connect with a vibrant community of peers and mentors, offering invaluable networking and collaboration opportunities.',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 116, 116, 116),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'For those who are just exploring, we invite you to browse our selection of free resources, including insightful articles and introductory guides that provide a glimpse into the rich content available to our members. Dont miss out on the full range of benefits our platform has to offer. Join us today and elevate your career in the medical field with the support and expertise you need to succeed.',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 116, 116, 116),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MyUtility(context).width * 0.35,
                          ),
                          StyleButton(
                              description: "BECOME A MEMBER",
                              height: 50,
                              width: 180,
                              onTap: () {})
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
