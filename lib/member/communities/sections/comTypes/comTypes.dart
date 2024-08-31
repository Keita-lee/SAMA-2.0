import 'package:flutter/material.dart';

import 'ui/comTypeStyle.dart';

class ComTypes extends StatefulWidget {
  Function(int, String) changePageIndex;
  ComTypes({super.key, required this.changePageIndex});

  @override
  State<ComTypes> createState() => _ComTypesState();
}

class _ComTypesState extends State<ComTypes> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ComTypeStyle(
            imagePath: 'images/comType1.png',
            title: 'Student, Intern and Community Service Doctors',
            description:
                'Explore a wealth of resources tailored to medical students, interns, and those in community service. Here, youll find study materials, internship opportunities, and a supportive community to guide you through your training journey.',
            changePageIndex: () {
              widget.changePageIndex(
                  1, "A - Student, Intern and Community Service Doctors");
            },
            forumPage: () {
              widget.changePageIndex(
                  2, "A - Student, Intern and Community Service Doctors");
            },
          ),
          ComTypeStyle(
            imagePath: 'images/comType2.png',
            title: 'Employed Private and Public Medical Practitioners',
            description:
                'Join a vibrant community dedicated to private and public sector healthcare professionals. Access the latest job opportunities, learn about best practices, and stay updated on healthcare policies and regulations. Connect with peers and enhance your professional growth.',
            changePageIndex: () {
              widget.changePageIndex(
                  1, "B - Employed Private and Public Medical Practitioners");
            },
            forumPage: () {
              widget.changePageIndex(
                  2, "B - Employed Private and Public Medical Practitioners");
            },
          ),
          ComTypeStyle(
            imagePath: 'images/comType3.png',
            title: 'Private Practice Medical Practitioners',
            description:
                'Discover essential resources for managing and growing your private medical practice. From billing and insurance guidance to marketing strategies, this section offers everything you need to succeed as an independent practitioner. Connect with other private practitioners and share insights.',
            changePageIndex: () {
              widget.changePageIndex(
                  1, "C - Private Practice Medical Practitioners");
            },
            forumPage: () {
              widget.changePageIndex(
                  2, "C - Private Practice Medical Practitioners");
            },
          ),
          ComTypeStyle(
            imagePath: 'images/comType4.png',
            title: 'Registrars',
            description:
                'Welcome, future specialists! This section provides you with comprehensive educational materials, career guidance, and networking opportunities. Connect with experienced specialists, explore different fields, and advance your career with the support of a dedicated community.',
            changePageIndex: () {
              widget.changePageIndex(1, "D - Registrars");
            },
            forumPage: () {
              widget.changePageIndex(2, "D - Registrars");
            },
          ),
          ComTypeStyle(
            imagePath: 'images/comType5.png',
            title: 'Specialist',
            description:
                'For those at the pinnacle of their medical careers, this segment offers advanced research, in-depth case studies, and forums for knowledge sharing. Join a network of experts, contribute to cutting-edge discussions, and stay ahead in your specialty.',
            changePageIndex: () {
              widget.changePageIndex(1, "E - Specialist");
            },
            forumPage: () {
              widget.changePageIndex(2, "E - Specialist");
            },
          ),
          ComTypeStyle(
            imagePath: 'images/comType6.png',
            title: 'Corporate and Self Employed Doctors',
            description:
                'Navigate the intersection of medicine and business with our resources tailored to corporate and entrepreneurial doctors. Access business insights, network with like-minded professionals, and stay informed about the latest healthcare trends and innovations.',
            changePageIndex: () {
              widget.changePageIndex(
                  1, "F - Corporate and Self Employed Doctors");
            },
            forumPage: () {
              widget.changePageIndex(
                  2, "F - Corporate and Self Employed Doctors");
            },
          ),
          ComTypeStyle(
            imagePath: 'images/comType7.png',
            title: 'Research and Academia',
            description:
                'Dive into the world of medical research and academia. Explore a rich repository of research publications, educational resources, and collaborative tools designed to foster academic growth and innovation. Connect with peers and push the boundaries of medical knowledge.',
            changePageIndex: () {
              widget.changePageIndex(1, "G - Research and Academia");
            },
            forumPage: () {
              widget.changePageIndex(2, "G - Research and Academia");
            },
          ),
          ComTypeStyle(
            imagePath: 'images/comType8.png',
            title: 'Retirees',
            description:
                'Stay connected and engaged even in retirement. This section provides resources on retirement planning, post-retirement opportunities, and ways to stay involved in the medical community. Share your wisdom and continue contributing to the field in meaningful ways.',
            changePageIndex: () {
              widget.changePageIndex(1, "H - Retirees");
            },
            forumPage: () {
              widget.changePageIndex(2, "H - Retirees");
            },
          ),
        ],
      ),
    );
  }
}
