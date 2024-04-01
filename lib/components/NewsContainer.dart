import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class NewsContainer extends StatefulWidget {
  final String image;
  final String category;
  final String date;
  final String header;
  final VoidCallback onPressed;

  const NewsContainer(
      {super.key,
      required this.image,
      required this.category,
      required this.date,
      required this.header,
      required this.onPressed});

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width * 0.25,
      height: MyUtility(context).height * 0.6,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Color(0xFFD1D1D1),
          )),
      child: Column(
        children: [
          SizedBox(
            height: MyUtility(context).height * 0.035,
          ),
          Container(
            width: MyUtility(context).width * 0.215,
            height: MyUtility(context).height * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFD1D1D1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: MyUtility(context).height * 0.035,
          ),
          SizedBox(
            width: MyUtility(context).width / 4.5,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: widget.category,
                    style: TextStyle(
                      color: Color(0xFF174486),
                    ),
                  ),
                  TextSpan(
                    text: ' | ',
                  ),
                  TextSpan(
                    text: widget.date,
                    style: TextStyle(
                      color: Color(0xFF3D3D3D),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MyUtility(context).height * 0.035,
          ),
          SizedBox(
            width: MyUtility(context).width / 4.5,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 22,
                  color: Color(0xFF3D3D3D),
                ),
                children: [
                  TextSpan(
                    text: widget.header,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MyUtility(context).height * 0.035,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: SizedBox(
              width: MyUtility(context).width / 4.5,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MyUtility(context).width * 0.3,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF174486),
                  ),
                  child: TextButton(
                    onPressed: widget.onPressed,
                    child: Text(
                      'Access',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
