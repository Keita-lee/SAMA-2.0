import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/member/professionalDevelopment/professionalDevelopmentMainCon.dart';
import 'package:url_launcher/url_launcher.dart';

class professionalDevelopmentDisplayItem extends StatefulWidget {
  final Function(CourseModel) onPressed;
  final String imageUrl;
  final String title;
  final String cpdPoints;
  final String level;
  final String subDescription;
  final CourseModel course;
  final String? startAssessment;

  const professionalDevelopmentDisplayItem({
    super.key,
    required this.onPressed,
    required this.imageUrl,
    required this.title,
    required this.cpdPoints,
    required this.level,
    required this.subDescription,
    required this.course,
    this.startAssessment,
  });

  @override
  State<professionalDevelopmentDisplayItem> createState() =>
      _professionalDevelopmentDisplayItemState();
}

class _professionalDevelopmentDisplayItemState
    extends State<professionalDevelopmentDisplayItem> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    String image = widget.imageUrl;
    String title = widget.title;
    String points = widget.cpdPoints;
    String level = widget.level;

    return SizedBox(
      width: isMobile ? MyUtility(context).width : MyUtility(context).width / 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: image == "" ? true : false,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/imageIcon.png"),
                  fit: BoxFit.contain,
                ),
              ),
              width: isMobile
                  ? MyUtility(context).width
                  : MyUtility(context).width * 0.3,
              height: isMobile
                  ? MyUtility(context).height / 3.5
                  : MyUtility(context).height / 3,
            ),
          ),
          Visibility(
            visible: image != "" ? true : false,
            child: ImageNetwork(
              fitWeb: BoxFitWeb.contain,
              image: image,
              width: isMobile
                  ? MyUtility(context).width
                  : MyUtility(context).width / 10,
              height: isMobile
                  ? MyUtility(context).height / 3.5
                  : MyUtility(context).height / 2.8,
            ),
          ),
          SizedBox(
            height: isMobile ? 2 : 20,
          ),
          SizedBox(
            width: isMobile
                ? MyUtility(context).width
                : MyUtility(context).width * 0.70 - 280,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: null,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  points,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(146, 146, 147, 1)),
                ),
                Text(
                  level,
                  maxLines: null,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(146, 146, 147, 1)),
                ),
                StyleButton(
                  fontSize: 13,
                  description:
                      widget.startAssessment != null ? 'Start' : 'Read More',
                  height: 40,
                  width: 110,
                  buttonTextColor: Colors.white,
                  buttonColor: const Color.fromRGBO(0, 159, 159, 1),
                  onTap: () {
                    //   final Uri a = Uri.parse(widget.subDescription);

                    //  launchUrl(a);
                    widget.onPressed(widget.course);
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
