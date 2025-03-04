import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sama/components/mobile/components/Themes/font_text.dart';

import '../../../../../components/myutility.dart';
import '../../../../../components/styleButton.dart';

class ComTypeStyle extends StatefulWidget {
  String imagePath;
  String title;
  String description;
  VoidCallback changePageIndex;
  VoidCallback forumPage;
  ComTypeStyle(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.description,
      required this.changePageIndex,
      required this.forumPage});

  @override
  State<ComTypeStyle> createState() => _ComTypeStyleState();
}

class _ComTypeStyleState extends State<ComTypeStyle> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;

    if (isMobile) {
      return Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
              width: MyUtility(context).width,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color(0xFFD1D1D1),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.imagePath),
                        fit: BoxFit.contain,
                      ),
                    ),
                    width: MyUtility(context).width - 25,
                    height: 130,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${widget.title}',
                    style: FontText(context).mediumBlue,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${widget.description}',
                    style: FontText(context).bodySmallGrey,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          onTap: () {
                            widget.forumPage();
                          })
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              )));
    } else {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: MyUtility(context).width / 1.3,
          height: 245,
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
                      width: MyUtility(context).width / 10,
                      height: 130,
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    SizedBox(
                      width: MyUtility(context).width / 1.95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.title}',
                            style: const TextStyle(
                                fontSize: 23,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${widget.description}',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.grey),
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
                        onTap: () {
                          widget.forumPage();
                        })
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
}
