import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../components/myutility.dart';
import '../../../../../components/styleButton.dart';

class ComTypeStyle extends StatefulWidget {
  String imagePath;
  String title;
  String description;
  VoidCallback changePageIndex;
  ComTypeStyle(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.description,
      required this.changePageIndex});

  @override
  State<ComTypeStyle> createState() => _ComTypeStyleState();
}

class _ComTypeStyleState extends State<ComTypeStyle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MyUtility(context).width / 1.2,
        height: 320,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color(0xFFD1D1D1),
            )),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.imagePath),
                        fit: BoxFit.contain,
                      ),
                    ),
                    width: MyUtility(context).width / 7,
                    height: 200,
                  ),
                  SizedBox(
                    width: 35,
                  ),
                  SizedBox(
                    width: MyUtility(context).width / 1.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.title}',
                          style: const TextStyle(
                              fontSize: 25,
                              color: Colors.teal,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '${widget.description}',
                          style:
                              const TextStyle(fontSize: 22, color: Colors.grey),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  StyleButton(
                      buttonColor: Colors.teal,
                      description: "Resources",
                      height: 55,
                      width: 125,
                      onTap: () {
                        widget.changePageIndex();
                      }),
                  SizedBox(
                    width: 15,
                  ),
                  StyleButton(
                      buttonColor: Colors.teal,
                      description: "Discussions",
                      height: 55,
                      width: 125,
                      onTap: () {})
                ],
              ),
              /*   */
            ],
          ),
        ),
      ),
    );
  }
}
