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
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua eiusmod tempor incididunt ut labore et dolore magna aliqua',
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
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua eiusmod tempor incididunt ut labore et dolore magna aliqua',
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
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua eiusmod tempor incididunt ut labore et dolore magna aliqua',
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
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua eiusmod tempor incididunt ut labore et dolore magna aliqua',
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
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua eiusmod tempor incididunt ut labore et dolore magna aliqua',
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
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua eiusmod tempor incididunt ut labore et dolore magna aliqua',
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
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua eiusmod tempor incididunt ut labore et dolore magna aliqua',
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
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua eiusmod tempor incididunt ut labore et dolore magna aliqua',
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
