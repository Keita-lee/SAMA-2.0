import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

import '../../../components/myutility.dart';

class MyCPDdisplayItem extends StatefulWidget {
  final String image;
  final String productName;
  final String productDetails;
  final String points;
  final String difficultyLevel;
  final Function() onTap;
  final double progress;
  const MyCPDdisplayItem(
      {super.key,
      required this.image,
      required this.productName,
      required this.productDetails,
      required this.points,
      required this.difficultyLevel, required this.onTap, required this.progress});

  @override
  State<MyCPDdisplayItem> createState() => _MyCPDdisplayItemState();
}

class _MyCPDdisplayItemState extends State<MyCPDdisplayItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
       width: 250,
      height:  355,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 250,
            // width: MyUtility(context).width / 5.6,
            height: 200,
            decoration: BoxDecoration(
              color: Color(0xFFD1D1D1),
            ),
            /*child: ClipRRect(
                child: ImageNetwork(
              image: widget.image,
              fitWeb: BoxFitWeb.cover,
              width: 250,
              //width: MyUtility(context).width / 5.6,
              height: 200,
            )),*/
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MyUtility(context).width / 5.2,
            //height: 60,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3D3D3D),
                ),
                children: [
                  TextSpan(
                    text: widget.productName,
                  ),
                  TextSpan(
                    text: widget.productDetails,
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MyUtility(context).width / 5.6,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: widget.points,
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(148, 158, 158, 158),
                    ),
                  ),
                  TextSpan(
                    text: '\n${widget.difficultyLevel}',
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(148, 158, 158, 158),
                    ),
                  ),
                ],
              ),
            ),
          ),
           SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MyUtility(context).width / 4.7,
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(20),
              minHeight: 5,
              value: widget.progress,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(237, 157, 4, 1)),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: SizedBox(
              width: MyUtility(context).width / 4.7,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromRGBO(0, 159, 158, 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextButton(
                      onPressed: widget.onTap,
                      child: Text(
                        'Access',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
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
