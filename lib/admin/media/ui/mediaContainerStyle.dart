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
      width: 315,
      height: 335,
      
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 30, 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
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
                width: 300,
                height: 200,
              ),
            ),

            Visibility(
              visible: widget.image != "" ? true : false,
              child: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  
                  color: Color(0xFFD1D1D1),
                ),
                child: ClipRRect(
                  
                  child: ImageNetwork(
                    image: widget.image,
                    fitWeb: BoxFitWeb.fill,
                    width: 300,
                    height: 200,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            //TO DO IMPLEMENT DATE OF VIDEO POSTED//////
            Text(
              '21 Jyly 2024',
              style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 1.2,
                  color: Color.fromARGB(148, 158, 158, 158),
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10,),
            Text(
              (widget.title),
              style: TextStyle(
                  fontSize: 16,
                  height: 1,
                  color: Color(0xFF3D3D3D),
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
           /* Padding(
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
            ),*/

            SizedBox(
              height: 10,
            ),

            Visibility(
              visible: widget.adminType != "true" ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
