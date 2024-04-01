import 'package:flutter/material.dart';
import 'package:sama/components/greybutton.dart';
import 'package:sama/components/myutility.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostLoginLeft extends StatefulWidget {
  const PostLoginLeft({super.key});

  @override
  State<PostLoginLeft> createState() => _PostLoginLeftState();
}

class _PostLoginLeftState extends State<PostLoginLeft> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width / 6.5,
      height: MyUtility(context).height / 1.2,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xFFD1D1D1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MyUtility(context).height * 0.025,
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.star),
            label: Text(
              'Centre of Excellence',
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6A6A6A),
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.school),
            label: Text(
              'Professional Development & Mentorship',
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6A6A6A),
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
            label: Text(
              'E-Store',
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6A6A6A),
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.newspaper),
            label: Text(
              'News Article',
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6A6A6A),
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: MyUtility(context).height * 0.025,
          ),
          /*GreyButton(buttonText: 'Dashboard', onPressed: () {}),
          GreyButton(
              buttonText: 'Student, Inters & Com Serv', onPressed: () {}),
          GreyButton(buttonText: "Private & Public MP's", onPressed: () {}),
          GreyButton(buttonText: "Private Practice MP's", onPressed: () {}),
          GreyButton(buttonText: 'Registrars', onPressed: () {}),
          GreyButton(buttonText: 'Specialists', onPressed: () {}),
          GreyButton(
              buttonText: 'Corportate & Entrepreneurial Doctors',
              onPressed: () {}),
          GreyButton(buttonText: 'Retirees', onPressed: () {}),
          GreyButton(buttonText: 'Research and Academics', onPressed: () {}),*/
          SizedBox(
            height: MyUtility(context).height * 0.05,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SizedBox(
              width: MyUtility(context).width * 0.13,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFBC82D),
                    ),
                    child: ClipOval(
                      child: Transform.scale(
                        scale: 0.6, // Adjust the scale factor as needed
                        child: SvgPicture.asset(
                          'images/lifebuoy.svg',
                          color: Color(0xFF174486),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MyUtility(context).height * 0.01,
                  ),
                  Text(
                    'Need Help?',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF174486),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MyUtility(context).height * 0.01,
                  ),
                  Text(
                    'Our friendly SAMA Bot Assistant is ready to assist you right now.',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        letterSpacing: -0.05,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.5),
                  ),
                  SizedBox(
                    height: MyUtility(context).height * 0.01,
                  ),
                  Text(
                    "If you don't get what you are looking for, your query will be routed to someone who can help you.",
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        letterSpacing: -0.05,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.5),
                  ),
                  SizedBox(
                    height: MyUtility(context).height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {},
                    behavior: HitTestBehavior.translucent,
                    child: Text(
                      "Chat Now",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        letterSpacing: -0.05,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.5,
                        decoration: TextDecoration.underline, // Underline text
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
