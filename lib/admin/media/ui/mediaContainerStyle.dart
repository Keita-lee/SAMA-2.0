import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/member/media/mediaPopup/ui/youtubeVideoPlayer.dart';

class MediaContainerStyle extends StatefulWidget {
  String adminType;

  String image;
  String duration;
  String releaseDate;
  //String date;
  String category;
  String title;
  String id;
  final VoidCallback? onpress;
  final VoidCallback? view;
  MediaContainerStyle(
      {super.key,
      // required this.date,
      required this.adminType,
      required this.image,
      required this.duration,
      required this.releaseDate,
      required this.category,
      required this.onpress,
      required this.title,
      required this.id,
      required this.view});

  @override
  State<MediaContainerStyle> createState() => _MediaContainerStyleState();
}

class _MediaContainerStyleState extends State<MediaContainerStyle> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    var width = MyUtility(context).width;
    var height = MyUtility(context).height;

    return Container(
      
      width: isMobile ? width : 360,
      height: isMobile ? 335 : 340,
      child: Padding(
        padding: isMobile
            ? EdgeInsets.fromLTRB(0, 0, 0, 10)
            : EdgeInsets.fromLTRB(0, 10, 30, 10),
        child: Column(
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: widget.image == "" ? true : false,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/imageIcon.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                width: isMobile ? width : 300,
                height: isMobile ? 180 : 200,
              ),
            ),

            Visibility(
              visible: widget.image != "" ? true : false,
              child: Container(
                width: isMobile ? width : 350,
                height: isMobile ? 180 : 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ClipRRect(
                  child: ImageNetwork(
                    image: widget.image,
                    fitWeb: BoxFitWeb.contain,
                    width: isMobile ? width : 350,
                    height: isMobile ? 180 : 200,
                  ),
                ),
              ),
            ),

            Text(
              "${widget.releaseDate}",
              style: TextStyle(
                  fontSize: isMobile ? 16 : 12,
                  letterSpacing: 1.2,
                  color: Color.fromARGB(148, 158, 158, 158),
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: MediaQuery.of(context).size.width > 600
                  ? EdgeInsets.zero
                  : const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: isMobile ? 18 : 16,
                  height: 1,
                  color: Color(0xFF3D3D3D),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: isMobile ? TextAlign.center : TextAlign.left,
              ),
            ),

            Spacer(),

            SizedBox(
              height: 10,
            ),

            Visibility(
              visible: widget.adminType != "true" ? true : false,
              child: Row(
                mainAxisAlignment: isMobile
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  StyleButton(
                    buttonColor: Color.fromRGBO(0, 159, 158, 1),
                    onTap: () {
                      widget.view!();
                    },
                    description: 'Play',
                    height: 38,
                    fontSize: 14,
                    width: 110,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: widget.adminType == "true" ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  StyleButton(
                    buttonColor: Color.fromRGBO(0, 159, 158, 1),
                    onTap: () {
                      widget.onpress!();
                    },
                    description: 'Edit',
                    height: 38,
                    fontSize: 14,
                    width: 110,
                  ),
                ],
              ),
            ),

            /*    StyleButton(
                      onTap: () {
                        widget.view!();
                      },
                      description: 'View',
                      height: 55,
                      width: MyUtility(context).width * 0.17,
                    ),*/
            /*  Container(
              width: MyUtility(context).width / 4.0,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFD1D1D1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ImageNetwork(
                  image: widget.image,
                  fitWeb: BoxFitWeb.fill,
                  width: MyUtility(context).width / 4.0,
                  height: 250,
                ),
              ),
            ),*/

            // Visibility(
            //   //visible: widget.adminType == "true" ? false : true,
            //   child: Padding(
            //     padding: const EdgeInsets.only(bottom: 10),
            //     child: SizedBox(
            //       width: MyUtility(context).width / 4.7,
            //       child: Align(
            //         alignment: Alignment.centerLeft,
            //         child: Container(
            //           width: MyUtility(context).width / 4.7,
            //           height: 50,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             color: Color(0xFF174486),
            //           ),
            //           child: TextButton(
            //             onPressed: () {
            //               widget.view!();
            //             },
            //             child: Text(
            //               'View',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 16,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            /*Visibility(
              child: Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  width: MyUtility(context).width / 4.7,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: MyUtility(context).width / 4.7,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF174486),
                      ),
                      child: TextButton(
                        onPressed: () {
                            widget.onpress!();
                          },
                        child: Text(
                          'Edit',
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
            ),*/
          ],
        ),
      ),
    );
  }
}
