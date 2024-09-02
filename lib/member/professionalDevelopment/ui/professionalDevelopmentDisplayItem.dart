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

  const professionalDevelopmentDisplayItem(
      {super.key,
      required this.onPressed,
      required this.imageUrl,
      required this.title,
      required this.cpdPoints,
      required this.level,
      required this.subDescription});

  @override
  State<professionalDevelopmentDisplayItem> createState() =>
      _professionalDevelopmentDisplayItemState();
}

class _professionalDevelopmentDisplayItemState
    extends State<professionalDevelopmentDisplayItem> {
  @override
  Widget build(BuildContext context) {
    String image = widget.imageUrl;
    String title = widget.title;
    String points = widget.cpdPoints;
    String level = widget.level;

    return SizedBox(
      width: MyUtility(context).width / 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: image == "" ? true : false,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/imageIcon.png"),
                  fit: BoxFit.cover,
                ),
              ),
              width: MyUtility(context).width * 0.2,
              height: MyUtility(context).width * 0.18,
            ),
          ),
          Visibility(
            visible: image != "" ? true : false,
            child: ImageNetwork(
              fitWeb: BoxFitWeb.contain,
              image: image,
              width: MyUtility(context).width * 0.2,
              height: MyUtility(context).width * 0.14,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MyUtility(context).width * 0.70 - 280,
            height: 150,
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
                const SizedBox(height: 20),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      StyleButton(
                        fontSize: 13,
                        description: 'Read More',
                        height: 40,
                        width: 110,
                        buttonTextColor: Colors.white,
                        buttonColor: const Color.fromRGBO(0, 159, 159, 1),
                        onTap: () {
                          final Uri a = Uri.parse(widget.subDescription);

                          launchUrl(a);
                          // widget.onPressed(widget.course);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
