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
  String category;
  String title;
  String id;
  final VoidCallback? onpress;
  final VoidCallback? view;
  MediaContainerStyle(
      {super.key,
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
  //get date in string
  String _formatDateTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String dayNumber = DateFormat('dd').format(dateTime);

    String month = DateFormat('MMMM').format(dateTime);
    String year = DateFormat('yyyy').format(dateTime);

    return '$dayNumber $month $year ';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width / 4.4,
      height: 425,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Color(0xFFD1D1D1),
          )),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Column(
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
                width: MyUtility(context).width / 4.0,
                height: 200,
              ),
            ),

            Visibility(
              visible: widget.image != "" ? true : false,
              child: Container(
                width: MyUtility(context).width / 4.0,
                height: 200,
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
                    height: 200,
                  ),
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              height: 85,
              child: Text(
                (widget.title),
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF3D3D3D),
                    fontWeight: FontWeight.normal),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Row(
                children: [
                  Text(
                    (widget.category),
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF3D3D3D),
                        fontWeight: FontWeight.normal),
                  ),
                  Spacer(),
                  Text(
                    (widget.duration),
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF3D3D3D),
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Visibility(
              visible: widget.adminType != "true" ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyleButton(
                    onTap: () {
                      widget.view!();
                    },
                    description: 'View',
                    height: 55,
                    width: MyUtility(context).width * 0.17,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: widget.adminType == "true" ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyleButton(
                    onTap: () {
                      widget.onpress!();
                    },
                    description: 'Edit',
                    height: 55,
                    width: MyUtility(context).width * 0.17,
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
