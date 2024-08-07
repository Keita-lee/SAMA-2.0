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
              imagePath: 'images/com1.png',
              title: 'Student, Intern and Community Service Doctors',
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua eiusmod tempor incididunt ut labore et dolore magna aliqua',
              changePageIndex: () {
                widget.changePageIndex(
                    1, "A - Student, Intern and Community Service Doctors");
              }),
          ComTypeStyle(
              imagePath: 'images/com2.png',
              title: 'Employed Private and Public Medical Practitioners',
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua eiusmod tempor incididunt ut labore et dolore magna aliqua',
              changePageIndex: () {
                widget.changePageIndex(
                    1, "B - Employed Private and Public Medical Practitioners");
              }),
          ComTypeStyle(
              imagePath: 'images/com3.png',
              title: 'Private Practice Medical Practitioners',
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua eiusmod tempor incididunt ut labore et dolore magna aliqua',
              changePageIndex: () {
                widget.changePageIndex(
                    1, "C - Private Practice Medical Practitioners");
              }),
          ComTypeStyle(
              imagePath: 'images/com4.png',
              title: 'Registrars',
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua eiusmod tempor incididunt ut labore et dolore magna aliqua',
              changePageIndex: () {
                widget.changePageIndex(1, "D - Registrars");
              }),
          ComTypeStyle(
              imagePath: 'images/com5.png',
              title: 'Specialist',
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua eiusmod tempor incididunt ut labore et dolore magna aliqua',
              changePageIndex: () {
                widget.changePageIndex(1, "E - Specialist");
              }),
          ComTypeStyle(
              imagePath: 'images/com6.png',
              title: 'Corporate and Self Employed Doctors',
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua eiusmod tempor incididunt ut labore et dolore magna aliqua',
              changePageIndex: () {
                widget.changePageIndex(
                    1, "F - Corporate and Self Employed Doctors");
              }),
          ComTypeStyle(
              imagePath: 'images/com7.png',
              title: 'Research and Academia',
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua eiusmod tempor incididunt ut labore et dolore magna aliqua',
              changePageIndex: () {
                widget.changePageIndex(1, "G - Research and Academia");
              }),
          ComTypeStyle(
              imagePath: 'images/com8.png',
              title: 'Retirees',
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua eiusmod tempor incididunt ut labore et dolore magna aliqua',
              changePageIndex: () {
                widget.changePageIndex(1, "H - Retirees");
              }),
        ],
      ),
    );
  }
}
